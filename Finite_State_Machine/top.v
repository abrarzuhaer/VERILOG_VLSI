`include "comparator.v"
`include "controller.v"
`include "counter.v"
`include "shift_register.v"

module top(
    input clk,
    input reset_n,
    input rx_start,
    input data_in,
    output frame_error
);

    // Internal signals
    wire [2:0] clk_count, bit_count;
    wire [4:0] data_out;

    // Counter modules
    counter #(.DATA_WIDTH(3)) clk_counter(
        .clk(clk),
        .reset_n(reset_n),
        .clear(clk_clear),
        .increment(clk_increment),
        .count(clk_count)
    );

    counter #(.DATA_WIDTH(3)) bit_counter(
        .clk(clk),
        .reset_n(reset_n),
        .clear(bit_clear),
        .increment(bit_increment),
        .count(bit_count)
    );

    // Shift register module
    shift_register #(.DATA_WIDTH(5)) shift(
        .clk(clk),
        .reset_n(reset_n),
        .shift_en(shift_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Comparators for count comparison
    comparator #(.VALUE_WIDTH(3)) clk_cmp(
        .value1(clk_count),
        .value2(3'b100),
        .is_equal(clk_count_eq_5)
    );

    comparator #(.VALUE_WIDTH(3)) bit_cmp(
        .value1(bit_count),
        .value2(3'b100),
        .is_equal(bit_count_eq_5)
    );

    // Controller module
    controller controller(
        .clk(clk),
        .reset_n(reset_n),
        .rx_start(rx_start),
        .clk_count_eq_5(clk_count_eq_5),
        .bit_count_eq_5(bit_count_eq_5),

        .frame_error_gen(frame_error_gen),
        .shift_en(shift_en),
        .clk_clear(clk_clear),
        .clk_increment(clk_increment),
        .bit_clear(bit_clear),
        .bit_increment(bit_increment)
    );

    // Frame error generation
    assign frame_error = (~data_out[4]) & frame_error_gen;

endmodule
