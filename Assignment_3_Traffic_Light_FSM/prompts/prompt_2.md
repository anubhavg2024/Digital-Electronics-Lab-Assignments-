# Prompt–Response Log: Design Verification of Traffic Light FSM

## Prompt

Check the Moore FSM traffic light controller for state assignment, pedestrian requests during Yellow, Walk, and Red Clearance, and the effect of Gray code encoding. Explain the expected behavior, recovery characteristics, and any limitations of the design.

---

## Response

### Step 1: State assignment

All four possible two-bit combinations are assigned to valid states:

| State | Q1 Q0 |
|---|---|
| G | 00 |
| Y | 01 |
| W | 11 |
| R | 10 |

Therefore, there are no unused state encodings.

### Step 2: Pedestrian request during different states

- **During Green:** P is checked. If P = 1, the controller transitions to Yellow.
- **During Yellow:** P is ignored because the controller is already proceeding to the Walk phase.
- **During Walk:** P is ignored. A new request is not stored.
- **During Red Clearance:** P is ignored. The controller returns to Green.

### Step 3: Gray code encoding

The state sequence is:

The state sequence is:

(00 --> 01 --> 11 --> 10 --> 00)

Only one flip-flop output changes during each normal transition. This reduces the possibility of transition-related glitches in the state bits.

### Step 4: Additional observations and limitations

- Reset initializes the controller to Green.
- Each state lasts for one clock cycle in the basic design.
- A pedestrian request made during Walk or Red Clearance is not remembered.
- If P remains high, the controller can return to Yellow immediately after entering Green.
- A request latch could be added to retain pedestrian requests.
- A timing mechanism could be added to enforce minimum signal durations.

### Conclusion

The FSM follows the required traffic light sequence. Its state transitions and output equations are consistent with the specified behavior. The design can be implemented using two D flip-flops and combinational logic gates.
