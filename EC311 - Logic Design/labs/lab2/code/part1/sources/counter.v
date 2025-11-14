`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/31/2025 11:55:26 AM
// Design Name: 8-bit Counter
// Module Name: counter
// Project Name: Counter Lab 1
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: 8-bit Counter for Counter Lab 1
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter8 (
    input  wire       clk,
    input  wire       reset_n,   
    input  wire       inc_pulse, // 1-cycle pulse
    output reg [7:0]  count
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            count <= 8'd0;
        else if (inc_pulse)
            count <= count + 8'd1; // should wrap naturally to 0 when it reaches 255
    end
endmodule
