`timescale 1ns/1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 02:44:51 PM
// Design Name: 
// Module Name: tb_alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_alu;
  reg  [3:0] A, B;
  reg  [1:0] S;
  wire [7:0] Y;

  alu dut(.A(A), .B(B), .S(S), .Y(Y));
  
  function [7:0] f_add(input [3:0] a, b); f_add = {4'b0,a} + {4'b0,b}; endfunction
  function [7:0] f_mul(input [3:0] a, b); f_mul = a * b;               endfunction
  function [7:0] f_cat(input [3:0] a, b); f_cat = {a,b};               endfunction
  function [7:0] f_shf(input [3:0] a, b); f_shf = (b>7) ? 8'd0 : ({4'b0,a} << b); endfunction

  integer k, errors;
  reg [7:0] Y_exp;

  function has_xz8(input [7:0] v); has_xz8 = (^v === 1'bx); endfunction
  function has_xz4(input [3:0] v); has_xz4 = (^v === 1'bx); endfunction
  function has_xz2(input [1:0] v); has_xz2 = (^v === 1'bx); endfunction

  initial begin
    errors = 0;

    A=4'hF; B=4'hF; S=2'b01; #1 $display("ADD FF+FF -> Y=%h (expect 1E)", Y);
    A=4'h8; B=4'h8; S=2'b10; #1 $display("SHF A=8,B=8 -> Y=%h (expect 00)", Y);
    A=4'hF; B=4'hF; S=2'b11; #1 $display("MUL F*F -> Y=%h (expect E1)", Y);

    for (k = 0; k < 1024; k = k + 1) begin
      {S, A, B} = k[9:0];

      #1;
      if (has_xz2(S) || has_xz4(A) || has_xz4(B)) begin
        $fatal(1, "X/Z on inputs at k=%0d S=%b A=%b B=%b", k, S, A, B);
      end

      case (S)
        2'b00: Y_exp = f_cat(A,B);
        2'b01: Y_exp = f_add(A,B);
        2'b10: Y_exp = f_shf(A,B);
        2'b11: Y_exp = f_mul(A,B);
      endcase

      if (Y !== Y_exp) begin
        errors = errors + 1;
        $display("MISMATCH k=%0d  S=%b A=%h B=%h | DUT Y=%h  EXP Y=%h",
                 k, S, A, B, Y, Y_exp);
      end

      if (has_xz8(Y)) begin
        errors = errors + 1;
        $fatal(1, "Output X/Z at k=%0d  S=%b A=%h B=%h  Y=%h", k, S, A, B, Y);
      end

      #9; 
    end

    if (errors==0) $display("PASS: all 1024 ALU vectors matched.");
    else           $display("FAIL: %0d mismatches.", errors);
    $finish;
  end
endmodule

