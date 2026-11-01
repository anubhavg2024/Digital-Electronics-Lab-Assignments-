# A9 - AI-Assisted Code-to-Gate Explainer
**Aim:** Use GenAI to explain which digital building blocks realise a piece
of code, build the proposed circuit, verify it for all inputs, and reflect
on where the AI was incomplete or wrong.

## Code
    if (a > b) c = a; else c = b;      // a, b, c are 4-bit unsigned

## Hardware realisation
A 4-bit comparator (A > B) drives the select line of a 2:1 multiplexer
(4 bits wide). Input 1 = a, input 0 = b, so the output is the larger value.

## Files
- `a9_code_to_gate.v` - design and exhaustive testbench
- `expected_table.py` - generates the reference table `expected_table.csv`
- `circuit/ifelse_mux.circ` - Logisim circuit, plus screenshots
- `output.txt` - simulation log
- `prompts/prompts.md` - GenAI prompts and responses
- `reflection.md` - where the AI was incomplete or needed correction

## How to run
    iverilog -g2012 -o sim a9_code_to_gate.v
    vvp sim
    python expected_table.py

## Result
All 256 input combinations match the code. The Logisim truth table was
compared with `expected_table.csv`, including a = b, a = 0 and a = 15.

## Observations / edge cases
- a = b: the comparator outputs 0, so the mux passes b (the same value).
- Inputs are treated as unsigned; signed numbers would need a signed
  comparator.
- If the mux inputs are swapped, the circuit returns the minimum instead.
