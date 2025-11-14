`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/31/2025 11:55:26 AM
// Design Name: Egde Detecter 
// Module Name: edge_detect
// Project Name: Counter Lab 1
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Edge Detecter for Counter Lab 1
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module edge_detect (
    input  wire clk,
    input  wire reset_n,
    input  wire level_in,
    output reg  pulse_out
);

    reg level_dly;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            level_dly  <= 0;
            pulse_out  <= 0;
        end else begin
            level_dly  <= level_in;
            pulse_out  <= level_in & ~level_dly;  // 1 clock pulse on rising edge
        end
    end

endmodule