module execute(
    input clk, input rst,
    input [4:0] rd, rs1, rs2,
    input [31:0] imm,
    input [3:0] alu_op,
    input alu_src, reg_write,
    output reg [31:0] alu_result
);
    reg [31:0] regfile [0:31];
    wire [31:0] A = regfile[rs1];
    wire [31:0] B = alu_src ? imm : regfile[rs2];
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            for (i=0; i<32; i=i+1) regfile[i] <= 0;
        end else if (reg_write && rd != 0) begin
            case (alu_op)
                4'b0000: regfile[rd] <= A + B;
                4'b0001: regfile[rd] <= A - B;
                4'b0010: regfile[rd] <= A & B;
                4'b0011: regfile[rd] <= A | B;
                default: regfile[rd] <= A + B;
            endcase
            alu_result <= regfile[rd];
        end
    end
endmodule
