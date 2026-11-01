# A2 - Natural Language to Logic Circuit Generator
**Aim:** Convert an English description into a Boolean expression and
gate-level design using GenAI, then simulate and verify it.

## Statement
"The alarm rings if the door is open and the system is armed, or if smoke
is detected."

## Variables
| Name | Meaning |
|---|---|
| D (door_open) | 1 = door open |
| A (armed) | 1 = system armed |
| S (smoke) | 1 = smoke detected |
| F (alarm) | 1 = alarm rings |

## Expression
F = D·A + S

## Truth table
| D | A | S | F |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

## Gate-level design
1 AND gate (D, A) -> 1 OR gate (AND output, S) -> F.
Total: 2 gates. The expression is already minimal.

## Files
- `a2_nl_to_logic.v` - module + testbench
- `circuit/alarm.circ` - Logisim circuit
- `output.txt` - testbench output
- `prompts/prompts.md` - GenAI prompts and responses

## How to run
    iverilog -g2012 -o sim a2_nl_to_logic.v
    vvp sim

## Result
All 8 input combinations match the sentence in both the Verilog testbench
and the Logisim truth table.

## Observations / edge cases
- Smoke triggers the alarm regardless of the door and arming state (rows 1, 3, 5, 7).
- An open door with the system disarmed and no smoke does not ring (row 4).
- Ambiguity check: "A and B, or C" can be read as (A·B)+C or A·(B+C).
  The comma in the sentence gives (D·A)+S, and the truth table confirms it.
