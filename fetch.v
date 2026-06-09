module fetch(
    input clk, input rst,
    output reg [31:0] pc,
    output [31:0] instr,
    input branch, input [31:0] branch_target
);
    reg [31:0] imem [0:7];
    initial begin
        // ADDI x1, x0, 5   → x1 = 5
        imem[0] = 32'b000000000101_00000_000_00001_0010011;
        // ADDI x2, x0, 3   → x2 = 3
        imem[1] = 32'b000000000011_00000_000_00010_0010011;
        // ADD  x3, x1, x2  → x3 = 8
        imem[2] = 32'b0000000_00010_00001_000_00011_0110011;
        // SUB  x4, x1, x2  → x4 = 2
        imem[3] = 32'b0100000_00010_00001_000_00100_0110011;
        // AND  x5, x1, x2  → x5 = 1
        imem[4] = 32'b0000000_00010_00001_111_00101_0110011;
        // OR   x6, x1, x2  → x6 = 7
        imem[5] = 32'b0000000_00010_00001_110_00110_0110011;
        imem[6] = 32'b0; imem[7] = 32'b0;
    end
    assign instr = imem[pc[4:2]];
    always @(posedge clk) begin
        if (rst) pc <= 0;
        else pc <= pc + 4;
    end
endmodule
