"""
Main orchestration for Deskinator robot.

Coordinates sensing, mapping, and control loops using asyncio.
"""

import asyncio
import time
import signal
import sys
from typing import List, Tuple

from .config import PINS, I2C, GEOM, LIMS, ALG
from .hw.gpio import gpio_manager
from .hw.stepper import StepperDrive
from .hw.vacuum import Vacuum
from .hw.i2c import I2CBus
from .hw.tca9548a import TCA9548A
from .hw.apds9960 import APDS9960
from .hw.bno085 import BNO085
from .slam.ekf import EKF
from .slam.posegraph import PoseGraph
from .slam.rect_fit import RectangleFit
from .slam.frames import transform_point
from .planning.coverage import CoveragePlanner
from .planning.map2d import SweptMap
from .control.fsm import SupervisorFSM, RobotState
from .control.motion import MotionController
from .control.limits import VelocityLimiter
from .utils.logs import TelemetryLogger
from .utils.viz import Visualizer
from .utils.timing import RateTimer, LoopTimer


class Deskinator:
    """Main robot controller."""

    def __init__(self, enable_viz: bool = False):
        """
        Initialize Deskinator.

        Args:
            enable_viz: Enable real-time visualization
        """
        print("=" * 60)
        print("Deskinator - Autonomous Desk Cleaning Robot")
        print("=" * 60)

        # Hardware
        print("[Init] Initializing hardware...")
        self.stepper = StepperDrive()
        self.vacuum = Vacuum()

        # I2C devices
        self.i2c = I2CBus(I2C.BUS)
        self.mux = TCA9548A(self.i2c, I2C.ADDR_MUX)

        # Proximity sensors
        self.sensors = []
        for i, chan in enumerate(I2C.MUX_CHANS):
            self.mux.select(chan)
            sensor = APDS9960(self.i2c, I2C.APDS_ADDR)
            sensor.init()
            self.sensors.append(sensor)
            print(f"  APDS9960 #{i} on MUX channel {chan}")

        self.mux.select(None)

        # IMU
        self.imu = BNO085(self.i2c, I2C.ADDR_IMU)
        print(f"  BNO085 IMU initialized")

        # State estimation
        print("[Init] Initializing SLAM...")
        self.ekf = EKF()
        self.pose_graph = PoseGraph()
        self.rect_fit = RectangleFit()

        # Planning
        self.coverage_planner = CoveragePlanner()
        self.swept_map = SweptMap()

        # Control
        print("[Init] Initializing control...")
        self.fsm = SupervisorFSM()
        self.motion = MotionController()
        self.limiter = VelocityLimiter()

        # Logging and visualization
        self.logger = TelemetryLogger()
        self.visualizer = Visualizer() if enable_viz else None

        # State
        self.running = False
        self.edge_debounce_time = {}
        self.last_node_pose = (0.0, 0.0, 0.0)

        # Timers
        self.sense_timer = LoopTimer("Sense")
        self.map_timer = LoopTimer("Map")
        self.ctrl_timer = LoopTimer("Control")

        print("[Init] Initialization complete")
        print("=" * 60)

    def scan_i2c(self):
        """Scan I2C bus and print devices."""
        print("[I2C] Scanning bus...")
        devices = self.i2c.scan()
        print(f"  Found {len(devices)} device(s):")
        for addr in devices:
            print(f"    0x{addr:02x}")

    def calibrate_sensors(self):
        """Calibrate proximity sensors."""
        print("[Calibrate] Calibrating proximity sensors...")
        print("  This will take about 5 seconds per sensor")

        for i, sensor in enumerate(self.sensors):
            self.mux.select(I2C.MUX_CHANS[i])
            print(f"\n  Sensor {i}:")
            sensor.calibrate(on_table_samples=10, off_table_samples=10)

        self.mux.select(None)
        print("\n[Calibrate] Calibration complete")

    def calibrate_imu(self):
        """Calibrate IMU bias."""
        print("[Calibrate] Calibrating IMU...")
        self.imu.bias_calibrate(duration=2.0)
        print("[Calibrate] IMU calibration complete")

    async def loop_sense(self):
        """Sensing loop @ 50 Hz."""
        rate = RateTimer(ALG.FUSE_HZ)

        while self.running:
            self.sense_timer.start()

            # Read odometry
            dSL, dSR = self.stepper.read_odometry()
            dt = 1.0 / ALG.FUSE_HZ

            # Read IMU
            yaw_rate = self.imu.read_yaw_rate()

            # Update EKF
            self.ekf.predict(dSL, dSR, dt)
            self.ekf.update_gyro(yaw_rate, dt)

            # Read proximity sensors
            sensor_readings = []
            for i, sensor in enumerate(self.sensors):
                self.mux.select(I2C.MUX_CHANS[i])
                reading = sensor.read_proximity_norm()
                sensor_readings.append(reading)

            self.mux.select(None)

            # Check for edge events (pair-based rule)
            self._check_edge_events(sensor_readings)

            # Store sensor context
            self.sensor_context = {"sensors": sensor_readings, "timestamp": time.time()}

            self.sense_timer.stop()
            rate.sleep()

    def _check_edge_events(self, sensors: List[float]):
        """Check for edge detection events."""
        current_time = time.time()

        # Left pair
        left_pair = [sensors[i] for i in I2C.LEFT_PAIR]
        left_off = all(s <= ALG.EDGE_THRESH for s in left_pair)

        # Right pair
        right_pair = [sensors[i] for i in I2C.RIGHT_PAIR]
        right_off = all(s <= ALG.EDGE_THRESH for s in right_pair)

        # Debounce
        if left_off:
            if "left" not in self.edge_debounce_time:
                self.edge_debounce_time["left"] = current_time
            elif current_time - self.edge_debounce_time["left"] > ALG.EDGE_DEBOUNCE:
                # Trigger edge event
                if not self.motion.edge_event_active:
                    print(f"[Edge] Left edge detected")
                    self.motion.handle_edge_event("left")
                    self._add_edge_points("left")
        else:
            if "left" in self.edge_debounce_time:
                del self.edge_debounce_time["left"]

        if right_off:
            if "right" not in self.edge_debounce_time:
                self.edge_debounce_time["right"] = current_time
            elif current_time - self.edge_debounce_time["right"] > ALG.EDGE_DEBOUNCE:
                # Trigger edge event
                if not self.motion.edge_event_active:
                    print(f"[Edge] Right edge detected")
                    self.motion.handle_edge_event("right")
                    self._add_edge_points("right")
        else:
            if "right" in self.edge_debounce_time:
                del self.edge_debounce_time["right"]

    def _add_edge_points(self, side: str):
        """Add edge detection points to map."""
        pose = self.ekf.pose()

        # Add points for the triggered sensor pair
        if side == "left":
            sensor_indices = I2C.LEFT_PAIR
        else:
            sensor_indices = I2C.RIGHT_PAIR

        for idx in sensor_indices:
            # Sensor position in robot frame
            sensor_pos = (GEOM.SENSOR_FWD, GEOM.SENSOR_LAT[idx])

            # Transform to world frame
            world_pos = transform_point(pose, sensor_pos)

            # Add to rectangle fit
            self.rect_fit.add_edge_point(world_pos)

            # Log
            self.logger.log_edge(time.time(), world_pos, pose)

    async def loop_map(self):
        """Mapping loop @ 20 Hz."""
        rate = RateTimer(20)
        optimize_counter = 0

        while self.running:
            self.map_timer.start()

            pose = self.ekf.pose()

            # Add pose graph nodes at regular intervals
            dx = pose[0] - self.last_node_pose[0]
            dy = pose[1] - self.last_node_pose[1]
            dist = (dx * dx + dy * dy) ** 0.5

            if dist >= ALG.NODE_SPACING:
                node_id = self.pose_graph.add_node(time.time(), pose)

                # Add odometry edge
                if node_id > 0:
                    # Compute relative pose
                    from .slam.frames import pose_difference

                    z_ij = pose_difference(self.last_node_pose, pose)

                    import numpy as np

                    Info = np.diag([100.0, 100.0, 50.0])
                    self.pose_graph.add_edge_odom(node_id - 1, node_id, z_ij, Info)

                self.last_node_pose = pose

            # Optimize periodically
            optimize_counter += 1
            if optimize_counter >= 100:  # Every 5 seconds
                self.pose_graph.optimize()
                optimize_counter = 0

            # Try rectangle fit
            if self.rect_fit.fit():
                if not self.fsm.rectangle_confident:
                    rect = self.rect_fit.get_rectangle()
                    if rect:
                        print(
                            f"[Map] Rectangle confident: {rect[3]:.2f} x {rect[4]:.2f} m"
                        )
                        self.fsm.rectangle_confident = True

                        # Build coverage lanes
                        self.coverage_planner.set_rectangle(rect)
                        lanes = self.coverage_planner.build_lanes()
                        print(f"[Map] Generated {len(lanes)} coverage lanes")

            self.map_timer.stop()
            rate.sleep()

    async def loop_ctrl(self):
        """Control loop @ 50 Hz."""
        rate = RateTimer(ALG.FUSE_HZ)
        last_v, last_omega = 0.0, 0.0

        while self.running:
            self.ctrl_timer.start()

            pose = self.ekf.pose()
            dt = 1.0 / ALG.FUSE_HZ

            # Handle edge events if active
            if self.motion.edge_event_active:
                v_cmd, omega_cmd = self.motion.update_edge_event(pose, dt)
            else:
                # Update FSM
                context = {
                    "start_signal": True,  # Auto-start for now
                    "rectangle_confident": self.fsm.rectangle_confident,
                    "coverage_ratio": (
                        self.swept_map.coverage_ratio(self.rect_fit.get_rectangle())
                        if self.rect_fit.is_confident
                        else 0.0
                    ),
                    "error": False,
                }

                state = self.fsm.update(context)

                # Generate motion commands based on state
                if state == RobotState.WAIT_START:
                    v_cmd, omega_cmd = 0.0, 0.0

                elif state == RobotState.BOUNDARY_DISCOVERY:
                    v_cmd, omega_cmd = self.motion.cmd_boundary(
                        pose, self.sensor_context
                    )

                elif state == RobotState.COVERAGE:
                    # Follow coverage path
                    lane = self.coverage_planner.get_current_lane()
                    if lane:
                        v_cmd, omega_cmd = self.motion.cmd_follow_path(
                            pose, lane, self.swept_map
                        )

                        # Check if lane complete
                        if self.motion.is_path_complete():
                            self.coverage_planner.advance_waypoint()
                    else:
                        v_cmd, omega_cmd = 0.0, 0.0

                elif state == RobotState.DONE:
                    v_cmd, omega_cmd = 0.0, 0.0

                else:
                    v_cmd, omega_cmd = 0.0, 0.0

            # Apply velocity limits
            v_limited, omega_limited = self.limiter.limit(v_cmd, omega_cmd, dt)

            # Command steppers
            self.stepper.command(v_limited, omega_limited)
            self.stepper.update(dt)

            # Update swept map (only for forward motion)
            if v_limited > 0:
                ds = v_limited * dt
                self.swept_map.add_forward_sweep(pose, ds)

            # Logging
            self.logger.log_telemetry(
                time.time(),
                pose,
                (v_limited, omega_limited),
                self.sensor_context.get("sensors", []),
                self.motion.edge_event_active,
                self.fsm.get_state().name,
            )

            # Visualization
            if self.visualizer:
                poses = self.pose_graph.get_all_poses()
                edge_points = self.rect_fit.edge_points
                rectangle = self.rect_fit.get_rectangle()
                coverage_grid = self.swept_map.get_grid()
                bounds = (
                    self.swept_map.min_x,
                    self.swept_map.max_x,
                    self.swept_map.min_y,
                    self.swept_map.max_y,
                )

                # Update every 10th iteration to reduce overhead
                if rate._last_time % 0.2 < 0.02:  # ~Every 0.2 seconds
                    self.visualizer.update(
                        poses, edge_points, rectangle, coverage_grid, bounds
                    )

            last_v, last_omega = v_limited, omega_limited

            self.ctrl_timer.stop()
            rate.sleep()

            # Check if done
            if self.fsm.is_done():
                print("[Main] Mission complete!")
                self.running = False

    async def run_async(self):
        """Run main control loops."""
        self.running = True

        # Turn on vacuum
        print("[Main] Starting vacuum")
        self.vacuum.on(duty=0.8)

        # Run loops concurrently
        try:
            await asyncio.gather(self.loop_sense(), self.loop_map(), self.loop_ctrl())
        except KeyboardInterrupt:
            print("\n[Main] Interrupted by user")
        finally:
            self.shutdown()

    def run(self):
        """Run robot (blocking)."""
        # Setup signal handler
        signal.signal(signal.SIGINT, self._signal_handler)

        print("[Main] Starting main loops...")
        print("  Press Ctrl+C to stop")

        # Run async event loop
        asyncio.run(self.run_async())

    def _signal_handler(self, signum, frame):
        """Handle interrupt signal."""
        print("\n[Main] Stopping...")
        self.running = False

    def shutdown(self):
        """Shutdown robot safely."""
        print("[Shutdown] Stopping robot...")

        self.running = False

        # Stop motors
        self.stepper.stop()
        self.stepper.stop_pulse_generation()

        # Stop vacuum
        self.vacuum.off()

        # Close logs
        self.logger.close()

        # Print timing stats
        print("\n[Timing] Loop statistics:")
        self.sense_timer.print_stats()
        self.map_timer.print_stats()
        self.ctrl_timer.print_stats()

        # Save visualization
        if self.visualizer:
            self.visualizer.save("output_map.png")
            self.visualizer.close()

        # Cleanup GPIO
        gpio_manager.cleanup()

        print("[Shutdown] Complete")


def main():
    """Main entry point."""
    import argparse

    parser = argparse.ArgumentParser(description="Deskinator Robot Controller")
    parser.add_argument("--viz", action="store_true", help="Enable visualization")
    parser.add_argument("--calibrate", action="store_true", help="Run calibration")
    parser.add_argument("--scan-i2c", action="store_true", help="Scan I2C bus")

    args = parser.parse_args()

    robot = Deskinator(enable_viz=args.viz)

    if args.scan_i2c:
        robot.scan_i2c()
        return

    if args.calibrate:
        robot.calibrate_imu()
        robot.calibrate_sensors()
        return

    # Run main loop
    robot.run()


if __name__ == "__main__":
    main()
