# Block 1: D flip-flop (1-bit memory cell)

## Real system
A CPU register. A 32-bit register is 32 D flip-flops sharing one clock and one
write-enable line. A second example is a keypad debounce circuit.

## Role of the block
On each active clock edge the flip-flop copies D to Q and holds it until the
next edge. With write-enable at 0 it keeps its old value, so a register can
hold an operand steady while the ALU uses it. In a debounce circuit, flip-flops
sample the noisy key signal at a fixed rate, so the output changes only at
clock edges and contact bounce between edges is ignored.

## Simulation result
The sample simulation demonstrated the expected behaviour of the D flip-flop
with an enable input.

- With enable = 1 and D = 1, the output Q changed to 1 after the clock edge.
- With enable = 0 and D = 0, the output remained at 1, showing that the
  flip-flop retained its previous value.
- When enable = 1 and D = 0, the output Q changed to 0 after the next clock edge.

This demonstrates that the flip-flop stores the input when enabled and holds
its previous state when the enable signal is low.
