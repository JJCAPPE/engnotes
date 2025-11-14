`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: Top Level Part 2
// Module Name: top_part2
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Top level module for Lab 2 Part 2
//              Implements 16-bit counter with 7-segment display multiplexing
// 
// Dependencies: clock_divider.v, counter16.v, display_control.v, 
//               seven_segment_decoder.v, debouncer.v, sync_2ff.v, edge_detect.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_part2 (
    input  wire       clk_100mhz,      // 100 MHz system clock
    input  wire       reset_n,         // Active-low global reset
    input  wire       increment,       // Increment button input
    input  wire       mode_select,      // Mode select switch (0=manual/button, 1=auto/1Hz)
    output wire [3:0] digit_select,    // 4-bit digit select (AN[3:0] signals, active-low)
    output wire [3:0] digit_select_off, // AN[7:4] - keep second display off
    output wire [6:0] seven            // 7-bit seven segment output (CA-CG, active-low)
);
    // Clock divider outputs
    wire clk_1khz;  // 1 kHz clock for display multiplexing
    wire clk_1hz;   // 1 Hz clock for auto-increment mode
    
    // Clock divider 100MHz to 1kHz
    clock_divider #(.DIVIDE_BY(100_000)) u_clk_div_1khz (
        .clk_in  (clk_100mhz),
        .reset_n (reset_n),
        .clk_out (clk_1khz)
    );
    // Clock divider 100MHz to 1Hz
    clock_divider #(.DIVIDE_BY(100_000_000)) u_clk_div_1hz (
        .clk_in  (clk_100mhz),
        .reset_n (reset_n),
        .clk_out (clk_1hz)
    );
    
    // Button input sync, debounce, and detect edge like part 1
    wire btn_sync;
    sync_2ff u_sync (
        .clk     (clk_100mhz),
        .reset_n (reset_n),
        .d_async (increment),
        .q_sync  (btn_sync)
    );
    
    wire btn_debounced;

    debouncer #(.COUNT_MAX(2_000_000)) u_debouncer (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .noisy_in  (btn_sync),
        .clean_out (btn_debounced)
    );
    
    wire btn_pulse; //clean button

    edge_detect u_edge_btn (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .level_in  (btn_debounced),
        .pulse_out (btn_pulse)
    );
    
    // Convert 1Hz clock to pulse for counter
    wire clk_1hz_pulse;
    edge_detect u_edge_1hz (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .level_in  (clk_1hz),
        .pulse_out (clk_1hz_pulse)
    );
    
    // Mode select multiplexer choose between auto (1Hz) or manual (button) increment with switch (mode_select)
    wire inc_pulse;
    assign inc_pulse = mode_select ? clk_1hz_pulse : btn_pulse;
    
    // 16-bit counter with inc_pulse from mode select or button
    wire [15:0] count;
    counter16 u_counter (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .inc_pulse (inc_pulse),
        .count     (count)
    );
    
    // Display control: multiplexes 16-bit count across 4 displays
    wire [3:0] segment_data;
    display_control u_display_control (
        .clk_1khz     (clk_1khz),
        .reset_n      (reset_n),
        .count        (count),
        .digit_select (digit_select),
        .segment_data (segment_data)
    );
    
    // Seven segment decoder converts 4-bit hex to 7-segment pattern
    seven_segment_decoder u_decoder (
        .hex_digit (segment_data),
        .seven     (seven)
    );
    
    // Keep second display (AN[7:4]) always off by driving them high (inactive)
    assign digit_select_off = 4'b1111;
    
endmodule

