module top_part1 (
    input  wire       clk_100mhz,
    input  wire       btn_rst_raw, // active-high reset button (BTNC)
    input  wire       btn_inc_raw, // increment button (BTND)
    output wire [7:0] led          // LEDs on the board
);
    // Convert active-high reset button to active-low internal reset
    wire reset_n = ~btn_rst_raw;
    // Sync button to the clock as a metastability filter
    wire btn_sync;
    sync_2ff u_sync (
        .clk     (clk_100mhz),
        .reset_n (reset_n),
        .d_async (btn_inc_raw),
        .q_sync  (btn_sync)
    );

    // Debounce the synchronized button
    wire btn_debounced;
    debouncer #(.COUNT_MAX(2_000_000)) u_db (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .noisy_in  (btn_sync),
        .clean_out (btn_debounced)
    );

    // Detect rising edge to produce a one-cycle increment pulse
    wire inc_pulse;
    edge_detect u_edge (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .level_in  (btn_debounced),
        .pulse_out (inc_pulse)
    );

    // Counter
    wire [7:0] count;
    counter8 u_counter (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .inc_pulse (inc_pulse),
        .count     (count)
    );
    assign led = count; // LSB -> led[0], MSB -> led[7]
endmodule
