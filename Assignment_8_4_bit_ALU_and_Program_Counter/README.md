# A8 - From Code to Circuit: 4-bit Mini-ALU and Program Counter
**Aim:** Build a 4-bit adder/subtractor ALU with a mode-select input and a
4-bit program counter, then map lines of code onto these hardware blocks.

## Design
- ALU: 4 full adders. B is XORed with the mode bit M, and M is the carry-in.
  M = 0 gives A + B, M = 1 gives A - B (two's complement).
- Program counter: 4-bit register that increments on each clock when enabled,
  with an asynchronous reset.
- Loop demo: for (i = 0; i < 8; i++) acc = acc + 1; built from the counter
  (i), a comparator (i < 8), the ALU (acc + 1) and a register (acc).

## Code-to-hardware mapping
See `mapping/c_equals_a_plus_b.md`, `mapping/for_loop_mapping.md` and
`mapping/mapping_diagram.png`.

| Code element | Hardware block |
|---|---|
| a, b, c | registers (flip-flops) |
| + | ALU adder (M = 0) |
| loop counter i | program counter / counter |
| i < 8 | comparator driving the enable |

## Files
- `a8_alu_pc.v` - full adder, ALU, PC, loop demo and testbench
- `circuit/alu4.circ`, `circuit/pc4.circ` - Logisim circuits, plus screenshots
- `mapping/` - code-to-hardware write-up and diagram
- `output.txt` - simulation log

## How to run
    iverilog -g2012 -o sim a8_alu_pc.v
    vvp sim

## Result
- ALU: all 512 cases (256 input pairs x 2 modes) match.
- 9 + 5 = 14, 9 - 5 = 4, 5 - 9 = 12 (4-bit wrap).
- Loop demo ends with i = 8, acc = 8, and the counter stops.

## Observations / edge cases
- Results are 4 bits, so 5 - 9 gives 12 (-4 in two's complement) and sums
  above 15 wrap. The carry-out shows the overflow for addition.
- The counter stops at 8 because the comparator disables it.
- Subtraction needs the carry-in = 1, not 0.

## GenAI use
<Used for ... / Not used for this assignment.>
