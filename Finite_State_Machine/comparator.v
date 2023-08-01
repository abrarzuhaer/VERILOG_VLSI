module comparator #(parameter VALUE_WIDTH = 3)(
    input [VALUE_WIDTH - 1:0] value1,
    input [VALUE_WIDTH - 1:0] value2,
    output reg is_equal
);

    assign is_equal = (value1 == value2);

endmodule
