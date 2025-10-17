`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 12:39:31 PM
// Design Name: 4-bit Adder
// Module Name: tb_4adder
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: Testbench for the 4-bit adder module
// 
// Dependencies: adder4.v, full_adder.v, half_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_4adder;
  reg  [3:0] A, B;
  reg        cin;
  wire [3:0] S;
  wire       C3, C4;   // exposed for overflow

  adder4 add4(.A(A), .B(B), .cin(cin), .S(S), .C3(C3), .C4(C4));

  reg [3:0] S_exp;
  reg c1, c2, c3_exp, C4_exp;

  task calc_expected;
    begin
      {c1,     S_exp[0]} = A[0] + B[0] + cin;
      {c2,     S_exp[1]} = A[1] + B[1] + c1;
      {c3_exp, S_exp[2]} = A[2] + B[2] + c2;     // C3
      {C4_exp, S_exp[3]} = A[3] + B[3] + c3_exp; // C4
    end
  endtask

  integer k, errors;
  initial begin
    errors = 0;

    for (k = 0; k < 512; k = k + 1) begin
      {cin, A, B} = k[8:0];
      #1;                 
      calc_expected();

      if (S !== S_exp || C3 !== c3_exp || C4 !== C4_exp) begin
        errors = errors + 1;
        $error("ADDER4 FAIL: cin=%b A=%b B=%b  ->  S=%b C3=%b C4=%b  (exp S=%b C3=%b C4=%b)",
               cin, A, B, S, C3, C4, S_exp, c3_exp, C4_exp);
      end
      #9;                 
    end

    if (errors == 0)  $display("ADDER4: ALL TESTS PASSED");
    else $display("ADDER4: %0d test(s) FAILED", errors);

    $finish;
  end
endmodule

