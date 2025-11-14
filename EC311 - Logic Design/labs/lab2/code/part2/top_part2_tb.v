`timescale 1ns / 1ps

module top_part2_tb;
    localparam CLK_PERIOD_NS = 10;

    reg clk_100mhz = 0;
    reg reset_n = 1;
    reg increment = 0;
    reg mode_select = 0;
    
    wire [3:0] digit_select;
    wire [3:0] digit_select_off;
    wire [6:0] seven;
    
    top_part2 dut (
        .clk_100mhz (clk_100mhz),
        .reset_n    (reset_n),
        .increment  (increment),
        .mode_select(mode_select),
        .digit_select(digit_select),
        .digit_select_off(digit_select_off),
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
    
    initial begin
        reset_n = 1'b1;
        increment = 1'b0;
        mode_select = 1'b0;
        repeat (10) @(posedge clk_100mhz);
        
        reset_n = 1'b0;
        repeat (20) @(posedge clk_100mhz);
        reset_n = 1'b1;
        repeat (20) @(posedge clk_100mhz);
        
        mode_select = 1'b0;
        repeat (50) @(posedge clk_100mhz);
        
        press_button();
        repeat (100) @(posedge clk_100mhz);
        
        press_button();
        repeat (100) @(posedge clk_100mhz);
        
        press_button();
        repeat (100) @(posedge clk_100mhz);
        
        mode_select = 1'b1;
        repeat (200) @(posedge clk_100mhz);
        
        repeat (1200) @(posedge clk_100mhz);
        
        repeat (1200) @(posedge clk_100mhz);
        
        repeat (1200) @(posedge clk_100mhz);
        
        repeat (200) @(posedge clk_100mhz);
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t | reset_n=%b | mode_select=%b | increment=%b | digit_select=%b | seven=%b",
                 $time, reset_n, mode_select, increment, digit_select, seven);
    end
    
endmodule

