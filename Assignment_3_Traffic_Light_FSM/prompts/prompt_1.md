# Prompt–Response Log: Moore FSM Traffic Light Controller

## Prompt

Design a Moore FSM for a traffic light controller with Green, Yellow, Pedestrian Walk, and Red Clearance phases. The controller has one input P (pedestrian request) and four outputs: Green, Yellow, Red, and Walk.

The controller must remain in Green while P = 0. When P = 1, it must follow the sequence Green → Yellow → Walk → Red Clearance → Green.

Use two D flip-flops with Gray code state encoding. Provide the state diagram, state table, flip-flop input equations, output equations, and a gate-level implementation description.

---

## Response

### Step 1: States and behavior

| State | Meaning | Outputs |
|---|---|---|
| G | Cars green | Green ON |
| Y | Cars yellow | Yellow ON |
| W | Pedestrian walk | Red ON, Walk ON |
| R | Red clearance | Red ON |

- G holds while P = 0 and transitions to Y when P = 1.
- Y transitions to W after one clock cycle.
- W transitions to R after one clock cycle.
- R transitions back to G after one clock cycle.
- P is examined only in the Green state.

### Step 2: State assignment

Two flip-flops, Q1 and Q0, are used.

| State | Q1 Q0 |
|---|---|
| G | 00 |
| Y | 01 |
| W | 11 |
| R | 10 |

The assignments follow Gray code, so only one state bit changes during each normal transition.

### Step 3: State table

| Present Q1 Q0 | P | Next state D1 D0 |
|---|---|---|
| 00 (G) | 0 | 00 |
| 00 (G) | 1 | 01 |
| 01 (Y) | X | 11 |
| 11 (W) | X | 10 |
| 10 (R) | X | 00 |

For D flip-flops, the inputs correspond to the next-state bits.

### Step 4: Flip-flop input equations

The simplified equations are:

\[
D_1=Q_0
\]

\[
D_0=Q_1'(P+Q_0)
\]

### Step 5: Output equations

| Output | Expression |
|---|---|
| Green | \(Q_1'Q_0'\) |
| Yellow | \(Q_1'Q_0\) |
| Red | \(Q_1\) |
| Walk | \(Q_1Q_0\) |

### Step 6: Gate-level implementation

- Two D flip-flops store the current state.
- The reset input initializes the controller to state 00 (Green).
- The D1 input is connected to Q0.
- The D0 input is generated using NOT, OR, and AND gates according to \(D_0=Q_1'(P+Q_0)\).
- The Green, Yellow, Red, and Walk outputs are generated using the corresponding output equations.

### Conclusion

The designed Moore FSM follows the required traffic light sequence. The state table and logic equations describe the required transitions and output behavior.
