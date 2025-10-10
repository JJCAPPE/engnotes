
`default_nettype none
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: 
// Module Name: full-adder
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


