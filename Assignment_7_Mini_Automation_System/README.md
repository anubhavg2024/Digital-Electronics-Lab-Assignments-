# A7 - Design a Mini Automation System (Parking Barrier Controller)
**Aim:** Apply combinational and sequential design to a real automation
scenario: define the I/O, derive the FSM and logic, implement it in Logisim
and test every input scenario, including edge cases.

## Scenario
An automatic parking barrier. It opens for a car with a valid ticket, stays
open while a vehicle is under it, then closes.

## Files
- `circuit/` – Circuit design and images, truth table, verification and discussion
- `prompts/` – GenAI prompts and responses

## Components Used

The Parking Barrier Controller FSM is implemented using the following Logisim components:

| Component | Quantity / Configuration | Purpose |
|---|---|---|
| D Flip-Flop | 2 (1-bit each) | Store the FSM state bits Q1 and Q0. |
| AND Gates | Multiple | Implement product terms in the next-state and output logic. |
| OR Gates | Multiple | Combine logic terms to generate next-state and output signals. |
| NOT Gates | As required / input bubbles | Provide complemented input signals. |
| Clock | 1 | Synchronise state transitions. |
| Input Pins | R1 and R0 | Provide the external input signals shown in the circuit. |
| Input Pin | Reset | Initialise the state storage, if connected to the flip-flop reset pins. |
| Output Pins / Indicators | NOGO, UP, DOWN | Display the controller output signals. |
| Connecting Wires | As required | Connect sequential and combinational logic components. |

## Circuit Description

The circuit uses two D flip-flops to store the FSM state. Combinational logic constructed using AND, OR and inverted inputs generates the next-state signals.

The output logic combines the state signals and input conditions to generate NOGO, UP and DOWN.

A clock signal synchronises the state updates.


## Safety Requirement
The barrier must not close while a vehicle is detected beneath it. The input X is used in the next-state logic to prevent unsafe closing and to return the controller to an open condition when necessary.

## Result
Testbench output matches the reference model for the 8 scenarios and for
64 further input patterns. The unused state 11 recovers to CLOSED.

## Conclusion
The parking barrier controller demonstrates the application of a finite state machine to an automated safety-related system. The design combines state memory and combinational logic to control barrier operation based on vehicle and ticket inputs.

## GenAI use
**Tool:** Claude Sonnet 5.5 (Anthropic)

- Used for understanding the requirements, design approach and documentation
- Used to review the design and identify edge cases
- Suggestions were checked against the requirements and tested in Logisim
