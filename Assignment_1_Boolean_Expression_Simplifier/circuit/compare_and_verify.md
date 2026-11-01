
# A1 – Circuit Comparison and Verification

## 1. Original Boolean Expression

The original function is represented using the sum of minterms:

\[
F=Sigma m(0,1,4,5,16,17,20,21,26,27,30,31)
\]

It can be implemented using twelve 5-input AND gates whose outputs feed an OR gate.

## 2. Simplified Boolean Expression

Using Karnaugh map simplification:

\[
F=B'D'+ABD
\]

The simplified implementation requires:
- One NOT gate for B.
- One NOT gate for D.
- One 2-input AND gate for B'D'.
- One 3-input AND gate for ABD.
- One OR gate to combine the two terms.

## 3. Circuit Comparison

| Feature | Original Circuit | Simplified Circuit |
|---|---|---|
| Boolean representation | Sum of 12 minterms | B'D' + ABD |
| AND gates | 12 (5-input) | 2 |
| OR gates | 1 (12-input) | 1 (2-input) |
| NOT gates | Shared complemented inputs as needed | 2 |
| Number of terms | 12 | 2 |
| Variables used | A, B, C, D, E | A, B, D |
| Complexity | Higher | Lower |

*Gate counts describe the direct sum-of-minterms implementation and the simplified implementation, respectively.*

## 4. Verification

The original and simplified expressions are:

\[
F_original = Sigma m(0,1,4,5,16,17,20,21,26,27,30,31)
\]

\[
F_simplified = B'D'+ABD
\]

The simplified expression produces an output of 1 when either condition is true:

1. B = 0 and D = 0.
2. A = 1, B = 1 and D = 1.

These conditions correspond exactly to the original set of minterms.

### Verification Summary

| Verification Parameter | Result |
|---|---|
| Total input combinations | 32 |
| Original output 1s | 12 |
| Simplified output 1s | 12 |
| Original output 0s | 20 |
| Simplified output 0s | 20 |
| Mismatched output combinations | 0 |
| Functional equivalence | PASS |

## 5. Conclusion

The Karnaugh map method reduces the original 12-term Boolean expression to:

\[
F=B'D'+ABD
\]

The simplified circuit uses fewer logic gates and eliminates the unnecessary variables C and E.

Both expressions are logically equivalent for all 32 possible input combinations.
