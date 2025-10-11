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
  #text(18pt, weight: "bold")[EC311 - Logic Design Lab]
  #v(0.3em)
  #text(16pt, weight: "bold")[Lab 1: Design 4-bit binar Adder-Subtractor and ALU]

  #grid(
    columns: auto,
    row-gutter: 0.3em,
    text(12pt)[*Student Name:* Giacomo Cappelletto],
    text(12pt)[*Student ID:* U91023753],
    text(12pt)[*Date:* #datetime.today().display("[month repr:long] [day], [year]")],
    text(12pt)[*Section:* A2],
  )
  #v(0.8em)
]

#line(length: 100%, stroke: 0.5pt)
#v(0.8em)

// ============================================
// 1. OBJECTIVE
// ============================================
= Objective

The primary objective of this lab is to design and implement a 4-bit ALU, which accepts two 4-bit inputs and performs addition, multiplication, concatenation and left shift. This ALU must also accept a 2-bit control signal to select the operation to be performed. The output of the ALU must be and 8-bit result signal.

The secondary objective of this lab is to design and implement a 4-bit adder-subtractor, which accepts two 4-bit inputs and performs addition and subtraction. This adder-subtractor must also accept a 1-bit control signal to select the operation to be performed and output a 1-bit overflow signal other than the 4-bit result and carry signal. This adder-subtractor must be implemented using an instantiation of multiple 4-bit full adders, which are to be implemented with structural verilog. Futhermore, these full adders must be implemented using an instantiation of multiple half adders, also to be implemented using structural verilog.

Furthermore, each submodule of the ALU and the adder-subtractor must be extensivelytested using a testbench, which verifies the functionality of each submodule by sweeping through all possible input combinations and checking the output.

// ============================================
// 2. METHODOLOGY
// ============================================
= Methodology

== Design Approach

=== Adder and Subtractor Implementation

The adder and subtractor implementation was deveoped with the end goal of a ripple-carry adder constituted of multiple full adders, each of which is instantiated with two half adders. The half adders are implemented using structural verilog with gate-level primitives. The full adders are implemented using structural verilog with an instantiation of two half adders.

The adder-subtractor is implemented using structural verilog with an instantiation of four full adders, and additional logic to handle the subtraction operation and overflow detection. We XOR the each bit of the second operand with the subtraction control signal to conditionally invert the second operand for the subtraction operation, and feed the carry-in of the first full adder with the subtraction control signal to complete the 2's complement arithmetic process. We also detect overflow by checking if the carry-in of the most significant full adder is different from the carry-out of the most significant full adder, which is accomplished by exposing the third carry-out of the full adders in the adder module (to avoid recalculating it).

=== ALU Implementation

Similarly to the adder-subtractor, the ALU is implemented with a hierarchy of modules, but using behavioral verilog instead of structural verilog. The 4 main submodules are the addition, multiplication, concatenation and left shift. Each of these submodules are implemented using behavioral verilog. To combine them, a 4:1 8-bit multiplexer is used to select the output of the desired submodule based on the 2-bit control signal.

== Verilog Implementation

=== Half Adder Module

The half adder is the fundamental building block, implemented using structural Verilog with gate-level primitives.

(See @mod:half_adder for code listing.)

=== Full Adder Module

The full adder is constructed by instantiating two half adders and combining their outputs, and is the building block of the adder-subtractor.

(See @mod:full_adder for code listing.)

=== 4-bit Adder Module

The 4-bit adder is implemented using an instantiation of four full adders in a ripple-carry configuration. Notice that we expose the third carry-out of the full adders to detect overflow further on in the adder-subtractor.

(See @mod:adder4 for code listing.)

=== 4-bit Adder-Subtractor Module

The adder-subtractor instantiates the previously defined 4-bit adder module, and adds additional logic to handle the subtraction operation and overflow detection. We XOR the each bit of the second operand with the subtraction control signal to conditionally invert the second operand for the subtraction operation, and feed the carry-in of the first full adder with the subtraction control signal to complete the 2's complement arithmetic. We also detect overflow by checking if the carry-in of the most significant full adder is different from the carry-out of the most significant full adder, which was previously exposed in the adder module.

