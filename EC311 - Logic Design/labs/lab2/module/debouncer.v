module debouncer (
    input  wire clk,
    input  wire reset_n,
    input  wire noisy_in,
    output reg  pulse_out
);
    parameter integer COUNT_MAX = 2_000_000; // ~20 ms @ 100 MHz

    reg [$clog2(COUNT_MAX):0] counter;
    reg stable_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stable_state <= 0;
            clean_out    <= 0;
            counter      <= 0;
        end else begin
            if (noisy_in == stable_state) begin
                // Input has not changed so reset the counter
                counter <= 0;
            end else begin
                // Input is different so start counting
                counter <= counter + 1;
                if (counter >= COUNT_MAX) begin
                    // Input has been stable long enough so accept it as the new stable state
                    stable_state <= noisy_in;
                    counter      <= 0;
                end
            end
        end
    end

    assign clean_level = stable_state;

    // Go from clean level to pulse in order to detect single press of the button
    edge_detect u_edge (
        .clk(clk),
        .reset_n(reset_n),
        .level_in(clean_level),
        .pulse_out(pulse_out)
    );

endmodule
