# A9 - AI-Assisted Code-to-Gate Explainer
**Aim:** Use GenAI to explain which digital building blocks realise a piece
of code, build the proposed circuit, verify it for all inputs, and reflect
on where the AI was incomplete or wrong.

## Files
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `prompts/` – GenAI prompts and responses

## Code
    if (a > b) c = a; else c = b;      // a, b, c are 4-bit unsigned

The circuit must compare two 4-bit inputs, 'A' and 'B', and output the larger value.

## Circuit Design
The design uses two main components:
1. **4-bit Magnitude Comparator:** Compares inputs $A$ and $B$ and determines whether (A > B).
2. **4-bit 2:1 Multiplexer:** Selects either $A$ or $B$ based on the comparator output.

## Working Principle
* If (A > B), the comparator output is $1$, and the multiplexer selects input 'A'.
* If (A < B), the comparator output is $0$, and the multiplexer selects input 'B'.
* If (A = B), the comparator output is $0$, and the multiplexer selects input 'B'. Since both inputs are equal, the output remains correct.

The final output is:
C = max(A, B)

## Inputs and Outputs

| Signal | Description | Width |
| :--- | :--- | :--- |
| A | First unsigned input | 4 bits |
| B | Second unsigned input | 4 bits |
| A > B | Comparator output (select signal) | 1 bit |
| C | Selected maximum value | 4 bits |

## Required Components
* One 4-bit magnitude comparator
* One 4-bit 2:1 multiplexer
* Two 4-bit input sources
* One 4-bit output probe
* Connecting wires

## Expected Result
The circuit should always output the larger of the two input values.

## Conclusion
This assignment demonstrates how a high-level programming condition can be represented using digital logic components. A magnitude comparator and multiplexer together implement the maximum-selection operation.

## GenAI use
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim

