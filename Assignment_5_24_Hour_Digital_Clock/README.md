# A5 - Digital Clock FSM Design with GenAI
**Aim:** Derive the FSM and flip-flop implementation of a 24-hour digital clock using GenAI, and study the seconds, minutes, and hours counting behavior.

## Design
Three counters share one clock.

| Counter | Range | Flip-flops | Enabled when |
|---|---|---|---|
| Seconds | 0-59 (Mod-60) | 6 | always |
| Minutes | 0-59 (Mod-60) | 6 | [SEC = 59] |
| Hours | 0-23 (Mod-24) | 5 | [SEC = 59] and [MIN = 59] 

At 23:59:59, all three counters wrap to 00:00:00 on the next clock edge.

## Files
- `circuit/` – Contains the circuit image or design, discussion, verification details, and truth table, as applicable to the assignment.
- `prompts/` – Contains the GenAI prompt and response log, including the prompts used, AI-generated responses, and verification or review of the results.
  
## Result
Seconds, minutes and hours count and roll over correctly.

## GenAI use
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim
