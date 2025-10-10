`timescale 1ns / 1ps    
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 01:46:06 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module add(input wire [3:0] A, B, output wire [7:0] Y);

    assign Y = {4'b0000, A} + {4'b0000, B};
    
endmodule

module mult(input wire [3:0] A, B, output wire [7:0] Y);

    assign Y = A * B;
    
endmodule

module concat(input wire [3:0] A, B, output wire [7:0] Y);

    assign Y = {A,B};
    
endmodule

module shift(input wire [3:0] A, B, output wire [7:0] Y);

    assign Y = (B > 7) ? 8'd0 : ({4'b0000, A} << B);
    
endmodule

module mux(input wire [7:0] ADD, MULT, CONCAT, SHIFT, input wire [1:0] S, output reg [7:0] Y);
    always @* begin
        case (S)
            2'b00: Y = CONCAT;
            2'b01: Y = ADD;
            2'b10: Y = SHIFT;
            2'b11: Y = MULT;
            default Y = 8'd0;
        endcase
    end
endmodule

module alu(
    input wire  [3:0] A,
    input wire  [3:0] B,
    input wire  [1:0] S,
    output wire [7:0] Y
    );
    
    wire [7:0] ADD, MULT, CONCAT, SHIFT;
    
    concat c0(.A(A), .B(B), .Y(CONCAT));
    add    a0(.A(A), .B(B), .Y(ADD)   );
    mult   m0(.A(A), .B(B), .Y(MULT)  );
    shift  s0(.A(A), .B(B), .Y(SHIFT) );
    
    mux    muxY(.ADD(ADD), .MULT(MULT), .CONCAT(CONCAT), .SHIFT(SHIFT), .S(S), .Y(Y));
endmodule