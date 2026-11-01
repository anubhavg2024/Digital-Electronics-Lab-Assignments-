# Block 1: D flip-flop (1-bit memory cell)

## Real system
A CPU register. A 32-bit register is 32 D flip-flops sharing one clock and
one write-enable line. A second example is a keypad debounce circuit.

## Role of the block
On each active clock edge the flip-flop copies D to Q and then holds Q until
the next edge. When write-enable is 0 it keeps its old value. This is how a
register keeps an operand stable while the ALU works on it. In a debounce
circuit, flip-flops sample the noisy key signal at a fixed clock rate, so the
output changes only at clock edges and not on every contact bounce; a short
counter then confirms the level is stable before it is accepted.

## Simulation result
dff.circ and a6_dff.v: writing 1 with enable = 1 stores 1; setting enable = 0
and changing D to 0 leaves Q at 1 (hold); writing 0 with enable = 1 clears it.
Testbench result: PASS.

Figure: circuit/dff.png
