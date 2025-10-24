module top_part1 (
    input  wire       clk_100mhz,
    input  wire       reset_n,     // active-low
    input  wire       btn_inc_raw, // physical button
    output wire [7:0] led          // LEDs on the board
);
    // Sync button to the clock as a metastability filter
    wire btn_sync;
    sync_2ff u_sync (
        .clk     (clk_100mhz),
        .reset_n (reset_n),
        .d_async (btn_inc_raw),
        .q_sync  (btn_sync)
    );

    // Debounce and edge-detect to get a one-cycle increment pulse
    wire inc_pulse;
    debouncer_with_edge #(.COUNT_MAX(2_000_000)) u_db_edge (
        .clk       (clk_100mhz),
        .reset_n   (reset_n),
        .noisy_in  (btn_sync),
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
