
# A3 – Traffic Light FSM Truth Table

## State Encoding

| State | Q1 Q0 | Green | Yellow | Red | Walk |
|---|---|---|---|---|---|
| Green (G) | 00 | 1 | 0 | 0 | 0 |
| Yellow (Y) | 01 | 0 | 1 | 0 | 0 |
| Walk (W) | 11 | 0 | 0 | 1 | 1 |
| Clearance (R) | 10 | 0 | 0 | 1 | 0 |

## State Transition Table

| Present State | Q1 Q0 | Pedestrian Request (P) | Next State | D1 D0 |
|---|---|---|---|---|
| Green | 00 | 0 | Green | 00 |
| Green | 00 | 1 | Yellow | 01 |
| Yellow | 01 | X | Walk | 11 |
| Walk | 11 | X | Clearance | 10 |
| Clearance | 10 | X | Green | 00 |

**Note:** X represents a don't-care condition because the pedestrian request is not checked in those states.

## Output Table

| Q1 Q0 | Green | Yellow | Red | Walk |
|---|---|---|---|---|
| 00 | 1 | 0 | 0 | 0 |
| 01 | 0 | 1 | 0 | 0 |
| 11 | 0 | 0 | 1 | 1 |
| 10 | 0 | 0 | 1 | 0 |

## Logic Equations

### Next-State Equations

- D1 = Q0
- D0 = Q1' (P + Q0)

### Output Equations

- Green = Q1' Q0'
- Yellow = Q1' Q0
- Red = Q1
- Walk = Q1 Q0

## Conclusion

The state and output tables describe the expected operation of the traffic light controller. The controller remains in Green until a pedestrian request is received, then follows the sequence Yellow, Walk, Clearance, and back to Green.
