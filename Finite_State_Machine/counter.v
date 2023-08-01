module counter(
    input clk,
    input reset_n,
    input clear,
    input increment,
    output reg [2:0] count
);

    always @(posedge clk) begin
        if (!reset_n) begin
            count <= 3'b0; 
        end else begin
            count <= clear ? 3'b0 : count + increment; 
        end
    end

endmodule
