# A8 - From Code to Circuit: 4-bit Mini-ALU and Program Counter
## Design
- **ALU:** Four full adders. B is XORed with the mode bit 'M', and 'M' is the carry-in. M = 0 gives [A + B], M = 1 gives [A - B].
- **Program counter:** 4-bit counter with enable and reset.

## Code-to-hardware mapping

| Code element | Hardware block |
|---|---|
| `a`, `b`, `c` | registers (flip-flops) |
| `+` | ALU adder ($M = 0$) |
| `loop counter i` | program counter |
| `i < 8` | comparator driving the enable |

## Result
[9 + 5] = 14, [9 - 5 = 4], [5 - 9 = 12] (4-bit wrap); counter increments '0' to '15' and wraps to '0'.

## Files
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `mapping/` - code-to-hardware write-up and diagram
- `prompts/` – GenAI prompts and responses

## GenAI use
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim
