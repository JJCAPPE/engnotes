module edge_detect (
    input  wire clk,
    input  wire reset_n,
    input  wire level_in,
    output reg  pulse_out
);

    reg level_dly;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            level_dly  <= 0;
            pulse_out  <= 0;
        end else begin
            level_dly  <= level_in;
            pulse_out  <= level_in & ~level_dly;  // 1 clock pulse on rising edge
        end
    end

endmodule
