module counter8 (
    input  wire       clk,
    input  wire       reset_n,   
    input  wire       inc_pulse, // 1-cycle pulse
    output reg [7:0]  count
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            count <= 8'd0;
        else if (inc_pulse)
            count <= count + 8'd1; // should wrap naturally to 0 when it reaches 255
    end
endmodule
