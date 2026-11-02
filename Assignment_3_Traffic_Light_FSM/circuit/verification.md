
# A3 – Traffic Light FSM Verification

## Objective

To verify that the state transition table and Boolean equations produce the expected traffic light sequence for a pedestrian request.

## Verification of Next-State Equations

The derived equations are:

- D1 = Q0
- D0 = Q1' (P + Q0)

| Present State | P | Expected Next State | D1 D0 | Verification |
|---|---|---|---|---|
| Green (00) | 0 | Green (00) | 00 | PASS |
| Green (00) | 1 | Yellow (01) | 01 | PASS |
| Yellow (01) | X | Walk (11) | 11 | PASS |
| Walk (11) | X | Clearance (10) | 10 | PASS |
| Clearance (10) | X | Green (00) | 00 | PASS |

## Verification of Output Equations

The output equations are:

- Green = Q1' Q0'
- Yellow = Q1' Q0
- Red = Q1
- Walk = Q1 Q0

| State | Green | Yellow | Red | Walk | Expected Output |
|---|---|---|---|---|---|
| Green (00) | 1 | 0 | 0 | 0 | PASS |
| Yellow (01) | 0 | 1 | 0 | 0 | PASS |
| Walk (11) | 0 | 0 | 1 | 1 | PASS |
| Clearance (10) | 0 | 0 | 1 | 0 | PASS |

## Expected Operating Sequence

When a pedestrian request is received while the controller is in Green, the expected sequence is:

| Clock Cycle | Pedestrian Request (P) | State | Active Outputs |
|---|---|---|---|
| 0 | 0 | Green | Green |
| 1 | 1 | Yellow | Yellow |
| 2 | 1 | Walk | Red, Walk |
| 3 | 1 | Clearance | Red |
| 4 | 1 | Green | Green |

## Verification Observations

- The controller remains in Green when P = 0.
- When P = 1 in Green, the controller moves to Yellow.
- Yellow, Walk, and Clearance each transition to the next state independently of P.
- The Red output remains active during Walk and Clearance.
- The controller returns to Green after the Clearance state.
- Reset initializes the controller to Green.

## Result

The next-state equations and output equations are consistent with the specified state transition and output tables.

**Verification status:** PASS for the logical checks shown above.

*Note: This document records verification by logical evaluation. It does not claim that a physical circuit simulation was performed.*
