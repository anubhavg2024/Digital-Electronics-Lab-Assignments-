
# Assignment 2 – Verification

## Boolean Expression

\[
ALARM=(Door_Open . Armed)+Smoke
\]

## Truth Table

| Door_Open | Armed | Smoke | ALARM |
|:---------:|:-----:|:-----:|:-----:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

## Verification Result

- Total input combinations: 8
- ALARM = 1: 5 combinations
- ALARM = 0: 3 combinations
- Expected and calculated outputs match.

**Result: PASS**
