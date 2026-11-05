# A4 - AI-Based Fault Detection in Digital Circuits
**Aim:** Build a full adder with a deliberate fault, have GenAI diagnose the fault from the truth table, then correct and re-verify the circuit.

---

## Deliberate Fault Description
In the faulty implementation, the first XOR gate has input 'B' left unconnected (relying only on 'A' and 'C_in'). Furthermore, this faulty output feeds both the Sum calculation and the carry generation logic, compounding the error across multiple output columns.

| Output | Faulty Expression | Correct Expression |
| :--- | :--- | :--- |
| **Sum** | [/A XOR Cin/] | [/A XOR B XOR Cin/] |
| **Cout** | [/AB + (A XOR Cin) * Cin/] | [/AB + (A XOR B) * Cin/] |

---

## Truth Table Comparison & Analysis

| A | B | Cin | Golden Sum | Golden Cout | Faulty Sum | Faulty Cout | Match Status |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :--- |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | **Yes** |
| 0 | 0 | 1 | 1 | 0 | 1 | 1 | **No (Cout)** |
| 0 | 1 | 0 | 1 | 0 | 0 | 0 | **No (Sum)** |
| 0 | 1 | 1 | 0 | 1 | 1 | 1 | **No (Sum)** |
| 1 | 0 | 0 | 1 | 0 | 1 | 0 | **Yes** |
| 1 | 0 | 1 | 0 | 1 | 0 | 0 | **No (Cout)** |
| 1 | 1 | 0 | 0 | 1 | 1 | 0 | **No (Sum)** |
| 1 | 1 | 1 | 1 | 1 | 1 | 0 | **No (Sum)** |

* **Discrepancy Count:** 6 out of 8 rows are incorrect. Every incorrect Sum row corresponds to instances where [B = 1], and incorrect Cout rows occur where [B = 0] and [C_in = 1].
* **Diagnosis:** The Sum output remains invariant when 'B' changes, proving that input 'B' fails to reach the primary XOR layer. Because this erroneous node fans out into the carry network, a single physical wiring error propagates symptoms into both output columns.

---

## Correction Strategy
* Connect input 'B' to the primary XOR gate so it correctly computes [/A XOR B/].
* Retain the secondary XOR configuration with C_in to achieve the final expressions:
  * [/Sum = A XOR B XOR Cin/]
  * [/Cout = AB + (A XOR B) * Cin/]

---

## Files
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `prompts/` – GenAI prompts and responses

---

## Result
The corrected circuit matches the golden full adder truth table across all 8 input combinations.

---

## Observations & Edge Cases
* **Hidden Faults:** Rows `000` and `100` yield matching outputs even under the fault condition; testing exclusively with these inputs would completely miss the failure.
* **Exhaustive Testing:** Spot-checking specific conditions (such as A = B = C_in = 1) is insufficient. Verifying all 8 rows is mandatory.
* **Fault Classification:** The issue stems from an open/unconnected pin assignment for 'B' rather than a total gate component failure.

---

## GenAI Usage
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim.

*Note: The AI-generated suggestions and outputs were reviewed and checked against the assignment requirements. Final design decisions and verification were based on the expected circuit behavior.*
