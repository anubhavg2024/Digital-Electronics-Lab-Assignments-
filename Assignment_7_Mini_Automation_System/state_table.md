# State Table – Parking Barrier Controller

## 1. Input Description

| Input | Description |
|---|---|
| C | Car detected at the entry. |
| T | Valid ticket signal. |
| X | Vehicle detected beneath the barrier. |

## 2. State Encoding

| State | Q1 | Q0 | Description |
|---|---:|---:|---|
| CLOSED | 0 | 0 | Barrier is closed. |
| OPEN | 0 | 1 | Barrier is open. |
| CLOSING | 1 | 0 | Barrier is moving towards the closed position. |
| UNUSED | 1 | 1 | Invalid state; returns to CLOSED. |

## 3. State Transition Table

| Current State | Q1Q0 | Condition | Next State | Next State Bits |
|---|---|---|---|---|
| CLOSED | 00 | C·T = 1 | OPEN | 01 |
| CLOSED | 00 | C·T = 0 | CLOSED | 00 |
| OPEN | 01 | X = 1 | OPEN | 01 |
| OPEN | 01 | X = 0 | CLOSING | 10 |
| CLOSING | 10 | X = 1 | OPEN | 01 |
| CLOSING | 10 | X = 0 | CLOSED | 00 |
| UNUSED | 11 | Any input | CLOSED | 00 |

## 4. Next-State Equations

The next-state inputs of the two D flip-flops are:

D1 = Q1' · Q0 · X'

D0 = Q1' · Q0' · C · T + X · (Q1 XOR Q0)

Where:
- D1 is the next value of Q1.
- D0 is the next value of Q0.
- Q1' and Q0' represent complemented state bits.

## 5. Output Equations

| Output | Boolean Expression | Function |
|---|---|---|
| Up | Q1' · Q0 | Indicates that the barrier is open. |
| MotorClose | Q1 · Q0' | Activates the closing motor. |
| Red | NOT Up | Indicates that the barrier is not open. |

## 6. Output State Table

| State | Q1Q0 | Up | MotorClose | Red |
|---|---|---:|---:|---:|
| CLOSED | 00 | 0 | 0 | 1 |
| OPEN | 01 | 1 | 0 | 0 |
| CLOSING | 10 | 0 | 1 | 1 |
| UNUSED | 11 | 0 | 0 | 1 |

## 7. Safety Behaviour

- The barrier remains open when X = 1.
- If a vehicle is detected beneath the barrier while closing, the controller transitions to OPEN.
- The barrier enters CLOSING only when X = 0.
- An invalid state (11) transitions to CLOSED.

## 8. Conclusion

The parking barrier controller uses a two-bit finite state machine with three defined operating states and one unused state.

The next-state equations determine the state transitions, while the output equations control the barrier position, closing motor and red indicator.
