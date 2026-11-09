# A9 – Circuit Verification

### Objective
To check the expected behavior of the 4-bit maximum-selection circuit. The circuit compares two 4-bit unsigned inputs, $A$ and $B$, and selects the larger value as output $C$.

### Expected Logic
* If A > B, output C = A.
* If A < B, output C = B.
* If A = B, output C = A = B.

Therefore:
C = max(A, B)

### Expected Verification Table
The following values are theoretical expected results for the proposed circuit:

| Test Case | A (Decimal) | B (Decimal) | Comparison | Expected C (Decimal) | Expected C (Binary) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| 1 | 9 | 5 | (A > B) | 9 | 1001 |
| 2 | 3 | 11 | (A < B) | 11 | 1011 |
| 3 | 7 | 7 | A = B | 7 | 0111 |
| 4 | 15 | 0 | (A > B) | 15 | 1111 |
| 5 | 0 | 15 | (A < B) | 15 | 1111 |
| 6 | 12 | 8 | (A > B) | 12 | 1100 |
| 7 | 4 | 10 | (A < B) | 10 | 1010 |
| 8 | 1 | 1 | (A = B) | 1 | 0001 |
| 9 | 0 | 0 | (A = B) | 0 | 0000 |
| 10 | 14 | 13 | (A > B) | 14 | 1110 |

### Verification Summary
The expected results confirm that the comparator determines which input is larger and the multiplexer selects the corresponding 4-bit value. The equality cases are also handled correctly because selecting either input produces the same value.

### Verification Status
**Status:** Expected results checked logically.

The table contains theoretical expected outputs. It does not represent confirmed Logisim simulation results. The circuit must be implemented and tested in Logisim before claiming successful simulation.

### Conclusion
The expected test cases cover greater-than, less-than, and equality conditions. They provide a reference for checking the maximum-selection circuit after implementation.
