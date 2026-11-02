
# A3 – Traffic Light FSM Discussion

## Design Overview

The traffic light controller is designed as a Finite State Machine (FSM) that manages vehicle traffic and pedestrian crossing based on a pedestrian request input.

The controller has four states:

1. **Green:** Vehicles are allowed to move. The controller remains in this state until a pedestrian request is received.
2. **Yellow:** The vehicle signal changes to Yellow before stopping traffic.
3. **Walk:** The vehicle signal is Red, and the pedestrian Walk signal is activated.
4. **Clearance:** The vehicle signal remains Red while the pedestrian crossing phase finishes.

After the Clearance state, the controller returns to Green.

## State Encoding

The four states use two flip-flops with Gray code encoding:

| State | Q1 Q0 |
|---|---|
| Green | 00 |
| Yellow | 01 |
| Walk | 11 |
| Clearance | 10 |

Only one state bit changes during each normal transition. This can help reduce switching-related glitches in the state representation.

## Flip-Flop Implementation

Two flip-flops store the current state using Q1 and Q0.

The next-state inputs are determined by:

- D1 = Q0
- D0 = Q1' (P + Q0)

The flip-flop outputs feed the combinational logic that determines the next state and traffic light outputs.

The controller starts in Green when reset is activated.

## Output Logic

The output signals are generated from the current state:

- Green = Q1' Q0'
- Yellow = Q1' Q0
- Red = Q1
- Walk = Q1 Q0

The Red signal is active in both Walk and Clearance states. The Walk signal is active only during the Walk state.

## Design Limitations and Edge Cases

- A pedestrian request is checked only while the controller is in Green.
- Requests received during Yellow, Walk, or Clearance are ignored.
- A request received at the same moment as the transition from Clearance to Green is not stored.
- Each state lasts for one clock cycle in the basic design.
- A practical traffic light controller would require timing logic to maintain each state for an appropriate duration.
- A request latch could be added to store pedestrian requests received outside the Green state.

## Conclusion

The FSM provides a structured approach to controlling vehicle and pedestrian signals. The two-flip-flop state representation, next-state equations, and output logic implement the required sequence while keeping the design relatively simple.
