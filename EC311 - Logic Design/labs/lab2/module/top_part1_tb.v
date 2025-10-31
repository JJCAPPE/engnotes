`timescale 1ns/1ps

module top_part1_tb;
    localparam CLK_PERIOD_NS = 10; // 100 MHz

    reg clk_100mhz = 0;
    reg btn_rst_raw = 0;
    reg btn_inc_raw = 0;
    wire [7:0] led;

    top_part1 dut (
        .clk_100mhz (clk_100mhz),
        .btn_rst_raw(btn_rst_raw),
        .btn_inc_raw(btn_inc_raw),
        .led        (led)
    );

    // Speed up debounce during simulation (COUNT_MAX defaults to 2_000_000)
    defparam dut.u_db.COUNT_MAX = 4;

    always #(CLK_PERIOD_NS/2) clk_100mhz = ~clk_100mhz;

    initial begin
        btn_rst_raw = 1'b1;
        repeat (3) @(posedge clk_100mhz);
        btn_rst_raw = 1'b0;

        repeat (20) @(posedge clk_100mhz);

        // first press
        btn_inc_raw = 1'b1;
        repeat (5) @(posedge clk_100mhz);
        btn_inc_raw = 1'b0;

        repeat (50) @(posedge clk_100mhz);

        // second press
        btn_inc_raw = 1'b1;
        repeat (5) @(posedge clk_100mhz);
        btn_inc_raw = 1'b0;

        repeat (50) @(posedge clk_100mhz);

        btn_rst_raw = 1'b1;
        repeat (3) @(posedge clk_100mhz);
        btn_rst_raw = 1'b0;

        repeat (20) @(posedge clk_100mhz);
        $finish;
    end
endmodule

