`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: 16-bit Counter
// Module Name: counter
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: 16-bit Counter for Counter Lab 2.2
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter16 (
    input  wire       clk,
    input  wire       reset_n,   
    input  wire       inc_pulse, // 1-cycle pulse
    output reg [15:0]  count
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            count <= 16'd0;
        else if (inc_pulse)
            count <= count + 16'd1; // should wrap naturally to 0 when it reaches 65535
    end
endmodule
