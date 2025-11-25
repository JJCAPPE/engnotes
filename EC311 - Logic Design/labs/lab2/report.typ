// ============================================
// EC311 - Vivado-Verilog Lab Report Template
// ============================================

// Page setup: 1-inch margins, 12pt font
#set page(
  paper: "us-letter",
  margin: 0.7in,
  numbering: "1",
)

#set text(
  font: "New Computer Modern", // Professional serif font
  size: 11pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
)

#set heading(numbering: "1.")

// ============================================
// TITLE PAGE / HEADER SECTION
// ============================================
#align(center)[
  #v(0.5em)
  #text(18pt, weight: "bold")[EC311 - Lab 2: Sequential Logic and 7-Segment Display]
  #v(0.3em)

  #grid(
    columns: auto,
    row-gutter: 0.3em,
    text(12pt)[*Student Name:* Giacomo Cappelletto],
    text(12pt)[*Student ID:* U91023753],
    text(12pt)[*Date:* #datetime.today().display("[month repr:long] [day], [year]")],
  )
  #v(0.8em)
]

#line(length: 100%, stroke: 0.5pt)
#v(0.8em)

// ============================================
// 1. OBJECTIVE
// ============================================
= Objective

This lab consists of two main parts:

*Part 1:* Design and implement a 8-bit counter system with proper button input handling, which included:
- A 2-flip-flop synchronizer to prevent metastability issues
- A debouncer to eliminate mechanical bounce from button presses
- A rising edge detector to generate clean single-cycle pulses
- An 8-bit counter that increments on each pulse (button press)
- LEDs to display the counter value in binary

*Part 2:* Extend the counter system to 16 bits and add 7-segment 4-bit hexadecimal display capability. The system must include:
- A 16-bit counter with dual operation modes (manual button and automatic 1Hz)
- Clock dividers to generate 1kHz and 1Hz clocks from the 100MHz system clock
- A display controller using time-division duty cycle multiplexing to drive four 7-segment displays
- A seven-segment decoder to convert hexadecimal digits to display patterns
- Proper signal conditioning (synchronization, debouncing, edge detection) for user inputs as in Part 1

Both parts must be implemented in Verilog, synthesized, and tested on the Nexys A7 FPGA board. Testbenches must be developed to verify functionality in simulation before hardware deployment.

// ============================================
// 2. METHODOLOGY
// ============================================
= Methodology

== Design Approach

The lab is divided into two parts, each building upon sequential logic design principles with increasing complexity. The overall design approach is a modular one, with each part being implemented as a separate module, and then integrated into a top level module.

=== Part 1: Button-Controlled 8-bit Counter

The design in Part 1 follows this signal conditioning pipeline:

1. *Synchronization:* The raw button input, which is asynchronous to the system clock, passes through a 2-flip-flop synchronizer. This prevents metastability issues that can occur when sampling asynchronous signals like mechanical buttons.

2. *Debouncing:* Mechanical buttons exhibit contact bounce, producing multiple transitions during a single press. A debouncer module filters these glitches by requiring the input to remain stable for approximately 20ms before propagating the change and signal onwards in the pipeline.

3. *Edge Detection:* To generate a single increment pulse per button press, a rising edge detector compares the current debounced signal with its previous value, outputting a one-cycle pulse on 0 to 1 transitions. This is done by storing the previous value in a register and comparing it with the current value.

4. *Counter:* An 8-bit counter with asynchronous active-low reset increments on each pulse. The counter value directly drives eight LEDs for visual feedback from each of the 8 bits of the register.

=== Part 2: 16-bit Counter with 7-Segment Display

The second part extends the counter to 16 bits and implements a sophisticated display system with dual operating modes:

1. *Clock Generation:* Two parameterized clock dividers generate a 1kHz clock (for display multiplexing) and a 1Hz clock (for automatic counting mode) from the 100MHz system clock.

2. *Mode Selection:* A switch selects between manual mode (button increments from the user) and automatic mode (1Hz increments). Both increment sources undergo the same signal conditioning as described in Part 1 (sync, debounce, edge detect) before reaching the counter.

3. *Display Multiplexing:* Since the Nexys A7 has two sets of four 7-segment displays sharing common cathode lines, time-division multiplexing displays one digit at a time. A display controller cycles through digits at 1kHz (250Hz per digit), fast enough that persistence of vision creates the illusion of simultaneous display in the first set of displays. The second set of displays is kept off by driving the digit select lines high.

4. *Seven-Segment Decoding:* A combinational decoder converts each 4-bit hexadecimal digit (0-F) to the appropriate 7-segment pattern using active-low outputs as described in the Data Sheet for the Nexys A7.

== Verilog Implementation

=== Part 1 Modules

==== 2-FF Synchronizer (`sync_2ff.v`)

Implements a two-stage flip-flop chain to safely synchronize asynchronous inputs to the system clock domain, by only passing the data signa (button press) on to the next stage on posedge clock. Also handles the reset signal by resetting the first flip-flop on negedge reset.

(See @mod:sync_2ff for code listing.)

==== Debouncer (`debouncer.v`)

Outputs a signal only if `COUNT_MAX` clock cycles (now set to 2,000,000 which is 20ms at 100MHz). Uses a counter that resets whenever the input disagrees with the current stable state (eg. the button was not pressed for 20ms).

(See @mod:debouncer for code listing.)

==== Edge Detector (`edge_detect.v`)

Detects rising edges by storing the previous input value and outputting a one-cycle pulse when `level_in & ~level_dly` is true (which is only on the rising edge of the input signal).

(See @mod:edge_detect for code listing.)

==== 8-bit Counter (`counter_8bit.v`)

A simple synchronous counter with asynchronous active-low reset that increments when the enable signal is asserted and wraps around from 255 to 0 when it reaches 256.

(See @mod:counter for code listing.)

==== Top Module Part 1 (`counter_8bit.v`)

Integrates all Part 1 modules, connecting the signal conditioning pipeline from raw button input to counter increment, with the counter output driving the LEDs. The active low reset button is converted to active high internally by the synchronizer with  `reset_n = ~btn_rst_raw;`.

(See @mod:top_part1 for code listing.)

==== Constraints File (`nexys_a7.xdc`)

Sets the clock frequency to 100MHz, 50% duty cycle for the clock signal, and the buttons and LEDs to the appropriate pins on the Nexys A7 board following led[0] => LSB and led[7] => MSB.

(See @app:nexys_a7_xdc_part1 for code listing.)

=== Part 2 Modules

==== Clock Divider (`clock_divider.v`)

Generates a 50% duty cycle output clock whose frequency is `clk_in / DIVIDE_BY`.
Based on a parameter `DIVIDE_BY` calculates the following:
- COUNTER_WIDTH: width of counter needed to count up to `DIVIDE_BY/2` (half the output period, measured in input clock cycles), calculated using `$clog2(DIVIDE_BY/2)` (log base 2) to determine the minimum number of bits required.
- COUNTER_MAX: maximum value of the counter, which is `DIVIDE_BY/2 - 1` since the counter starts from 0 and needs to count `DIVIDE_BY/2` cycles total.

The module then uses a counter that increments on each input clock cycle. When the counter reaches `COUNTER_MAX`, it toggles the output clock and resets the counter to 0. This creates a complete output period of `DIVIDE_BY` input cycles, with the output high for `DIVIDE_BY/2` cycles and low for `DIVIDE_BY/2` cycles, resulting in a 50% duty cycle.
(See @mod:clock_divider for code listing.)

==== 16-bit Counter (`counter16.v`)

Extended version of the 8-bit counter, now 16 bits wide to display four hex digits. In hidsignt, could have simply parametrized the counter width enabling counter width selection at instantiation without having to duplicate the file.
(See @mod:counter16 for code listing.)

==== Display Controller (`display_control.v`)

Implements time-division multiplexing by cycling a 2-bit counter at 1kHz. This counter generates active-low digit select signals (one of four dispalys) and routes the corresponding 4-bit part of the current 16-bit count signal (LSB to MSB) to the decoder.
(See @mod:display_control for code listing.)

==== Seven-Segment Decoder (`seven_segment_decoder.v`)

A combinational lookup table that maps 4-bit hex values (0-F) to active-low 7-segment patterns. Each pattern illuminates the appropriate segments to display the corresponding character as described in the Data Sheet for the Nexys A7.
(See @mod:seven_segment_decoder for code listing.)

==== Top Module Part 2 (`top.v`)

Integrates all Part 2 modules. Button and 1Hz increment sources are conditioned separately, then muxed based on mode select. The 16-bit counter output feeds the display controller, which multiplexes digits to the decoder and 7-segment displays. The second display (AN[7:4]) is always off driving high in the constraints file (`    assign digit_select_off = 4'b1111;`)
(See @mod:top for code listing.)

==== Constraints File (`nexys_a7.xdc`)

