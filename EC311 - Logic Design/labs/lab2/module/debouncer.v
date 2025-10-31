module debouncer #(
    parameter integer COUNT_MAX = 2_000_000  // ~20 ms @ 100 MHz
)(
    input  wire clk,
    input  wire reset_n,
    input  wire noisy_in,
    output wire clean_out
);
    localparam integer COUNTER_WIDTH = (COUNT_MAX > 1) ? $clog2(COUNT_MAX) : 1;

    reg [COUNTER_WIDTH-1:0] counter;
    reg stable_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stable_state <= 1'b0;
            counter      <= '0;
        end else begin
            if (noisy_in == stable_state) begin
                counter <= '0;
            end else begin
                if (counter == COUNT_MAX - 1) begin
                    stable_state <= noisy_in;
                    counter      <= '0;
                end else begin
                    counter <= counter + 1'b1;
                end
            end
        end
    end

    assign clean_out = stable_state;

endmodule