(See @mod:addsub4 for code listing.)

=== Arithmetic submodules of the ALU Module

The 4 arithmetic submodules are the addition, multiplication, concatenation and left shift. Each of these submodules are implemented using behavioral verilog, which is a higher level of abstraction than structural verilog, and therfore allows for better readability and lower possibilities of errors.

(See @mod:alu_parts for code listing.)

=== Multiplexer Module

The multiplexer selects the output of the desired arithmetic submodule based on the 2-bit control signal, as per the lab instructions. The 4 input signals as well as the output are 8-bit signals, making this a 4:1 8-bit multiplexer.

(See @mod:alu_parts for code listing.)

=== ALU Module

Since most of the modules are already implemented, all that is left is to wire the arithmetic submodules to the multiplexer and the multiplexer to the output.

(See @mod:alu for code listing.)

== Simulation and Testing

Comprehensive testbenches were developed for each module to ensure functionality before integration. Each testbench was developed to test all possible input combinations for the module, and to verify the functionality of the module matcheds the expected behavior. For conciseness purposes, only the testbenches for the adder-subtractor and the ALU are included here. For all testbenches, see @app:testbenches.

=== Adder-Subtractor Testbench

The testbench for the adder-subtractor checks functionality for all 512 possible combinations of the 3 input signals (A, B, and m) against outputs S, cout and vout on an instantiation of the addsub4 module. We compute the expected outputs using behavioral verilog, using ripple carry logic in order to be able to check C3 and C4, and consequently check the overflow signal. After the loop the passed and failed tests are reported.

(See @app:addsub4, for the complete testbench.)


=== ALU Testbench

The testbench for the ALU checks functionality for all 1024 possible combinations of the 3 input signals (S, A, and B) against the 8-bit output Y on an instantiation of the alu module. We compute the expected output using behavioral verilog reference functions for each operation—concatenation, zero-extended addition, bounded left shift, and 4x4 multiply—selected via a case on S. The testbench includes a few directed smoke tests, then exhaustively iterates inputs, guards against X/Z on inputs and output, and compares Y to the reference using case-inequality to catch X/Z mismatches. After the loop the passed and failed tests are reported.

(See @app:alu, for the complete testbench.)

= Observation

== Simulation Results

See all waveforms in @app:waveforms.

=== Adder-Subtractor Waveform
The adder-subtractor waveform shows the full 512 value sweep with a clear transition from addition to subtraction when `m` toggles. The ripple behavior is visible across the sum bits as carries propagate, and the overflow indicator `vout` asserts exactly when the carry into and out of the MSB differ, matching `C3_exp ^ C4_exp`. Throughout the sweep, the module outputs `S` and `cout` align with `S_exp` and `C4_exp`, and `errors` remains zero, showing passed results for both add and subtract.

#figure(image("sources/waveforms/tb_addsub4.png" , width: 80%))

=== ALU Waveform
The ALU waveform breaks into clear bands by `S`: 00 concat `{A,B}`, 01 add, 10 left shift, 11 multiply. In the concat band, `Y` forms a stair-step pattern as `A`/`B` count because the bits are just packed together. In the add band, `Y` is the sum of `A+B` with added zeros to the left, so it ramps smoothly and never truncates (we have 8 bits). In the shift band, `Y = A << B` with zeros shifted in; when `B > 7` the output clamps to `00` as intended. In the multiply band, the 8-bit product tracks the reference (like `F*F = E1`) and you can see denser toggling from the larger range. We sample after a short settle, so no X/Z show up on `Y`. Across all 1024 cases, `Y` matches the reference and `errors` stays 0.

#figure(image("sources/waveforms/tb_alu.png", width: 80%))


== RTL Schematic

=== Adder-Subtractor RTL Schematic