Sets the follwing on the Nexys A7 board:
- Clock signal to E3 at 100MHz
- Mode select switch to J15 (SW0) where 0 is manual mode and 1 is automatic mode
- Increment button to P18 (BTND)
- Reset button to C12 (CPU_RESETN)
- Second display (AN[7:4]) to digit_select_off[3:0] (always off driving high in the top module)
- First display (AN[3:0]) to digit_select[3:0] (display controller output)
- Seven-segment decoder segments seg[6:0] to T10, R10, K16, K13, P15, T11, L18 as described in the Data Sheet for the Nexys A7
(See @app:nexys_a7_xdc_part2 for code listing.)

== Simulation and Testing

Testbenches were developed for both parts to verify functionality before hardware deployment. The testbenches reduce debouncer and clock divider parameters to accelerate simulation time while maintaining functional equivalence.

=== Part 1 Testbench

The Part 1 testbench (`counter_8bit_tb.v`) exercises the complete signal path by asserting reset, then simulating multiple button presses with realistic hold times. The debouncer parameter is reduced to `COUNT_MAX=4` for faster simulation. The testbench verifies that each button press increments the counter once, and that reset properly clears the count.
(See @app:counter_tb for code listing.)

=== Part 2 Testbench

The Part 2 testbench (`top_tb.v`) tests both operating modes. Clock divider parameters are scaled down (`DIVIDE_BY=10` for 1kHz, `DIVIDE_BY=1000` for 1Hz) while maintaining their ratio. The testbench:
- Tests manual mode with multiple button presses
- Switches to automatic mode and observes autonomous counting
- Verifies display multiplexing by monitoring digit select and segment outputs
- Confirms that segments correctly display the counter value in hexadecimal

(See @app:top_tb for code listing.)

= Observation

== Simulation Results

Both parts of the lab were simulated and functionality was verified through testbenches before hardware deployment.

=== Part 1: Button-Controlled Counter

The Part 1 simulation demonstrated proper signal conditioning and counter operation:

- *Reset behavior:* The counter correctly initialized to 0 when the reset button was asserted (active-high, button BTNC on the Nexys A7 pressed), converting to active-low internally.
- *Synchronization:* The 2-FF synchronizer introduced a 2-clock-cycle delay, successfully eliminating potential metastability.
- *Debouncing:* With `COUNT_MAX=4` in simulation, the debouncer filtered button bounces and only propagated stable transitions after 4 clock cycles of consistency.
- *Edge detection:* Each button press, regardless of hold duration, generated exactly one single-cycle increment pulse.
- *Counter operation:* The 8-bit counter incremented correctly on each pulse, wrapping from 255 to 0 naturally thanks to 8-bit overflow.

=== Part 2: 7-Segment Display System

The Part 2 simulation verified both operating modes and display functionality:

- *Manual mode:* Button presses incremented the 16-bit counter correctly after signal conditioning, identical to Part 1 but with wider counter width.
- *Automatic mode:* When the mode select switch was set high, the counter incremented autonomously at the divided 1Hz clock rate (accelerated in simulation with scaled parameters).
- *Clock division:* Both clock dividers generated 50% duty cycle outputs at the expected frequencies (scaled for simulation).
- *Display multiplexing:* The display controller cycled through digits 0 => 1 => 2 => 3 => 0 repeatedly at the 1kHz rate. The digit select signals were correctly active-low with only one digit enabled at a time.
- *Seven-segment decoding:* Each 4-bit nibble of the counter was correctly decoded to its hexadecimal representation. For example, count value `0x1234` produced appropriate segment patterns for '4', '3', '2', '1' as the display cycled.

== Hardware Validation

After successful simulation, both designs were synthesized, generated bitstreams, and programmed onto the Nexys A7 FPGA board.

=== Part 1 Hardware Results

The button-controlled counter worked as expected on hardware:
- The reset button (BTNC) cleared the counter
- The increment button (BTND) reliably incremented the counter once per press
- LEDs displayed the binary count value with LED[0] as LSB and LED[7] as MSB
- No double-counting or bounce issues were observed, confirming effective debouncing

=== Part 2 Hardware Results

The 7-segment display system operated correctly:
- Reset button () cleared the counter
- In manual mode, button presses incremented the displayed hexadecimal value
- In automatic mode, the display counted up at approximately 1Hz
- All four digits displayed clearly with no visible flicker, confirming adequate multiplexing rate at 1kHz.
- The second display (AN[7:4]) was off, as expected.
- The counter rolled over from `F` to `0` correctly

= Conclusion

== Summary of Results

