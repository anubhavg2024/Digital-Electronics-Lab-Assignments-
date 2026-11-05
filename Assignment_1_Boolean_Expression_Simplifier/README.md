# A1 - AI-Assisted Boolean Expression Simplifier
**Aim:** Use GenAI to simplify a 5-variable Boolean function, then implement
and verify the simplified circuit in a simulator.

## Function
F(A,B,C,D,E) = Σm(0,1,4,5,16,17,20,21,26,27,30,31)

## Files
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `prompts/` – GenAI prompts and responses

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

## GenAI Usage
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim

