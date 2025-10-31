
# EK307 / FPGA Verilog Counter Lab — Part 1 Summary

## Objective

Design a top-level Verilog system that increments an 8-bit counter **once per button press**, debouncing mechanical noise and displaying the result on LEDs.

---

## Architecture Overview

### System Block Diagram

button_in ─→ [Synchronizer 2FF] ─→ [Debouncer] ─→ [Edge Detector] ─→ [Counter] ─→ LEDs[7:0]

- **Clock:** 100 MHz system clock
- **Reset:** active-low (reset_n)
- **Functionality:** Each press of a push-button increases an 8-bit counter by 1.  
  LEDs display the counter value in binary.

---

## Modules Implemented

### 1. sync_2ff.v

Purpose: Synchronizes asynchronous button input to the system clock domain to prevent metastability.

verilog
module sync_2ff (
    input  wire clk,
    input  wire reset_n,
    input  wire d_async,
    output reg  q_sync
);
    reg q1;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q1     <= 1'b0;
            q_sync <= 1'b0;
        end else begin
            q1     <= d_async;
            q_sync <= q1;
        end
    end
endmodule

---

### 2. debouncer.v

Purpose: Filters out mechanical button bounce by requiring the input to remain stable for a fixed time (e.g., 20 ms at 100 MHz).

verilog
module debouncer #(
    parameter integer COUNT_MAX = 2_000_000  // ~20 ms @ 100 MHz
)(
    input  wire clk,
    input  wire reset_n,
    input  wire noisy_in,
    output reg  clean_out
);
    reg [$clog2(COUNT_MAX):0] counter;
    reg stable_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stable_state <= 1'b0;
            clean_out    <= 1'b0;
            counter      <= '0;
        end else begin
            if (noisy_in == stable_state)
                counter <= '0;
            else begin
                counter <= counter + 1'b1;
                if (counter >= COUNT_MAX) begin
                    stable_state <= noisy_in;
                    clean_out    <= noisy_in;
                    counter      <= '0;
                end
            end
        end
    end
endmodule

- COUNT_MAX sets debounce time (20 ms typical).
- Output clean_out represents the *debounced level* (steady high or low).

---

### 3. edge_detect.v

Purpose: Converts a steady level into a one-clock pulse on a **rising edge** (button press).

verilog
module edge_detect (
    input  wire clk,
    input  wire reset_n,
    input  wire level_in,
    output reg  pulse_out
);
    reg level_dly;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            level_dly <= 1'b0;
            pulse_out <= 1'b0;
        end else begin
            level_dly <= level_in;
            pulse_out <= level_in & ~level_dly; // 1-cycle pulse
        end
    end
endmodule

- Input: level_in (debounced signal)
- Output: pulse_out (1-clock-wide pulse on rising edge)

---

### 4. counter8.v

Purpose: Increments an 8-bit counter on each pulse and outputs to LEDs.

verilog
module counter8 (
    input  wire       clk,
    input  wire       reset_n,
    input  wire       inc_pulse,
    output reg [7:0]  count
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            count <= 8'd0;
        else if (inc_pulse)
            count <= count + 8'd1;
    end
endmodule

- Asynchronous active-low reset clears counter to 0.
- Counter naturally wraps from 255 → 0.

---

### 5. top_module.v

Purpose: Integrates all submodules.
Handles button input, debouncing, pulse generation, counting, and LED output.

verilog
module top_module (
    input  wire       clk_100mhz,
    input  wire       reset_n,
    input  wire       button_in,
    output wire [7:0] led
);
    // 1. Synchronize external button
    wire btn_sync;
    sync_2ff u_sync (
        .clk     (clk_100mhz),
        .reset_n (reset_n),
        .d_async (button_in),
        .q_sync  (btn_sync)
    );

    // 2. Debounce the synchronized button
    wire btn_debounced;
    debouncer #(.COUNT_MAX(2_000_000)) u_db (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .noisy_in  (btn_sync),
        .clean_out (btn_debounced)
    );

    // 3. Detect rising edge (button press)
    wire inc_pulse;
    edge_detect u_edge (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .level_in  (btn_debounced),
        .pulse_out (inc_pulse)
    );

    // 4. 8-bit counter
    wire [7:0] count;
    counter8 u_counter (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .inc_pulse (inc_pulse),
        .count     (count)
    );

    // 5. Drive LEDs with counter output
    assign led = count;

endmodule

---

## Functional Flow Summary

1. **Raw button input** → asynchronous, may cause metastability.
2. **Synchronizer** aligns the signal to the system clock domain.
3. **Debouncer** filters short glitches and ensures stable transitions.
4. **Edge detector** generates a single pulse for each press.
5. **Counter** increments once per pulse.
6. **LEDs** show the 8-bit binary value of the counter.

---

## Implementation Notes

- Clock: 100 MHz FPGA oscillator.
- Reset: Active-low asynchronous (reset_n).
- Debounce time: ≈ 20 ms (adjustable via COUNT_MAX).
- Counter wraps at 255.
- Use FPGA board’s btnU or similar for button input.
- LEDs [7:0] show the count (LSB on led[0]).

---

## Future Parts / Possible Extensions

- Add a **decrement button** with identical debounce path.
- Add **7-segment display** output.
- Add a **clock enable** divider if running on a slower LED update rate.
- Integrate with Part 2 (FSM or state logic, if required by lab).

---

## Status

✅ Completed:

- System architecture
- All Verilog modules (sync, debouncer, edge detect, counter, top)
- Explained metastability and debounce concepts
- Verified inter-module signal flow matches provided block diagram

---

*Author: Giacomo Cappelletto*
*Platform: Nexys-A7 (100 MHz clock)*
*Course: EK307 – Electric Circuits / Logic Design – Part 1 Lab*
