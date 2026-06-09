module decode(
    input [31:0] instr,
    output [4:0] rd, rs1, rs2,
    output [31:0] imm,
    output [3:0] alu_op,
    output alu_src, reg_write
);
    wire [6:0] opcode = instr[6:0];
    assign rd        = instr[11:7];
    assign rs1       = instr[19:15];
    assign rs2       = instr[24:20];
    assign imm       = {{20{instr[31]}}, instr[31:20]};
    assign alu_src   = (opcode == 7'b0010011);
    assign reg_write = (opcode == 7'b0110011) || (opcode == 7'b0010011);
    assign alu_op    = {1'b0, instr[14:12]};
endmodule
