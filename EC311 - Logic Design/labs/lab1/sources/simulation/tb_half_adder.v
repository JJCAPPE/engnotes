`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 12:16:59 PM
// Design Name: 
// Module Name: tb_half_adder
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



module tb_half_adder;
  reg  a, b;
  wire sum, carry;

  half_adder dut(.a(a), .b(b), .sum(sum), .carry(carry));

  integer i, errors = 0;
  reg exp_sum, exp_carry;

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      {a,b} = i[1:0];
      #1;
      exp_sum   = a ^ b;
      exp_carry = a & b;
      if (sum !== exp_sum || carry !== exp_carry) begin
        $error("HA MISMATCH a=%0b b=%0b : got sum=%0b carry=%0b exp sum=%0b carry=%0b",
               a,b,sum,carry,exp_sum,exp_carry);
        errors = errors + 1;
      end
      #9;
    end
    if (errors == 0) $display("HALF ADDER: ALL TESTS PASSED");
    else             $display(1, "HALF ADDER: %0d test(s) FAILED", errors);
  end
endmodule
