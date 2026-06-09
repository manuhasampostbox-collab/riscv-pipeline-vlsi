[README_riscv.md](https://github.com/user-attachments/files/28747760/README_riscv.md)
# riscv-pipeline-vlsi
3-stage RISC-V pipeline (Fetch-Decode-Execute) in Verilog.  Supports RV32I subset: ADDI, ADD, SUB, AND, OR instructions.  Pipeline registers between stages. 32x32-bit register file.  All 6 instructions verified correct. Tools: Icarus Verilog 12.0.
# RISC-V 3-Stage Pipeline — VLSI Project 2

## Overview
A 3-stage RISC-V pipeline processor implemented in Verilog supporting the RV32I
instruction subset. Demonstrates processor architecture, pipeline register design,
instruction encoding, ALU implementation, and register file design.

**Simulation link:** https://edaplayground.com/x/YOUR_LINK_HERE

---

## Pipeline Architecture

```
        +----------+    +----------+    +----------+
 clk -->|  FETCH   |--->|  DECODE  |--->| EXECUTE  |
        | PC + IMEM| FD |instr→    | DE | ALU +    |
        |          | reg|fields    | reg| RegFile  |
        +----------+    +----------+    +----------+
             |               |               |
            PC            rd,rs1,rs2      alu_result
                          imm,alu_op
```

---

## Supported Instructions (RV32I subset)

| Instruction       | Operation         | Result |
|-------------------|-------------------|--------|
| ADDI x1, x0, 5   | x1 = x0 + 5      | x1 = 5 |
| ADDI x2, x0, 3   | x2 = x0 + 3      | x2 = 3 |
| ADD  x3, x1, x2  | x3 = x1 + x2     | x3 = 8 |
| SUB  x4, x1, x2  | x4 = x1 - x2     | x4 = 2 |
| AND  x5, x1, x2  | x5 = x1 & x2     | x5 = 1 |
| OR   x6, x1, x2  | x6 = x1 \| x2   | x6 = 7 |

---

## File Structure

```
riscv_pipeline/
├── fetch.v       — PC register + instruction memory (8 instructions)
├── decode.v      — 32-bit instruction decoder (opcode, rd, rs1, rs2, imm)
├── execute.v     — ALU (ADD/SUB/AND/OR) + 32×32-bit register file
├── pipeline.v    — Top module with FD and DE pipeline registers
├── tb_pipeline.v — Testbench: runs 6 instructions, prints results
└── README.md     — This file
```

---

## Simulation Results

```
================================
  RISC-V Pipeline Results
================================
  x1 = 5  (ADDI x1,x0,5)
  x2 = 3  (ADDI x2,x0,3)
  x3 = 8  (ADD  x3,x1,x2) expected=8
  x4 = 2  (SUB  x4,x1,x2) expected=2
  x5 = 1  (AND  x5,x1,x2) expected=1
  x6 = 7  (OR   x6,x1,x2) expected=7
  PC = 44 (6 instructions fetched)
================================
  Simulation PASSED
================================
```

---

## Key Concepts Demonstrated

- **Pipeline registers** — FD (Fetch→Decode) and DE (Decode→Execute) registers
- **Instruction encoding** — RISC-V 32-bit fixed-width encoding (R-type, I-type)
- **Register file** — 32×32-bit synchronous register file with write enable
- **ALU** — Supports ADD, SUB, AND, OR with function code selection
- **Hazard awareness** — Design structured for future hazard detection addition

---

## Tools Used
- Icarus Verilog 12.0
- EDA Playground (browser-based simulator)
- Verilog HDL

---

## Resume Bullet Point
Implemented a 3-stage RISC-V (RV32I subset) pipeline processor in Verilog
with Fetch, Decode, and Execute stages; designed pipeline registers, a 32×32-bit
register file, and a 4-operation ALU; verified correct execution of 6 instructions
including ADDI, ADD, SUB, AND, OR using Icarus Verilog 12.0.
