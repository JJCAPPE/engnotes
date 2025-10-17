
`default_nettype none
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: Full Adder
// Module Name: full-adder
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: None
// Tool Versions: Vivado 2024.1
// Description: Full Adder module
// Dependencies: half_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
  input  wire a,
  input  wire b,
  input  wire cin,
  output wire sum,
  output wire cout
);
  wire s1, c1, c2;

  half_adder ha0(.a(a),  .b(b),   .sum(s1),  .carry(c1));
  half_adder ha1(.a(s1), .b(cin), .sum(sum), .carry(c2));

  or (cout, c1, c2);

endmodule


