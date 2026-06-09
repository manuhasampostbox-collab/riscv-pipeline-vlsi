module pipeline(
    input clk, input rst,
    output [31:0] pc,
    output [31:0] alu_result
);
    wire [31:0] instr, pc_out;
    reg  [31:0] fd_instr;
    wire [4:0]  rd, rs1, rs2;
    wire [31:0] imm;
    wire [3:0]  alu_op;
    wire        alu_src, reg_write;
    reg  [4:0]  de_rd, de_rs1, de_rs2;
    reg  [31:0] de_imm;
    reg  [3:0]  de_alu_op;
    reg         de_alu_src, de_reg_write;

    fetch    F(.clk(clk),.rst(rst),.pc(pc_out),.instr(instr),.branch(1'b0),.branch_target(32'b0));
    decode   D(.instr(fd_instr),.rd(rd),.rs1(rs1),.rs2(rs2),.imm(imm),.alu_op(alu_op),.alu_src(alu_src),.reg_write(reg_write));
    execute  E(.clk(clk),.rst(rst),.rd(de_rd),.rs1(de_rs1),.rs2(de_rs2),.imm(de_imm),.alu_op(de_alu_op),.alu_src(de_alu_src),.reg_write(de_reg_write),.alu_result(alu_result));

    assign pc = pc_out;

    always @(posedge clk) begin
        if (rst) begin
            fd_instr <= 0;
            de_rd <= 0; de_rs1 <= 0; de_rs2 <= 0;
            de_imm <= 0; de_alu_op <= 0;
            de_alu_src <= 0; de_reg_write <= 0;
        end else begin
            fd_instr     <= instr;
            de_rd        <= rd;
            de_rs1       <= rs1;
            de_rs2       <= rs2;
            de_imm       <= imm;
            de_alu_op    <= alu_op;
            de_alu_src   <= alu_src;
            de_reg_write <= reg_write;
        end
    end
endmodule
