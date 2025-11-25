`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: Clock Divider
// Module Name: clock_divider
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Parameterized clock divider module
//              Divides input clock frequency by DIVIDE_BY parameter
//              Output duty cycle is 50%
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module clock_divider #(
    parameter integer DIVIDE_BY = 100_000  // Default: 100MHz -> 1kHz
)(
    input  wire clk_in,     // 100 MHz input clock
    input  wire reset_n,    // Active-low reset
    output reg  clk_out     // Divided output clock
);
    // Calculate counter width based on DIVIDE_BY parameter
    // Need to count up to DIVIDE_BY/2, so width is log2(DIVIDE_BY/2)
    localparam integer COUNTER_WIDTH = (DIVIDE_BY > 2) ? $clog2(DIVIDE_BY/2) : 1;
    localparam integer COUNTER_MAX = (DIVIDE_BY / 2) - 1;  // Count to half period
    
    // Internal counter
    reg [COUNTER_WIDTH-1:0] counter;
    
    // Clock divider logic toggles output every half period of the input clock
    always @(posedge clk_in or negedge reset_n) begin
        if (!reset_n) begin
            counter <= {COUNTER_WIDTH{1'b0}};  // Reset counter to 0
            clk_out <= 1'b0;                    // Reset output to 0
        end else begin
            if (counter == COUNTER_MAX) begin
                // Reached half period, toggle output and reset counter
                clk_out <= ~clk_out;
                counter <= {COUNTER_WIDTH{1'b0}};
            end else begin
                // Increment counter every input clock cycle
                counter <= counter + 1'b1;
            end
        end
    end
endmodule

