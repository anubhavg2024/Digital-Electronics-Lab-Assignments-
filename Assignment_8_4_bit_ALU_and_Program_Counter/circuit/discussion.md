# A8 - Discussion

Arithmetic in high-level code maps directly to hardware elements within the ALU, stored variables map to registers or input buses, and instruction execution control is driven by the Program Counter. Subtraction is handled through dedicated 2's complement hardware or selectable subtraction paths routed through a multiplexer. 

The 4-bit datapath constraints cause values outside the range $[0, 15]$ to wrap modulo $16$. Consequently, calculating $5 - 9$ yields $12$ in unsigned representation, which corresponds directly to $-4$ in 4-bit 2's complement form ($1100_2$).

**Observation:** When routing buses of different bit widths in Logisim (such as connecting a 1-bit control line to a 4-bit component), Logisim triggers an "Incompatible Widths" error. Ensuring that the Data Bits property across all interconnected component ports matches the designated bus width ($4$ bits for operands, $1$ bit for control/select lines) is critical to maintaining signal integrity across the circuit.