This lab successfully demonstrated the design and implementation of sequential logic systems with proper synchronization, timing control, and display interfacing. Both parts functioned correctly in simulation and on hardware, meeting all specified requirements.

*Part 1* achieved reliable button-controlled counting by implementing a complete signal conditioning pipeline that addressed metastability, contact bounce, and edge detection challenges which come with in interfacing an asynchronous human input to synchronous digital systems like the Nexys A7 FPGA board.

*Part 2* extended the system with clock division and display multiplexing, demonstrating time-division multiplexing principles and hexadecimal decoding. The dual-mode operation (manual/automatic) showcased input muxing and provided flexibility for different use cases.

The modular design approach, with separate modules for synchronization, debouncing, edge detection, clock division, and display control, promoted reusability between the two parts and simplified testing. Parameters in modules like the debouncer and clock divider allowed easy adaptation for both simulation (fast parameters) and hardware deployment (real-time parameters).

== Challenges and Solutions

Several challenges were encountered and resolved during implementation:

*Debouncer timing:* Initial attempts at debouncing used insufficient delay, causing occasional double-counts. Increasing `COUNT_MAX` to 2,000,000 (20ms at 100MHz) provided robust debouncing for the mechanical buttons.

*Simulation performance:* Running testbenches with full hardware parameters (100M clock cycles for 1Hz) was impractically slow. Using `defparam` to override parameters in the testbench reduced simulation time while maintaining functional equivalence by preserving frequency ratios.

*Active-low signals:* The Nexys A7 uses active-low digit select and segment signals. Initially using active-high logic resulted in inverted or blank displays. Changed polarity in both the display controller (digit select) and decoder (segment patterns) resolved this issue.

*Second display:* Initially, the second display (AN[7:4]) was not off and was flickering. Added a select line for the second display and `assign digit_select_off = 4'b1111;` to the top module to keep the second display off by always driving it high.

#pagebreak()

// ============================================
// APPENDIX - MODULE AND TESTBENCH LISTINGS
// ============================================
= Appendix <app:appendix>

== Common Module Listings <app:common_modules>

=== 2-FF Synchronizer (`sync_2ff.v`) <mod:sync_2ff>

#raw(read("part1/sync_2ff.v"), lang: "verilog", block: true)

=== Debouncer (`debouncer.v`) <mod:debouncer>

#raw(read("part1/debouncer.v"), lang: "verilog", block: true)

=== Edge Detector (`edge_detect.v`) <mod:edge_detect>

#raw(read("part1/edge_detect.v"), lang: "verilog", block: true)

== Part 1 Specific Modules <app:part1_modules>

=== 8-bit Counter (`counter_8bit.v`) <mod:counter>

#raw(read("part1/counter.v"), lang: "verilog", block: true)

=== Top Module Part 1 (`counter_8bit.v`) <mod:top_part1>

#raw(read("part1/counter_8bit.v"), lang: "verilog", block: true)

=== Constraints File Part 1 (`nexys_a7.xdc`) <app:nexys_a7_xdc_part1>

#raw(read("part1/nexys_a7.xdc"), lang: "verilog", block: true)

== Part 2 Specific Modules <app:part2_modules>

=== Clock Divider (`clock_divider.v`) <mod:clock_divider>

#raw(read("part2/clock_divider.v"), lang: "verilog", block: true)

=== 16-bit Counter (`counter16.v`) <mod:counter16>

#raw(read("part2/counter16.v"), lang: "verilog", block: true)

=== Display Controller (`display_control.v`) <mod:display_control>

#raw(read("part2/display_control.v"), lang: "verilog", block: true)

=== Seven-Segment Decoder (`seven_segment_decoder.v`) <mod:seven_segment_decoder>

#raw(read("part2/seven_segment_decoder.v"), lang: "verilog", block: true)

=== Top Module Part 2 (`top.v`) <mod:top>

#raw(read("part2/top.v"), lang: "verilog", block: true)

=== Constraints File Part 2 (`nexys_a7.xdc`) <app:nexys_a7_xdc_part2>

#raw(read("part2/nexys_a7.xdc"), lang: "verilog", block: true)

== Testbench Listings <app:testbenches>

=== Part 1 Testbench (`counter_8bit_tb.v`) <app:counter_tb>

#raw(read("part1/counter_8bit_tb.v"), lang: "verilog", block: true)

=== Part 2 Testbench (`top_tb.v`) <app:top_tb>

#raw(read("part2/top_tb.v"), lang: "verilog", block: true)
