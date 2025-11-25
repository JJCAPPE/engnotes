`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: Flip-Flop Sync
// Module Name: sync_2ff
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: 2-bit Flip-Flop Synchronizer for Counter Lab 2.2
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sync_2ff (
    input  wire clk,
    input  wire reset_n,
    input  wire d_async,
    output reg  q_sync
);
    reg q1;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q1     <= 1'b0;
            q_sync <= 1'b0;
        end else begin
            q1     <= d_async;
            q_sync <= q1;
        end
    end
endmodule

