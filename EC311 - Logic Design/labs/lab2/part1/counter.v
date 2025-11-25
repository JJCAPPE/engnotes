`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/31/2025 11:55:26 AM
// Design Name: 8-bit Counter
// Module Name: counter
// Project Name: Counter Lab 2.1
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: 8-bit Counter for Counter Lab 2.1
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_8bit (
    input  wire       clock,
    input  wire       reset,   
    input  wire       increment,
    output reg [7:0]  count
);
    always @(posedge clock or negedge reset) begin
        if (!reset)
            count <= 8'd0;
        else if (increment)
            count <= count + 8'd1;
    end
endmodule
