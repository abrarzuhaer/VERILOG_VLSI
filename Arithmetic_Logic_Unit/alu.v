module alu #(parameter BIT_LENGTH = 4)(
    input [BIT_LENGTH-1:0] a,
    input [BIT_LENGTH-1:0] b,
    input [2:0] opcode,
    input funct,
    input exec_en,
    output reg [BIT_LENGTH-1:0] out,
    output reg cb
);

    always @* begin
        case ({funct, opcode})
            {1'b0, 3'b000}: {cb, out} = a + b;      // ADD
            {1'b0, 3'b100}: {cb, out} = a - b;      // SUBTRACT
            {1'b0, 3'b001}: {cb, out} = a & b;      // AND
            {1'b0, 3'b010}: {cb, out} = a | b;      // OR
            {1'b0, 3'b011}: {cb, out} = ~a;         // NOT A
            {1'b1, 3'b100}: {cb, out} = ~b;         // NOT B
            {1'b0, 3'b101}: {cb, out} = a ^ b;      // XOR
            {1'b1, 3'b101}: {cb, out} = ~(a ^ b);   // NOR
            {1'b1, 3'b001}: {cb, out} = ~(a & b);   // NAND
            {1'b1, 3'b010}: {cb, out} = ~(a | b);   // NOR
            {1'b0, 3'b110}: {cb, out} = a << b;     // SHIFT LEFT
            {1'b0, 3'b111}: {cb, out} = a >> b;     // SHIFT RIGHT
            default: {cb, out} = 'bx;               // Unspecified
        endcase

        if (!exec_en)
            {cb, out} = 'b0; // Set output to zero when exec_en is low
    end

endmodule
