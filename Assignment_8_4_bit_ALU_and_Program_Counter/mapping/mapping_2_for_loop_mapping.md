for (i = 0; i < 8; i++) { acc = acc + 1; }

| Part | Hardware block |
|---|---|
| i | 4-bit counter (program counter style), increments each iteration |
| i < 8 | Comparator, its output is the counter's enable |
| acc + 1 | ALU adder, M = 0, B = 1 |
| acc | 4-bit register holding the running result |
| Loop exit | i reaches 8, run = 0, counter and register stop |
