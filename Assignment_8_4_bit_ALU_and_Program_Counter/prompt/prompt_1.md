# A8 – Prompt and Response Log

## Prompt 1: Design a 4-Bit ALU

### Prompt

Design a 4-bit Arithmetic Logic Unit (ALU) that performs addition and subtraction using a control input `M`.

The ALU should:
- Accept two 4-bit inputs, `A` and `B`.
- Use `M = 0` for addition (`A + B`).
- Use `M = 1` for subtraction (`A - B`).
- Use four full adders to perform the arithmetic.
- Use XOR gates to conditionally invert each bit of input `B`.
- Connect `M` to the initial carry input.
- Produce a 4-bit result and a carry-out.

Explain the working principle, required components, connections, and expected verification cases.

### GenAI Response

The ALU can perform both addition and subtraction using the two's complement method.

The main equation is:

\[
S = A + (B \oplus M) + M
\]

**Working principle:**

- When `M = 0`, the XOR gates pass `B` unchanged, and the carry-in is 0. The ALU performs addition.
- When `M = 1`, the XOR gates invert `B`, and the carry-in is 1. The ALU performs subtraction using two's complement.

**Required components:**

- Four full adders
- Four XOR gates
- Two 4-bit input sources for `A` and `B`
- One control input `M`
- One 4-bit result output
- One carry-out output

**Expected verification cases:**

| Operation | A | B | Expected result |
|---|---:|---:|---:|
| Addition | 9 | 5 | 14 |
| Addition | 7 | 3 | 10 |
| Addition | 15 | 1 | 0, carry-out 1 |
| Subtraction | 9 | 5 | 4 |
| Subtraction | 5 | 9 | 12 (4-bit result) |
| Subtraction | 6 | 6 | 0 |

The ALU produces a 4-bit result, so values wrap around modulo 16. The carry-out is a separate output and should be considered when checking the result.

### Review and Application

The response explains how one circuit can perform both addition and subtraction using XOR gates and a control signal. The equation and component list were used as a guide for designing the ALU.

---

## Prompt 2: Design a 4-Bit Program Counter

### Prompt

Design a 4-bit Program Counter (PC) that stores and updates a 4-bit binary value.

The Program Counter should:
- Use a 4-bit register or counter.
- Increment its value by 1 when enabled.
- Hold its current value when disabled.
- Reset its value to `0000`.
- Count from 0 to 15 and return to 0 after reaching 15.

Explain its working principle, required components, connections, and expected verification cases.

### GenAI Response

A 4-bit Program Counter stores the address or position of the next instruction. It increments by one whenever the enable input is active.

**Working principle:**

- When reset is active, the PC becomes `0000`.
- When enable is active, the PC increments by 1 on the clock edge.
- When enable is inactive, the PC keeps its current value.
- After `1111` (decimal 15), the next increment returns the counter to `0000`.

**Required components:**

- One 4-bit counter or register
- Clock input
- Enable input
- Reset input
- Increment logic or a 4-bit incrementer
- Four output bits (`Q3`, `Q2`, `Q1`, `Q0`)

**Expected verification cases:**

| Initial value | Control | Expected next value |
|---:|---|---:|
| 0 | Enable | 1 |
| 5 | Enable | 6 |
| 10 | Disabled | 10 |
| 14 | Enable | 15 |
| 15 | Enable | 0 |
| Any value | Reset | 0 |

### Review and Application

The response describes the counter's increment, hold, reset, and rollover behavior. It was used as a reference for understanding the Program Counter and preparing its circuit design.

---

## Overall Conclusion

GenAI was used to understand the design and operation of the 4-bit ALU and Program Counter.

The first prompt focused on arithmetic operations using addition and two's complement subtraction. The second prompt focused on storing and incrementing a 4-bit value with enable, reset, and rollover behavior.

The responses provided design guidance, component requirements, and expected verification cases. These expected cases are reference values and should not be treated as confirmed simulation results unless they have been tested in Logisim.
