Prompt 2: Design a 4-Bit Program Counter

Prompt

Design a 4-bit Program Counter (PC) that stores and updates a 4-bit binary value.

The Program Counter should:

Use a 4-bit register or counter.

Increment its value by 1 when enabled.

Hold its current value when disabled.

Reset its value to 0000.

Count from 0 to 15 and return to 0 after reaching 15.

Explain its working principle, required components, connections, and expected verification cases.

GenAI Response

A 4-bit Program Counter stores the address or position of the next instruction. It increments by one whenever the enable input is active.

Working principle:

When reset is active, the PC becomes 0000.

When enable is active, the PC increments by 1 on the clock edge.

When enable is inactive, the PC keeps its current value.

After 1111 (decimal 15), the next increment returns the counter to 0000.

Required components:

One 4-bit counter or register

Clock input

Enable input

Reset input

Increment logic or a 4-bit incrementer

Four output bits (Q3, Q2, Q1, Q0)

Expected verification cases:

Initial value

Control

Expected next value

0

Enable

1

5

Enable

6

10

Disabled

10

14

Enable

15

15

Enable

0

Any value

Reset

0

Review and Application

The response describes the counter's increment, hold, reset, and rollover behavior. It was used as a reference for understanding the Program Counter and preparing its circuit design.

Overall Conclusion

GenAI was used to understand the design and operation of the 4-bit ALU and Program Counter.

The first prompt focused on arithmetic operations using addition and two's complement subtraction. The second prompt focused on storing and incrementing a 4-bit value with enable, reset, and rollover behavior.

The responses provided design guidance, component requirements, and expected verification cases. These expected cases are reference values and should not be treated as confirmed simulation results unless they have been tested in Logisim.
