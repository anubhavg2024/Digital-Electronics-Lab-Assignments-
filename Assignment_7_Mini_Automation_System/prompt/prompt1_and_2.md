# A7 – GenAI Prompt–Response Log

## Prompt 1: Parking Barrier Controller FSM Design

**Prompt:**

Design a finite state machine (FSM) for an automated parking barrier controller using the following requirements:

- Inputs:
  - C: Car detected at entry.
  - T: Valid ticket.
  - X: Vehicle detected beneath the barrier.

- States:
  - CLOSED = 00
  - OPEN = 01
  - CLOSING = 10
  - Unused state 11 must return to CLOSED.

- State transitions:
  - CLOSED: If C·T = 1, transition to OPEN; otherwise remain CLOSED.
  - OPEN: If X = 1, remain OPEN; if X = 0, transition to CLOSING.
  - CLOSING: If X = 1, return to OPEN; if X = 0, transition to CLOSED.
  - State 11: Return to CLOSED for any input combination.

Derive the next-state equations and output equations. Also provide the state transition table, output table, component requirements and expected verification cases suitable for a Logisim implementation.

## GenAI Response

The controller can be implemented as a two-bit FSM using two D flip-flops and combinational logic.

### State Encoding

| State | Q1Q0 | Description |
|---|---|---|
| CLOSED | 00 | Barrier closed |
| OPEN | 01 | Barrier open |
| CLOSING | 10 | Barrier moving towards closed |
| UNUSED | 11 | Invalid state; returns to CLOSED |

### Next-State Equations

The derived next-state equations are:

- D1 = Q1'·Q0·X'
- D0 = Q1'·Q0'·C·T + X·(Q1 XOR Q0)

### Output Equations

- Up = Q1'·Q0
- MotorClose = Q1·Q0'
- Red = NOT Up

### Component Requirements

- Two D flip-flops for state storage.
- AND gates for product terms.
- OR gates for combining logic terms.
- Inverters or complemented gate inputs.
- An XOR gate for the next-state logic.
- Input pins for C, T and X.
- Output indicators for Up, MotorClose and Red.
- A clock and reset mechanism.

### Expected State Transitions

| Current State | Condition | Expected Next State |
|---|---|---|
| CLOSED (00) | C·T = 1 | OPEN (01) |
| CLOSED (00) | C·T = 0 | CLOSED (00) |
| OPEN (01) | X = 1 | OPEN (01) |
| OPEN (01) | X = 0 | CLOSING (10) |
| CLOSING (10) | X = 1 | OPEN (01) |
| CLOSING (10) | X = 0 | CLOSED (00) |
| UNUSED (11) | Any input | CLOSED (00) |

### Expected Output Table

| State | Up | MotorClose | Red |
|---|---:|---:|---:|
| CLOSED (00) | 0 | 0 | 1 |
| OPEN (01) | 1 | 0 | 0 |
| CLOSING (10) | 0 | 1 | 1 |
| UNUSED (11) | 0 | 0 | 1 |

### Expected Verification Cases

The expected verification should cover:

1. A valid car and ticket request causes the barrier to open.
2. An invalid ticket leaves the barrier closed.
3. The barrier remains open while a vehicle is beneath it.
4. The barrier enters the closing state when the vehicle is no longer beneath it.
5. Detection of a vehicle during closing causes the barrier to return to OPEN.
6. The barrier reaches CLOSED when the safety condition permits closing.
7. The unused state returns to CLOSED.

These cases provide a basis for checking the expected behaviour of the controller.

---

## Review and Application of the GenAI Response

The generated response was used as a reference for organising the FSM design, identifying the required components, and documenting the state transitions and output logic.

The state encoding, next-state equations and output equations were incorporated into the assignment documentation.

The expected verification cases were derived from the specified state transitions and output equations. They are presented as theoretical expected results rather than confirmed Logisim simulation observations.

## Conclusion

GenAI assisted in structuring the parking barrier controller design and explaining how the FSM can be represented using D flip-flops and combinational logic. The generated information was adapted to the assignment requirements and used to prepare the circuit documentation and expected verification table.
