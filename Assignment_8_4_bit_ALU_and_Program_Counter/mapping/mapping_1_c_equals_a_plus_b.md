# Code-to-Hardware Mapping Documentation

## 1. Simple Addition: `c = a + b;`

| Part of Code | Hardware Block | Function in Circuit |
| :--- | :--- | :--- |
| **Operands `a` and `b`** | Input Pins / Registers | Provides 4-bit parallel data inputs ($A$ and $B$) |
| **The `+` operator** | ALU Adder ($M = 0$) | Computes 4-bit sum $A + B$ |
| **Result `c`** | Output Bus / Register | Held at output probe `Y` or stored in a register |
| **Instruction execution** | Program Counter (PC) | Tracks instruction sequence address |

