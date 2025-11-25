`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: Display Control
// Module Name: display_control
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Multiplexes 16-bit counter value across 4 seven-segment displays
//              Uses round-robin time-division multiplexing at 1kHz refresh rate
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module display_control (
    input  wire        clk_1khz,      // 1kHz clock from clk divider
    input  wire        reset_n,        
    input  wire [15:0] count,          // 16-bit counter value from counter
    output reg  [3:0]  digit_select,  // Active-low digit enable (AN signals)
    output reg  [3:0]  segment_data   // 4-bit hex digit to display
);
    // 2-bit counter to cycle through (0, 1, 2, 3)
    reg [1:0] digit_counter;
    
    // 2-bit counter increments on 1kHz clock and cycles 0->1->2->3->0
    always @(posedge clk_1khz or negedge reset_n) begin
        if (!reset_n)
            digit_counter <= 2'd0;
        else
            digit_counter <= digit_counter + 2'd1; // Wraps from 3 to 0
    end
 
    // Only one digit  active low at a time
    always @(*) begin
        case (digit_counter)
            2'd0: digit_select = 4'b1110; // Digit 0 (rightmost): AN0=0, others=1
            2'd1: digit_select = 4'b1101; // Digit 1: AN1=0, others=1
            2'd2: digit_select = 4'b1011; // Digit 2: AN2=0, others=1
            2'd3: digit_select = 4'b0111; // Digit 3 (leftmost): AN3=0, others=1
            default: digit_select = 4'b1111; // All off as default
        endcase
    end
    
    // Segment data mux selects which 4-bit segment of count to display, synced with digit_select so correct digit value is shown
    always @(*) begin
        case (digit_counter)
            2'd0: segment_data = count[3:0];   // LSB: rightmost digit
            2'd1: segment_data = count[7:4];    // Second digit
            2'd2: segment_data = count[11:8];   // Third digit
            2'd3: segment_data = count[15:12];  // MSB: leftmost digit
            default: segment_data = 4'h0;       // Default to 0
        endcase
    end
endmodule

