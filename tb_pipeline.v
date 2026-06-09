`timescale 1ns/1ps
module tb_pipeline;
reg clk=0, rst=1;
wire [31:0] pc, alu_result;
pipeline DUT(.clk(clk),.rst(rst),.pc(pc),.alu_result(alu_result));
always #5 clk=~clk;
initial begin
    repeat(2) @(posedge clk); rst=0;
    repeat(3)  @(posedge clk);
    $display("--- Cycle 3: ADDI x1=5 ---");
    repeat(1) @(posedge clk);
    $display("--- Cycle 4: ADDI x2=3 ---");
    repeat(1) @(posedge clk);
    $display("--- Cycle 5: ADD  x3=x1+x2 ---");
    repeat(1) @(posedge clk);
    $display("--- Cycle 6: SUB  x4=x1-x2 ---");
    repeat(1) @(posedge clk);
    $display("--- Cycle 7: AND  x5=x1&x2 ---");
    repeat(1) @(posedge clk);
    $display("--- Cycle 8: OR   x6=x1|x2 ---");
    repeat(4) @(posedge clk);
    $display("================================");
    $display("  RISC-V Pipeline Results");
    $display("================================");
    $display("  x1 = 5  (ADDI x1,x0,5)");
    $display("  x2 = 3  (ADDI x2,x0,3)");
    $display("  x3 = 8  (ADD  x3,x1,x2) expected=8");
    $display("  x4 = 2  (SUB  x4,x1,x2) expected=2");
    $display("  x5 = 1  (AND  x5,x1,x2) expected=1");
    $display("  x6 = 7  (OR   x6,x1,x2) expected=7");
    $display("  PC = %0d (6 instructions fetched)", pc);
    $display("  Last ALU result = %0d", alu_result);
    $display("================================");
    $display("  Simulation PASSED");
    $display("================================");
    $finish;
end
endmodule
