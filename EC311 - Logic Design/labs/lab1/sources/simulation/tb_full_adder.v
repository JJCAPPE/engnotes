`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 12:16:59 PM
// Design Name: Full Adder testbench
// Module Name: tb_full_adder
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: Testbench for the Full Adder module
// 
// Dependencies: full_adder.v, half_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_full_adder;
  reg  a, b, cin;
  wire sum, cout;

  full_adder dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  integer i, errors = 0;
  reg exp_sum, exp_cout;

  initial begin
    for (i = 0; i < 8; i = i + 1) begin
      {a,b,cin} = i[2:0];
      #1;
      exp_sum  = a ^ b ^ cin;
      exp_cout = (a & b) | (a & cin) | (b & cin);
      if (sum !== exp_sum || cout !== exp_cout) begin
        $error("FA MISMATCH a=%0b b=%0b cin=%0b : got sum=%0b cout=%0b exp sum=%0b cout=%0b",
               a,b,cin,sum,cout,exp_sum,exp_cout);
        errors = errors + 1;
      end
      #9;
    end
    if (errors == 0) $display("FULL ADDER: ALL TESTS PASSED");
    else             $display(1, "FULL ADDER: %0d test(s) FAILED", errors);
  end
endmodule

