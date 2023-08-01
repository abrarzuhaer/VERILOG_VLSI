module counter(
    input clk,
    input reset_n,
    input clear,
    input increment,
    output reg [2:0] count
);

    always @(posedge clk) begin
        if (!reset_n) begin
            count <= 3'b0; // Synchronous reset: Reset the counter to zero
        end else begin
            count <= clear ? 3'b0 : count + increment; // Increment the counter unless clear is asserted
        end
    end

endmodule
