# Discussion & Technical Analysis — A4: AI-Based Fault Detection

## 1. Root Cause Analysis
In the faulty circuit configuration, input [/B/] was left unconnected from the primary XOR gate, causing the circuit to compute [/Sum = A XOR Cin/] instead of [/Sum = A XOR B XOR Cin/]. 
* Because this faulty node shared a net with the carry generation logic, the carry expression degraded from [/Cout = AB + Cin(A XOR B)/] to [/Cout = AB + A * Cin/].
* This single open-pin wiring error caused simultaneous faults across 6 out of 8 truth table rows.

## 2. Role of GenAI in Diagnosis
* Feeding the faulty output vector into the LLM enabled rapid pattern identification without requiring manual Karnaugh map reduction.
* The AI successfully isolated the missing connection on input [/B/] and mapped out the exact structural corrections needed at the gate level.

## 3. Conclusion
Assignment A4 demonstrates the practical utility of AI-assisted debugging in digital hardware design, showing how behavioral anomalies in truth tables can be efficiently traced back to physical netlist errors. 
