`timescale 1ns / 1ps

module top_tb;
    localparam CLK_PERIOD_NS = 10;

    reg clock = 0;
    reg reset = 1;
    reg increment = 0;
    reg mode_select = 0;
    
    wire [3:0] digit_select;
    wire [3:0] digit_select_off;
    wire [6:0] seg;
    
    top dut (
        .clock            (clock),
        .reset            (reset),
        .increment        (increment),
        .mode_select      (mode_select),
        .digit_select     (digit_select),
        .digit_select_off (digit_select_off),
        .seg              (seg)
    );
    
    defparam dut.u_clk_div_1khz.DIVIDE_BY = 10;
    defparam dut.u_clk_div_1hz.DIVIDE_BY = 1000;
    defparam dut.u_debouncer.COUNT_MAX = 4;
    
    always #(CLK_PERIOD_NS/2) clock = ~clock;
    
    task press_button;
        begin
            increment = 1'b1;
            repeat (10) @(posedge clock);
            increment = 1'b0;
            repeat (50) @(posedge clock);
        end
    endtask
    
    initial begin
        reset = 1'b1;
        increment = 1'b0;
        mode_select = 1'b0;
        repeat (10) @(posedge clock);
        
        reset = 1'b0;
        repeat (20) @(posedge clock);
        reset = 1'b1;
        repeat (20) @(posedge clock);
        
        mode_select = 1'b0;
        repeat (50) @(posedge clock);
        
        press_button();
        repeat (100) @(posedge clock);
        
        press_button();
        repeat (100) @(posedge clock);
        
        press_button();
        repeat (100) @(posedge clock);
        
        mode_select = 1'b1;
        repeat (200) @(posedge clock);
        
        repeat (1200) @(posedge clock);
        
        repeat (1200) @(posedge clock);
        
        repeat (1200) @(posedge clock);
        
        repeat (200) @(posedge clock);
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t | reset=%b | mode_select=%b | increment=%b | digit_select=%b | seg=%b",
                 $time, reset, mode_select, increment, digit_select, seg);
    end
    
endmodule

