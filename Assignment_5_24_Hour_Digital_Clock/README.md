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
Counting, carries and the 23:59:59 to 00:00:00 rollover were checked at preset points

## GenAI use

**GenAI tool used:** Claude Sonnet 5.5, a large language model developed by Anthropic, accessed through the claude.ai chat interface.

- Used to understand the assignment requirements.
- Used to develop the design approach and the supporting logic.
- Used to prepare the documentation and explain the circuit operation.
- Used to review the design for consistency and to identify edge cases.
- All suggestions were checked against the assignment requirements. Logisim verification results should be recorded only for the conditions actually simulated.
