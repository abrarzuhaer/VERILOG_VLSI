`include "./source/d_flip_flop.v"
`include "./source/mux41.v"

module uni_shift_reg(
    input [7:0] data_input,
    input [1:0] operation,
    input clock,
    input reset_n,
    output reg shift_output
);

    wire [7:0] data;
    wire [7:0] q_output;

    dff DFF7 (.clk(clock), .rst_n(reset_n), .D(data[7]), .Q(q_output[7]));
    dff DFF6 (.clk(clock), .rst_n(reset_n), .D(data[6]), .Q(q_output[6]));
    dff DFF5 (.clk(clock), .rst_n(reset_n), .D(data[5]), .Q(q_output[5]));
    dff DFF4 (.clk(clock), .rst_n(reset_n), .D(data[4]), .Q(q_output[4]));
    dff DFF3 (.clk(clock), .rst_n(reset_n), .D(data[3]), .Q(q_output[3]));
    dff DFF2 (.clk(clock), .rst_n(reset_n), .D(data[2]), .Q(q_output[2]));
    dff DFF1 (.clk(clock), .rst_n(reset_n), .D(data[1]), .Q(q_output[1]));
    dff DFF0 (.clk(clock), .rst_n(reset_n), .D(data[0]), .Q(q_output[0]));

    mux41 MUX7 (.a(q_output[7]), .b(q_output[6]), .c(1'b0), .d(data_input[7]), .select(operation), .out(data[7]));
    mux41 MUX6 (.a(q_output[6]), .b(q_output[5]), .c(q_output[7]), .d(data_input[6]), .select(operation), .out(data[6]));
    mux41 MUX5 (.a(q_output[5]), .b(q_output[4]), .c(q_output[6]), .d(data_input[5]), .select(operation), .out(data[5]));
    mux41 MUX4 (.a(q_output[4]), .b(q_output[3]), .c(q_output[5]), .d(data_input[4]), .select(operation), .out(data[4]));
    mux41 MUX3 (.a(q_output[3]), .b(q_output[2]), .c(q_output[4]), .d(data_input[3]), .select(operation), .out(data[3]));
    mux41 MUX2 (.a(q_output[2]), .b(q_output[1]), .c(q_output[3]), .d(data_input[2]), .select(operation), .out(data[2]));
    mux41 MUX1 (.a(q_output[1]), .b(q_output[0]), .c(q_output[2]), .d(data_input[1]), .select(operation), .out(data[1]));
    mux41 MUX0 (.a(q_output[0]), .b(1'b0), .c(q_output[1]), .d(data_input[0]), .select(operation), .out(data[0]));

    always @(*) begin
        if (operation == 2'b01)
            shift_output = q_output[0];
        else
            shift_output = q_output[7];
    end

endmodule
