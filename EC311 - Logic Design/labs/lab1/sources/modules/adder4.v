`default_nettype none
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: 4-bit Adder
// Module Name: adder4
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: 4-bit Adder module
// Dependencies: full_adder.v, half_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder4(
  input  wire [3:0] A,
  input  wire [3:0] B,
  input  wire       cin,
  output wire [3:0] S,
  // For overflow detection
  output wire        C3,
  output wire C4
);
  wire c1, c2, c3;

  full_adder fa0(.a(A[0]), .b(B[0]), .cin(cin), .sum(S[0]), .cout(c1));
  full_adder fa1(.a(A[1]), .b(B[1]), .cin(c1),  .sum(S[1]), .cout(c2));
  full_adder fa2(.a(A[2]), .b(B[2]), .cin(c2),  .sum(S[2]), .cout(c3));
  // Expose C4
  full_adder fa3(.a(A[3]), .b(B[3]), .cin(c3),  .sum(S[3]), .cout(C4));
  // Expose C3
  assign C3 = c3;
endmodule

