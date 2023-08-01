`include "./source/alu.v"
`include "./source/shift_reg.v"
`include "./source/controller.v"

module top #(parameter INSTR_LENGTH = 12)(
    input clk,
    input reset_n,
    input start,
    input [INSTR_LENGTH-1:0] instruction,

    output [3:0] result,
    output cb,
    output rvalid
);

    controller CONTROL (
        .clk(clk),
        .reset_n(reset_n),
        .start(start),
        .exec_en(ALU.exec_en), // Useing ALU's exec_en directly
        .rvalid(rvalid)
    );

    alu ALU (
        .a(instruction[10:7]),
        .b(instruction[6:3]),
        .opcode(instruction[2:0]),
        .funct(instruction[11]),
        .exec_en(), 
        .out(result[3:0]), 
        .cb(cb)
    );

    assign cb = result[4]; // Extracting carry bit from result

endmodule
