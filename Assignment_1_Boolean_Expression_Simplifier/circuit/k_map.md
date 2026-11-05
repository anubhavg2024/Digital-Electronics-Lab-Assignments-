
# A1 – Karnaugh Map Simplification

## Boolean Function

\[
F(A,B,C,D,E)= Σm(0,1,4,5,16,17,20,21,26,27,30,31)
\]

A 5-variable Karnaugh map is represented using two 4-variable maps, one for A = 0 and another for A = 1.

- Rows represent BC in Gray code order: 00, 01, 11, 10.
- Columns represent DE in Gray code order: 00, 01, 11, 10.

## K-map 1: A = 0

| BC \ DE | 00 | 01 | 11 | 10 |
|:-------:|:--:|:--:|:--:|:--:|
| **00** | 1 | 1 | 0 | 0 |
| **01** | 1 | 1 | 0 | 0 |
| **11** | 0 | 0 | 0 | 0 |
| **10** | 0 | 0 | 0 | 0 |

## K-map 2: A = 1

| BC \ DE | 00 | 01 | 11 | 10 |
|:-------:|:--:|:--:|:--:|:--:|
| **00** | 1 | 1 | 0 | 0 |
| **01** | 1 | 1 | 0 | 0 |
| **11** | 0 | 0 | 1 | 1 |
| **10** | 0 | 0 | 1 | 1 |

## Grouping and Simplification

### Group 1: Eight cells

The first group covers all cells where:

- B = 0
- D = 0
- A, C and E can have either value.

Therefore, the term is:

\[
B'D'
\]

### Group 2: Four cells

The second group covers the cells where:

- A = 1
- B = 1
- D = 1
- C and E can have either value.

Therefore, the term is:

\[
ABD
\]

## Final Simplified Expression

Combining both groups:

\[
F=B'D'+ABD
\]

Variables C and E are eliminated because they change within the K-map groups and are not required in the simplified expression.
