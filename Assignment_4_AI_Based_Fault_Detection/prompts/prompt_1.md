# Prompt–Response Log: Full Adder Fault Check

## Prompt

This is the truth table of a supposed full adder. Inputs: A, B, Cin. Outputs: Sum, Cout.

```
A B Cin | Sum Cout
0 0 0   |  0   0
0 0 1   |  1   0
0 1 0   |  1   0
0 1 1   |  0   0
1 0 0   |  1   0
1 0 1   |  0   1
1 1 0   |  0   1
1 1 1   |  1   1
```

Check it against a correct full adder, identify the fault, say which rows are wrong, and suggest the corrected Boolean expression.

---

## Response

### Reference truth table

Sum = A ⊕ B ⊕ Cin (1 when an odd number of inputs are 1) and Cout = AB + Cin(A ⊕ B) (1 when two or more inputs are 1).

| A | B | Cin | Correct Sum | Correct Cout | Given Sum | Given Cout | Verdict |
|---|---|-----|-------------|--------------|-----------|------------|---------|
| 0 | 0 | 0   | 0 | 0 | 0 | 0 | ok |
| 0 | 0 | 1   | 1 | 0 | 1 | 0 | ok |
| 0 | 1 | 0   | 1 | 0 | 1 | 0 | ok |
| 0 | 1 | 1   | 0 | 1 | 0 | 0 | **Cout wrong** |
| 1 | 0 | 0   | 1 | 0 | 1 | 0 | ok |
| 1 | 0 | 1   | 0 | 1 | 0 | 1 | ok |
| 1 | 1 | 0   | 0 | 1 | 0 | 1 | ok |
| 1 | 1 | 1   | 1 | 1 | 1 | 1 | ok |

### The fault

Only one row is wrong: **row 3 (A B Cin = 011)**. The Sum column is entirely correct. In the Cout column, 0 + 1 + 1 = 10 in binary, so the carry should be 1, but the given table shows 0.

The given Cout is 1 for rows 101, 110 and 111 only, so it is Σm(5, 6, 7). The correct Cout is Σm(3, 5, 6, 7).

### What the faulty circuit computes

The given Cout is 1 only when A = 1 and (B = 1 or Cin = 1), so:

**Cout_faulty = A·B + A·Cin = A(B + Cin)**

This is a carry function in which the A input is treated as mandatory. It drops the term B·Cin, which is