=== ALU RTL Schematic

= Conclusion

Summarize findings and reflect on the laboratory experience.

== Summary of Results

Briefly restate accomplishments and whether objectives were met.

*Example:*
_This laboratory successfully demonstrated the design, simulation, synthesis, and implementation of a 4-bit synchronous counter using Verilog HDL and Vivado. All functional requirements were verified through simulation and hardware testing._

== Challenges and Solutions

Discuss difficulties encountered and their resolutions.

*Example issues:*
- Initial synthesis warnings due to incomplete sensitivity lists → resolved by using `always @(posedge clk)`
- Timing violations at 150 MHz → added pipeline stage to reduce critical path
- Simulation mismatch → fixed improper reset logic

== Learning Outcomes

Reflect on what was learned from this lab.

*Consider:*
- Conceptual understanding gained
- Tool proficiency developed
- Design techniques learned
- Debugging skills improved

*Example:*
_This lab reinforced understanding of synchronous sequential logic design and provided hands-on experience with the complete FPGA development workflow from RTL to bitstream._

== Future Improvements

Suggest potential enhancements or alternative approaches.

*Example:*
- Add a configurable counting direction (up/down counter)
- Implement variable count step size
- Add seven-segment display output
- Explore power optimization techniques

#pagebreak()

// ============================================
// APPENDIX A - TESTBENCH LISTINGS
// ============================================
= Appendix <app:appendix>

== Module Listings <app:modules>

=== Half Adder (`half-adder.v`) <mod:half_adder>

#raw(read("sources/modules/half-adder.v"), lang: "verilog", block: true)

=== Full Adder (`full-adder.v`) <mod:full_adder>

#raw(read("sources/modules/full-adder.v"), lang: "verilog", block: true)

=== 4-bit Adder (`adder4.v`) <mod:adder4>

#raw(read("sources/modules/adder4.v"), lang: "verilog", block: true)

=== 4-bit Adder-Subtractor (`addsub4.v`) <mod:addsub4>

#raw(read("sources/modules/addsub4.v"), lang: "verilog", block: true)

=== ALU Submodules (`alu.v`) <mod:alu_parts>

#raw(read("sources/modules/alu.v"), lang: "verilog", block: true)

=== Top-level ALU (`alu.v`) <mod:alu>

#raw(read("sources/modules/alu.v"), lang: "verilog", block: true)

== Testbench Listings <app:testbenches>

=== Half Adder Module (`tb_half_adder.v`) <app:half_adder>

#raw(read("sources/simulation/tb_half_adder.v"), lang: "verilog", block: true)

=== Full Adder Module (`tb_full_adder.v`) <app:full_adder>

#raw(read("sources/simulation/tb_full_adder.v"), lang: "verilog", block: true)

=== 4-bit Adder Module (`tb_4adder.v`) <app:adder4>

#raw(read("sources/simulation/tb_4adder.v"), lang: "verilog", block: true)

=== 4-bit Adder-Subtractor Testbench (`tb_addsub4.v`) <app:addsub4>

#raw(read("sources/simulation/tb_addsub4.v"), lang: "verilog", block: true)

=== ALU Testbench (`tb_alu.v`) <app:alu>

#raw(read("sources/simulation/tb_alu.v"), lang: "verilog", block: true)

== Simulation Waveforms <app:waveforms>

=== Half-Adder Waveform <app:half_adder_waveform>

#figure(image("sources/waveforms/tb_half_adder.png"))

=== Full-Adder Waveform <app:full_adder_waveform>

#figure(image("sources/waveforms/tb_full_adder.png"))

=== 4-bit Adder Waveform <app:adder4_waveform>

#figure(image("sources/waveforms/tb_4adder.png"))

=== 4-bit Adder-Subtractor Waveform <app:addsub4_waveform>

#figure(image("sources/waveforms/tb_addsub4.png"))

=== ALU Waveform <app:alu_waveform>

#figure(image("sources/waveforms/tb_alu.png"))
