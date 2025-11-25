`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 10/31/2025 11:55:26 AM
// Design Name: Debouncer
// Module Name: debouncer
// Project Name: Counter Lab 2.2    
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Debouncer for Counter Lab 2.2
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module debouncer #(
    parameter integer COUNT_MAX = 2_000_000  // ~20 ms @ 100 MHz
)(
    input  wire clk,
    input  wire reset_n,
    input  wire noisy_in,
    output wire clean_out
);
    localparam integer COUNTER_WIDTH = (COUNT_MAX > 1) ? $clog2(COUNT_MAX) : 1;

    reg [COUNTER_WIDTH-1:0] counter;
    reg stable_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stable_state <= 1'b0;
            counter <= 0;
        end else begin
            if (noisy_in == stable_state) begin
                counter <= 0;
            end else begin
                if (counter == COUNT_MAX - 1) begin
                    stable_state <= noisy_in;
                    counter <= 0;
                end else begin
                    counter <= counter + 1'b1;
                end
            end
        end
    end

    assign clean_out = stable_state;

endmodule