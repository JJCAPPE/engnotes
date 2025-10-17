`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 01:27:34 PM
// Design Name: 4-bit Adder-Subtractor testbench
// Module Name: tb_addsub4
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: Testbench for the 4-bit adder-subtractor module
// 
// Dependencies: addsub4.v, adder4.v, half_adder.v, full_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_addsub4;
  reg  [3:0] A, B;
  reg        m;
  wire [3:0] S;
  wire       cout, vout;
  reg  [3:0] S_exp;
  reg        C3_exp, C4_exp, V_exp;

  addsub4 add4(.A(A), .B(B), .m(m), .S(S), .cout(cout), .vout(vout));

  task calc_expected;
    reg [3:0] Bx;
    reg c1, c2;
    begin
      Bx = B ^ {4{m}};
      {c1, S_exp[0]} = A[0] + Bx[0] + m;
      {c2, S_exp[1]} = A[1] + Bx[1] + c1;
      {C3_exp, S_exp[2]} = A[2] + Bx[2] + c2;
      {C4_exp, S_exp[3]} = A[3] + Bx[3] + C3_exp;
      V_exp = C3_exp ^ C4_exp; //overflow
    end
  endtask

  integer k, errors;
  initial begin
    errors = 0;
    {m, A, B} = 9'b0;

    for (k = 0; k < 512; k = k + 1) begin
      {m, A, B} = k[8:0];
      #1;                 
      calc_expected();

      if (S !== S_exp || cout !== C4_exp || vout !== V_exp) begin
        errors = errors + 1;
        $display("MISMATCH k=%0d  m=%b A=%b B=%b | DUT S=%b cout=%b vout=%b  EXP S=%b C4=%b V=%b",
                  k, m, A, B, S, cout, vout, S_exp, C4_exp, V_exp);
        //Stop on error
        $stop;
      end
      #9;
    end

    if (errors == 0) $display("ADDSUB4: all 512 passed.");
    else             $display("ADDSUB4 FAIL: %0d errors.", errors);
    $finish;
  end
endmodule
