## 2. Iterative Loop: `for (i = 0; i < 8; i++) { acc = acc + 1; }`

| Part of Code | Hardware Block | Function in Circuit |
| :--- | :--- | :--- |
| **Loop variable `i`** | 4-bit Counter | Increments sequence count on each clock cycle |
| **Condition `i < 8`** | Comparator / Logic Gate | Asserts `Enable = 1` while $i < 8$; drops to `0` when $i = 8$ |
| **Operation `acc + 1`** | ALU Adder ($M = 0$) | Adds 1 (`B = 0001`) to current accumulator value |
| **Accumulator `acc`** | Data Register / Output Probe | Holds the running sum across loop cycles |
| **Loop exit condition** | Counter Enable (`en`) Control | Disables clocking (`en = 0`), freezing counter and register state |
