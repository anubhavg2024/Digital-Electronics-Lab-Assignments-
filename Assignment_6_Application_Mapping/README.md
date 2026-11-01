# A6 - Application Mapping of Sequential Building Blocks
**Aim:** For each sequential block (flip-flop, Mod-N counter, shift
register), identify a real system that uses it, describe its role, and show
a small simulation.

## Summary
| Block | Real system | Role | Simulation |
|---|---|---|---|
| D flip-flop | CPU register bit, keypad debounce | Stores 1 bit between clock edges | `a6_dff.v`, `circuit/dff.circ` |
| Mod-60 counter | Seconds counter of a digital clock; frequency divider | Counts 0-59, carry enables minutes | `a6_mod60.v`, `circuit/mod60_counter.circ` |
| Shift register | UART/SPI serial link; 74HC595 LED driver | Parallel-to-serial and serial-to-parallel conversion | `a6_shift_register.v`, `circuit/shift_register.circ` |

## Files
- `a6_dff.v`, `a6_mod60.v`, `a6_shift_register.v` - Verilog with testbenches
- `notes/` - one-page justification note per block
- `circuit/` - Logisim circuits and screenshots
- `output.txt` - combined testbench output
- `prompts/prompts.md` - GenAI prompts and responses

## How to run
    iverilog -g2012 -o sim_dff a6_dff.v
    vvp sim_dff
(repeat for a6_mod60.v and a6_shift_register.v)

## Result
All three testbenches report PASS.

## Observations / edge cases
- The flip-flop holds its value when enable = 0 even if D changes.
- The counter wraps 59 -> 0 and carry is high only at 59.
- Mod-60 built from Mod-10 + Mod-6 matches the single 6-bit counter.
- The first bit shifted into the SIPO register at load time is shifted out
  again by the 8th clock, so exactly 8 clocks are needed after the load.
- Values 60 to 63 are unused in the 6-bit counter.
