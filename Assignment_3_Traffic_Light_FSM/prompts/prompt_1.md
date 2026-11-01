# Prompt–Response Log: Moore FSM Traffic Light Controller

## Prompt

Design a Moore FSM for a traffic light controller with Green, Yellow and a pedestrian Walk phase (cars see Red). It has one input P (pedestrian request) and stays Green until P=1. Use D flip-flops. Give the state diagram, state table with binary encoding, flip-flop input equations and output equations.

---

## Response

### Step 1: States and behavior

| State | Meaning         | Outputs          |
|-------|-----------------|------------------|
| G     | Cars green      | Green on         |
| Y     | Cars yellow     | Yellow on        |
| W     | Pedestrian walk | Cars red, Walk on |

- G holds while P = 0 and goes to Y when P = 1.
- Y always goes to W after one clock.
- W always goes back to G after one clock.
- P is only examined in G.

### Step 2: State diagram

```
            P=0
          ┌─────┐
          ▼     │
       ┌───────┐│        ┌───────┐         ┌───────┐
  ───► │   G   ├┘  P=1   │   Y   │  any P  │   W   │
reset  │  00   ├────────►│  01   ├────────►│  10   │
       │ Green │         │Yellow │         │ Walk  │
       └───────┘         └───────┘         │ + Red │
           ▲                               └───┬───┘
           │            any P                  │
           └───────────────────────────────────┘
```

Outputs are written inside the states, since this is a Moore machine and the outputs depend only on the state.

### Step 3: State assignment

Two flip-flops, Q1 Q0:

| State  | Q1 Q0 |
|--------|-------|
| G      | 00    |
| Y      | 01    |
| W      | 10    |
| unused | 11    |

### Step 4: State table (binary encoding)

| Present Q1 Q0 | P | Next Q1⁺ Q0⁺ | D1 | D0 |
|---------------|---|--------------|----|----|
| 00 (G)        | 0 | 00           | 0  | 0  |
| 00 (G)        | 1 | 01           | 0  | 1  |
| 01 (Y)        | 0 | 10           | 1  | 0  |
| 01 (Y)        | 1 | 10           | 1  | 0  |
| 10 (W)        | 0 | 00           | 0  | 0  |
| 10 (W)        | 1 | 00           | 0  | 0  |
| 11            | 0 | X X          | X  | X  |
| 11            | 1 | X X          | X  | X  |

For D flip-flops, D = next state, so D1 = Q1⁺ and D0 = Q0⁺.

### Step 5: Flip-flop input equations (K-maps)

**D1** (Q1Q0 as rows, P as columns):

```
 Q1Q0\P   0   1
   00     0   0
   01     1   1
   11     X   X
   10     0   0
```

Grouping the 1s with the X cells gives the column Q0 = 1 (rows 01 and 11):

**D1 = Q0**

**D0:**

```
 Q1Q0\P   0   1
   00     0   1
   01     0   0
   11     X   X
   10     0   0
```

The only 1 is Q1′Q0′P. Its neighbors are 0 or are not adjacent to an X cell, so the term cannot be enlarged:

**D0 = Q1′ · Q0′ · P**

### Step 6: Output equations (Moore, functions of state only)

| Output     | Expression    |
|------------|---------------|
| Green      | G = Q1′Q0′    |
| Yellow     | Y = Q1′Q0     |
| Walk       | WALK = Q1     |
| Red (cars) | RED = Q1      |

Red and Walk are the same signal, since cars stop only during the Walk phase. Exactly one of Green, Yellow and Red is on in every legal state.

### Step 7: Check

| State  | P | D1 D0 | Next |
|--------|---|-------|------|
| G (00) | 0 | 0 0   | G    |
| G (00) | 1 | 0 1   | Y    |
| Y (01) | x | 1 0   | W    |
| W (10) | x | 0 0   | G    |

The equations reproduce the state table.

**Unused state 11:** D1 = Q0 = 1 and D0 = Q1′Q0′P = 0, so state 11 goes to 10 (W) and then to G. The machine recovers from an illegal state within two clocks. Because the outputs are fully decoded, state 11 shows only Red and Walk, never a green or yellow light.

### Step 8: Circuit summary

- 2 D flip-flops (Q1, Q0), with a reset that forces 00 (Green).
- **D1:** a wire from Q0 to the D input of the Q1 flip-flop.
- **D0:** one 3-input AND with inputs Q1′, Q0′ and P.
- **Outputs:** one NOR for Green (Q1 + Q0)′, one AND for Yellow (Q1′ · Q0), and Q1 straight to both Walk and Red.

### Verilog

```verilog
module traffic_fsm (
    input  wire clk,
    input  wire rst,     // synchronous, active high
    input  wire P,       // pedestrian request
    output wire green,
    output wire yellow,
    output wire red,
    output wire walk
);
    reg q1, q0;

    wire d1 = q0;
    wire d0 = ~q1 & ~q0 & P;

    always @(posedge clk) begin
        if (rst) {q1, q0} <= 2'b00;
        else     {q1, q0} <= {d1, d0};
    end

    assign green  = ~q1 & ~q0;
    assign yellow = ~q1 &  q0;
    assign walk   =  q1;
    assign red    =  q1;
endmodule
```
