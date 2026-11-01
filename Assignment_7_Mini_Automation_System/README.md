# A7 - Design a Mini Automation System (Parking Barrier Controller)
**CO coverage:** CO2 (primary)
**Aim:** Apply combinational and sequential design to a real automation
scenario: define the I/O, derive the FSM and logic, implement it in Logisim
and test every input scenario, including edge cases.

## Scenario
An automatic parking barrier. It opens for a car with a valid ticket, stays
open while a vehicle is under it, then closes.

## Inputs / outputs / constraints
| Signal | Type | Meaning |
|---|---|---|
| C | input | car at entry sensor |
| T | input | ticket valid |
| X | input | vehicle under barrier (safety loop) |
| Up | output | barrier up (green light) |
| MotorClose | output | motor driving the barrier down |
| Red | output | red light (= NOT Up) |

Constraint: the barrier must never close while X = 1.

## Design
States (2 D flip-flops): CLOSED = 00, OPEN = 01, CLOSING = 10.
State 11 is unused and returns to CLOSED.

    D1 = Q1'.Q0.X'
    D0 = Q1'.Q0'.C.T + X.(Q1 xor Q0)
    Up = Q1'.Q0    MotorClose = Q1.Q0'    Red = NOT Up

Full table: `state_table.md`. Test results: `test_cases.md`.

## Files
- `a7_barrier.v` - design, testbench and reference model
- `state_table.md`, `test_cases.md`
- `circuit/parking_barrier.circ` - Logisim circuit, plus screenshots
- `output.txt` - simulation log
- `prompts/prompts.md` - GenAI use (state table)

## How to run
    iverilog -g2012 -o sim a7_barrier.v
    vvp sim

## Result
Testbench output matches the reference model for the 8 scenarios and for
64 further input patterns. The unused state 11 recovers to CLOSED.

## Observations / edge cases
- Car with an invalid ticket: stays CLOSED.
- Vehicle under the barrier while OPEN: stays OPEN.
- Vehicle appears while CLOSING: reopens.
- Unused state 11: goes to CLOSED on the next clock edge.
- Power-on state is forced to CLOSED by reset.
- Not handled: a car and a valid ticket together with X = 1 while OPEN
  (the controller ignores them until the barrier closes and reopens).

## GenAI use
The state table was derived and checked with <tool, version>. See
`prompts/prompts.md`.
