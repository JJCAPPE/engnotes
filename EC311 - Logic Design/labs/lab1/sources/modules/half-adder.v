`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: 
// Module Name: half-adder
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


module half_adder(
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
    );
    
    xor G1(sum, a, b);
    and G2(carry, a, b);
endmodule
