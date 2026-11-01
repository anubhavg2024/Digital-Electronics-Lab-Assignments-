# Prompt–Response Log: Design Check of the Traffic Light FSM

## Prompt

Check your design for unused states and for what happens if P is pressed during Yellow or Walk. Is the encoding glitch-free?

---

## Response

### 1. Unused state (11)

| Present Q1 Q0 | P | D1 = Q0 | D0 = Q1′Q0′P | Next |
|---------------|---|---------|--------------|------|
| 11            | 0 or 1 | 1  | 0            | 10 (W) |

State 11 goes to W, and W goes to G on the next clock, so the machine is self-correcting. It recovers in two clocks regardless of P. In state 11, Green and Yellow are both 0 (Q1′Q0′ = 0 and Q1′Q0 = 0), and Red and Walk are on, so an illegal state never shows a green or yellow light.

This holds only because the don't-cares (X) in the K-maps were chosen so that they lead back to a legal state. It was verified above rather than assumed.

### 2. P pressed during Yellow or Walk

D1 and D0 do not depend on P in states Y and W, so P is ignored there:

- **P during Y:** no effect. The machine was already heading to W, so the request is being served anyway.
- **P during W:** the request is lost. There is no memory of it, so a pedestrian who presses during Walk must press again once the light is Green.
- **P held high through the whole cycle:** W returns to G, and G sees P = 1 on the next clock and goes straight to Y. Green lasts one clock cycle, so there is no minimum green time. If that matters, add a green-time counter or a request latch (set by P, cleared when W ends) and a
