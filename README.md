# 3-Stage Pipelined ALU using Verilog RTL

## Overview
This project implements a **3-stage pipelined Arithmetic Logic Unit (ALU)** using **Verilog RTL**. The design performs multiple arithmetic and logical operations while improving performance through **pipelining**, reducing the critical path delay and enabling higher operating frequency.

The ALU was designed and functionally verified using **Xilinx Vivado**, with simulation support through **EDA Playground** and a dedicated **Verilog testbench**.

---

## Features
- 3-stage pipelined architecture
- 8-bit input operands
- Multiple arithmetic and logical operations
- Enable-based control logic
- Functional verification using Verilog testbench
- Waveform-based simulation and debugging
- Implemented using synthesizable Verilog RTL

---

## Supported Operations

| Opcode | Operation | Description |
|---------|------------|-------------|
| `000` | ADD | Addition (`a + b`) |
| `001` | SUB | Subtraction (`a - b`) |
| `010` | AND | Bitwise AND |
| `011` | OR | Bitwise OR |
| `100` | XOR | Bitwise XOR |
| `101` | SHIFT LEFT | Left shift (`a << 1`) |
| `110` | SHIFT RIGHT | Right shift (`a >> 1`) |
| `111` | SLT | Set Less Than (`a < b`) |

---

## Pipeline Architecture

The ALU is implemented using a **3-stage pipeline** to improve throughput and reduce combinational delay.

### Stage 1 – Input Register Stage
The input operands (`a`, `b`) and operation select (`op`) are captured into pipeline registers.

```verilog
a_reg <= a;
b_reg <= b;
op_reg <= op;
```

**Purpose:**
- Synchronizes inputs with the clock
- Prevents unstable combinational behavior
- Stores operands for the next stage

---

### Stage 2 – Computation Stage
The ALU operation is performed based on the registered opcode.

Example:

```verilog
3'b000: result <= a_reg + b_reg;
3'b001: result <= a_reg - b_reg;
3'b010: result <= a_reg & b_reg;
3'b011: result <= a_reg | b_reg;
```

**Purpose:**
- Executes arithmetic and logical operations
- Separates computation from input capture
- Reduces combinational complexity

---

### Stage 3 – Output Register Stage
The computed result is transferred to the output register.

```verilog
y <= result;
```

**Purpose:**
- Produces stable output
- Registers final ALU result
- Completes the pipeline

---

## How Pipelining Works

Unlike a normal ALU where everything happens in a single clock cycle, this design divides execution into multiple stages.

### Example: ADD Operation

Suppose:

```text
a = 10
b = 5
op = ADD
```

### Clock Cycle 1
Inputs are captured into pipeline registers.

```text
a_reg = 10
b_reg = 5
op_reg = ADD
```

### Clock Cycle 2
ALU performs computation.

```text
result = 15
```

### Clock Cycle 3
Final output becomes available.

```text
y = 15
```

### Pipeline Execution Example

Multiple operations can execute simultaneously at different stages.

| Clock Cycle | Stage 1 | Stage 2 | Stage 3 |
|-------------|----------|----------|----------|
| Cycle 1 | ADD | - | - |
| Cycle 2 | SUB | ADD | - |
| Cycle 3 | AND | SUB | ADD |
| Cycle 4 | OR | AND | SUB |

This improves **throughput** because new instructions can enter the pipeline before previous ones finish execution.

---

## Enable-Based Control

The design includes an **enable signal**.

### When `enable = 1`
- Inputs are captured
- ALU computation occurs
- Output updates normally

### When `enable = 0`
- No new computation occurs
- Output retains the previous value
- Prevents unnecessary switching activity

This helps in reducing unnecessary transitions and improves design efficiency.

---

## Testbench Verification

A dedicated **Verilog testbench (`ALU_tb.v`)** was created to validate all supported ALU operations.

The testbench verifies:
- Addition
- Subtraction
- Bitwise operations
- Shift operations
- Set Less Than (SLT)
- Enable/disable functionality

Example stimulus:

```verilog
a = 10; b = 5; op = 3'b000; // ADD
a = 20; b = 3; op = 3'b001; // SUB
a = 7;  b = 2; op = 3'b010; // AND
a = 8;  b = 1; op = 3'b011; // OR
```

Waveform analysis and simulation were used to verify correct ALU functionality.

---

## Tools Used

- **Language:** Verilog HDL  
- **Simulation Tool:** Xilinx Vivado  
- **Online Simulation:** EDA Playground  
- **Verification:** Verilog Testbench & Waveform Analysis

---

## Project Structure

```text
├── ALU.v        # RTL Design
├── ALU_tb.v     # Testbench
└── README.md    # Project Documentation
```

---

## Future Improvements
- Add multiplication and division operations
- Introduce reset functionality
- Support parameterized bit-width design
- Improve low-power optimization
- Add advanced pipeline handling

---

## Author

**Sudharshan Manjunath Naik**  
Aspiring RTL Design Engineer | ASIC | FPGA | VLSI Enthusiast

GitHub: [SudharshanNaik](https://github.com/SudharshanNaik)
