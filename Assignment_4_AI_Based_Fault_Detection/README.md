# A4 - AI-Based Fault Detection in Digital Circuits
**CO coverage:** CO1, CO2
**Aim:** Build a full adder with a deliberate fault, have GenAI diagnose the
fault from the truth table, then correct and re-verify the circuit.

## Deliberate fault
In the first XOR gate, input B is left unconnected (the gate receives A and
Cin). Its output feeds both the Sum output and the carry AND gate.

| Output | Faulty | Correct |
|---|---|---|
| Sum | A xor Cin | A xor B xor Cin |
| Cout | AB + (A xor Cin).Cin | AB + (A xor B).Cin |

## Truth table comparison
| A | B | Cin | Golden S Co | Faulty S Co | Match |
|---|---|---|---|---|---|
| 0 | 0 | 0 | 0 0 | 0 0 | yes |
| 0 | 0 | 1 | 1 0 | 1 1 | no (Cout) |
| 0 | 1 | 0 | 1 0 | 0 0 | no (Sum) |
| 0 | 1 | 1 | 0 1 | 1 1 | no (Sum) |
| 1 | 0 | 0 | 1 0 | 1 0 | yes |
| 1 | 0 | 1 | 0 1 | 0 0 | no (Cout) |
| 1 | 1 | 0 | 0 1 | 1 1 | no (Sum) |
| 1 | 1 | 1 | 1 1 | 0 1 | no (Sum) |

6 of 8 rows are wrong. Every wrong Sum row is one where B = 1, and every wrong
Cout row is one where B = 0 and Cin = 1.

## Diagnosis
Sum never changes when B changes, which shows B is not reaching the Sum logic.
Because the same XOR output also feeds the carry gate, the Cout column is
affected too: one wiring error causes two symptoms.

## Correction
Connect B to the first XOR so that it computes A xor B, and keep the second
XOR with Cin.
Sum = A xor B xor Cin, Cout = AB + (A xor B).Cin

## Files
- `a4_fault_detect.v` - golden, faulty and fixed modules + testbench
- `circuit/fa_faulty.circ` - circuit with the fault
- `circuit/fa_fixed.circ` - corrected circuit
- `output.txt` - testbench output
- `prompts/prompts.md` - GenAI prompts, the AI's diagnosis, my check

## How to run
    iverilog -g2012 -o sim a4_fault_detect.v
    vvp sim

## Result
The corrected circuit matches the golden full adder in all 8 rows.

## Observations / edge cases
- Rows 000 and 100 look correct even in the faulty circuit, so a test with
  only those inputs would miss the fault.
- Testing only A=B=Cin=1 is also unreliable for some faults. Test all 8 rows.
- Fault type: input B stuck unconnected (an open input), not a gate failure.
