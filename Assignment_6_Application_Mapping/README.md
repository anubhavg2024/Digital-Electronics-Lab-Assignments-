# A6 - Application Mapping of Sequential Building Blocks
**Aim:** For each sequential block (flip-flop, Mod-N counter, shift
register), identify a real system that uses it, describe its role, and show
a small simulation.

## Summary
| Block | Real system | Role |
|---|---|---|
| D flip-flop | CPU register bit, keypad debounce | Stores one bit between clock edges |
| Mod-60 counter | Seconds counter of a digital clock | Counts 0-59, carry at 59 |
| Shift register | UART/SPI serial link | Parallel-to-serial and serial-to-parallel conversion |

## Files
- `notes/` - one-page justification note per block
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `prompts/` – GenAI prompts and responses

## Result
All three testbenches report PASS.

## Observations / edge cases
- The flip-flop must keep its value while enable is 0.
- The counter wraps from 59 to 0 and carries only at 59.
- The shift register needs exactly 8 clocks after loading to hold the full byte.

## GenAI use
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim
