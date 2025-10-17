`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/03/2025 11:52:46 AM
// Design Name: Half Adder
// Module Name: half-adder
// Project Name: 4-bit Adder-Subtractor module
// Target Devices: 
// Tool Versions: Vivado 2024.1
// Description: Half Adder module
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
