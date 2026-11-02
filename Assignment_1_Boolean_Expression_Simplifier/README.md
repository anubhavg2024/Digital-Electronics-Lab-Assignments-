# A1 - AI-Assisted Boolean Expression Simplifier
**Aim:** Use GenAI to simplify a 5-variable Boolean function, then implement
and verify the simplified circuit in a simulator.

## Function
F(A,B,C,D,E) = Σm(0,1,4,5,16,17,20,21,26,27,30,31)

## Files
- `circuit/compare_and_verify.md`, `circuit/k_map.md`, `circuit/simplified_ckt.png`, `circuit/truth_table.md` - Circuit, Truth_Table, K-Map, Compare & Verify 
- `output.txt` - testbench output
- `prompts/prompt_1.md`, `prompts/prompt_2.md` - GenAI prompt, response, verification

## K-map (rows = BC, columns = DE, both in Gray-code order)
A = 0

| BC \ DE | 00 | 01 | 11 | 10 |
|---|---|---|---|---|
| 00 | 1 | 1 | 0 | 0 |
| 01 | 1 | 1 | 0 | 0 |
| 11 | 0 | 0 | 0 | 0 |
| 10 | 0 | 0 | 0 | 0 |

A = 1

| BC \ DE | 00 | 01 | 11 | 10 |
|---|---|---|---|---|
| 00 | 1 | 1 | 0 | 0 |
| 01 | 1 | 1 | 0 | 0 |
| 11 | 0 | 0 | 1 | 1 |
| 10 | 0 | 0 | 1 | 1 |

Groups:
- B'D': 8 cells (B = 0, D = 0; A, C, E vary), a 2x2 block in both maps
- ABD: 4 cells (A = 1, B = 1, D = 1; C, E vary), a 2x2 block in the A = 1 map

## Result
- SOP: F = B'D' + ABD
- POS: F = (A + B')(B' + D)(B + D')
- Variables C and E do not affect the output.
- Logisim: the original and simplified circuits give identical Analyze Circuit tables for all 32 rows.

## Gate count
| Version | Gates |
|---|---|
| Canonical sum of minterms | 12 five-input ANDs + 1 twelve-input OR + 5 NOTs = 18 |
| Simplified | 2 NOTs + 1 two-input AND + 1 three-input AND + 1 OR = 5 |

## Observations / edge cases
- C and E are redundant inputs.
- All 32 input combinations were checked in Logisim, including the corner cases 00000 and 11111.

## GenAI use
Claude Sonnet 5.5, a large language model developed by Anthropic, accessed through the claude.ai chat interface.
