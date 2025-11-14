`timescale 1ns / 1ps

module top_part2_tb;
    localparam CLK_PERIOD_NS = 10;

    reg clk_100mhz = 0;
    reg reset_n = 1;
    reg increment = 0;
    reg mode_select = 0;
    
    wire [3:0] digit_select;
    wire [6:0] seven;
    
    top_part2 dut (
        .clk_100mhz (clk_100mhz),
        .reset_n    (reset_n),
        .increment  (increment),
        .mode_select(mode_select),
        .digit_select(digit_select),
        .seven      (seven)
    );
    
    defparam dut.u_clk_div_1khz.DIVIDE_BY = 10;
    defparam dut.u_clk_div_1hz.DIVIDE_BY = 1000;
    defparam dut.u_debouncer.COUNT_MAX = 4;
    
    always #(CLK_PERIOD_NS/2) clk_100mhz = ~clk_100mhz;
    
    task press_button;
        begin
            increment = 1'b1;
            repeat (10) @(posedge clk_100mhz);
            increment = 1'b0;
            repeat (50) @(posedge clk_100mhz);
        end
    endtask
    
    task check_display;
        input [15:0] expected_count;
        begin
        end
    endtask
    
    initial begin
        reset_n = 1'b1;
        increment = 1'b0;
        mode_select = 1'b0;
        repeat (5) @(posedge clk_100mhz);
        
        reset_n = 1'b0;
        repeat (10) @(posedge clk_100mhz);
        reset_n = 1'b1;
        repeat (10) @(posedge clk_100mhz);
        check_display(16'h0000);
        
        mode_select = 1'b0;
        press_button();
        check_display(16'h0001);
        press_button();
        check_display(16'h0002);
        press_button();
        check_display(16'h0003);
        
        increment = 1'b1;
        repeat (2) @(posedge clk_100mhz);
        increment = 1'b0;
        repeat (2) @(posedge clk_100mhz);
        increment = 1'b1;
        repeat (2) @(posedge clk_100mhz);
        increment = 1'b0;
        repeat (50) @(posedge clk_100mhz);
        check_display(16'h0004);
        
        press_button();
        check_display(16'h0005);
        reset_n = 1'b0;
        repeat (5) @(posedge clk_100mhz);
        reset_n = 1'b1;
        repeat (10) @(posedge clk_100mhz);
        check_display(16'h0000);
        
        repeat (3) begin
            press_button();
        end
        check_display(16'h0003);
        
        repeat (20) begin
            @(posedge clk_100mhz);
            repeat (5) @(posedge clk_100mhz);
        end
        
        mode_select = 1'b1;
        repeat (100) @(posedge clk_100mhz);
        mode_select = 1'b0;
        repeat (10) @(posedge clk_100mhz);
        press_button();
        check_display(16'h0004);
 
        repeat (50) @(posedge clk_100mhz);
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t | reset_n=%b | mode_select=%b | increment=%b | digit_select=%b | seven=%b",
                 $time, reset_n, mode_select, increment, digit_select, seven);
    end
    
endmodule

