# A9 – Circuit Discussion

### Introduction
This assignment demonstrates how a simple programming condition can be converted into a digital logic circuit.

The programming statement is:
```c
if (A > B)
    C = A;
else
    C = B;
```
The objective is to select the larger of two 4-bit unsigned inputs.

### Circuit Components
The circuit uses two main components:

1. **Magnitude Comparator:**  
   The 4-bit magnitude comparator compares inputs $A$ and $B$. It determines whether:
   * [A > B]
   * [A = B]
   * [A < B]  
   For this design, the $A > B$ output is used as the multiplexer select signal.

2. **2:1 Multiplexer:**  
   The multiplexer selects between the two 4-bit inputs:
   * When the select signal is $1$, it selects $A$.
   * When the select signal is $0$, it selects $B$.  
   The selected value becomes the output $C$.

### Circuit Operation
The circuit operates as follows:
1. Inputs 'A' and 'B' are supplied to the magnitude comparator.
2. The comparator checks which input is larger.
3. The comparator's A > B output controls the multiplexer.
4. The multiplexer selects either 'A' or 'B'.
5. The selected 4-bit value appears at output 'C'.

### Logic Expression
Let $S$ represent the comparator output $A > B$. The output can be expressed as:

C = (S . A) + (S' . B)

This expression represents the selection operation for each of the four output bits.

### Important Observations
* The circuit works with unsigned 4-bit numbers.
* The possible input range is $0$ to $15$.
* The output is also 4 bits wide.
* When both inputs are equal, the output is equal to both inputs.
* The comparator and multiplexer work together to implement the programming condition.

### Limitations
The design only selects the larger of two unsigned 4-bit values. It does not perform arithmetic operations or handle signed-number comparisons.

### Conclusion
The assignment shows how a programming decision can be implemented using combinational logic. The magnitude comparator performs the comparison, while the multiplexer selects the required input. This demonstrates the relationship between high-level programming conditions and digital hardware design.
