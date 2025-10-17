`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: 4-bit Adder-Subtractor
// Module Name: addsub4
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: 4-bit Adder-Subtractor module
// 
// Dependencies:  adder4.v, half_adder.v, full_adder.v
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addsub4(
    input wire  [3:0] A,
    input wire  [3:0] B,
    input wire        m,
    output wire [3:0] S,
    output wire       cout,
    output wire       vout
    );
    
  wire [3:0] Bx;
  xor x0(Bx[0], B[0], m);
  xor x1(Bx[1], B[1], m);
  xor x2(Bx[2], B[2], m);
  xor x3(Bx[3], B[3], m);
  
  wire C3, C4;
  // cin = m accounts for 2s comp +1
  adder4 add4(.A(A), .B(Bx), .cin(m), .S(S), .C3(C3), .C4(C4));
  assign cout = C4;
  xor overf(vout, C3, C4);
  
endmodule
