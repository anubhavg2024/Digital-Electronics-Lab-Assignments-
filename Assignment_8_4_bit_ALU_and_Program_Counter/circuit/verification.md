# A8 - Verification

### ALU Verification Table

| Pin A (4-bit) | Pin B (4-bit) | Mode (M) | Expected Y | Observed | Match |
|:---:|:---:|:---:|:---:|:---:|:---:|
| 9 | 5 | 0 | 14 | 14 | Yes |
| 9 | 5 | 1 | 4 | 4 | Yes |
| 5 | 9 | 1 | 12 (wraps, -4 in two's complement) | 12 | Yes |
| 15 | 1 | 0 | 0 (carry out = 1, wrapped) | 0 | Yes |

### Program Counter Verification

- **Counter Status (`en = 1`):** Expected sequence: `0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0`.
- **Observed:** The probe successfully increments sequentially from `0` to `15` on each clock pulse and rolls over to `0`. When `en = 0`, the output holds its current value across clock transitions without changing.

