module sync_2ff (
    input  wire clk,
    input  wire reset_n,
    input  wire d_async,
    output reg  q_sync
);
    reg q1;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q1     <= 1'b0;
            q_sync <= 1'b0;
        end else begin
            q1     <= d_async;
            q_sync <= q1;
        end
    end
endmodule
