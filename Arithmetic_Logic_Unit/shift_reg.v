module shift_reg #(parameter DATA_LENGTH = 12)(
    input clk,
    input reset_n,
    input shift_en,
    input [DATA_LENGTH-1:0] data_in_p,
    output reg [DATA_LENGTH-1:0] data_out_p
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            data_out_p <= 'b0; // Asynchronous reset
        else if (shift_en)
            data_out_p <= data_in_p; // If shift_en is high, load data_in_p into the register
    end

endmodule
