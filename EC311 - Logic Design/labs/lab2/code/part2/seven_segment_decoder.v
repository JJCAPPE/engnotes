`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Giacomo Cappelletto
// 
// Create Date: 11/14/2025 11:23:56 AM
// Design Name: Seven Segment Decoder
// Module Name: seven_segment_decoder
// Project Name: Counter Lab 2.2
// Target Devices: NEXYS A7
// Tool Versions: 
// Description: Binary to 7-segment display decoder for hex digits
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_decoder (
    input  wire [3:0] hex_digit,  // 4-bit hex in
    output reg  [6:0] seven       // 7-bit out: seven[6:0] = {CG, CF, CE, CD, CC, CB, CA}
);
    // Segment mapping: seven[6:0] = {CG, CF, CE, CD, CC, CB, CA}
    // CA = segment A (top horizontal)
    // CB = segment B (top-right vertical)
    // CC = segment C (bottom-right vertical)
    // CD = segment D (bottom horizontal)
    // CE = segment E (bottom-left vertical)
    // CF = segment F (top-left vertical)
    // CG = segment G (middle horizontal)
    // Active LOW: 0 = segment ON, 1 = segment OFF
    
    always @(*) begin
        case (hex_digit)
            // Dec Part
            4'h0: seven = 7'b1000000; // 0: all except CG
            4'h1: seven = 7'b1111001; // 1: CB,CC ON
            4'h2: seven = 7'b0100100; // 2: CA,CB,CD,CE,CG ON
            4'h3: seven = 7'b0110000; // 3: CA,CB,CC,CD,CG ON
            4'h4: seven = 7'b0011001; // 4: CB,CC,CF,CG ON
            4'h5: seven = 7'b0010010; // 5: CA,CC,CD,CF,CG ON
            4'h6: seven = 7'b0000010; // 6: CA,CC,CD,CE,CF,CG ON
            4'h7: seven = 7'b1111000; // 7: CA,CB,CC ON
            4'h8: seven = 7'b0000000; // 8: All ON
            4'h9: seven = 7'b0010000; // 9: CA,CB,CC,CD,CF,CG ON
            // Hex Part
            4'hA: seven = 7'b0001000; // A: CA,CB,CC,CE,CF,CG ON
            4'hB: seven = 7'b0000011; // B: CC,CD,CE,CF,CG ON
            4'hC: seven = 7'b1000110; // C: CA,CD,CE,CF ON
            4'hD: seven = 7'b0100001; // D: CB,CC,CD,CE,CG ON
            4'hE: seven = 7'b0000110; // E: CA,CD,CE,CF,CG ON
            4'hF: seven = 7'b0001110; // F: CA,CE,CF,CG ON
            
            default: seven = 7'b1111111; // all off as default
        endcase
    end
endmodule

