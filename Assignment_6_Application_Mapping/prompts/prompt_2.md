# Prompt–Response Log: Mod-60 Counter from a Mod-10 and a Mod-6 Counter

## Prompt

Explain how a Mod-60 counter can be built from a Mod-10 and a Mod-6 counter, and when the tens counter should be enabled.

---

## Response

### 1. The idea

60 = 10 × 6, so the counter is split into two decimal-style digits:

- **Units digit:** a Mod-10 counter, counting 0–9 (BCD, 4 flip-flops).
- **Tens digit:** a Mod-6 counter, counting 0–5 (3 flip-flops, since 2² = 4 < 6 ≤ 2³ = 8).

Together they hold values 00–59, which is exactly what a seconds or minutes display needs, one 7-segment digit each. Total: **7 flip-flops**, matching the BCD figure in the clock design.

### 2. Wiring

```
 enable ──────────────┬──► [ Mod-10 units ] ── Q3..Q0 ──► units digit
 (tick)               │         │
                      │    units_tc (= 9)
                      │         │
                      └──[AND]──┘
                          │
                     tens_en
                          │
                          ▼
                    [ Mod-6 tens ] ── Q2..Q0 ──► tens digit
                          │
                     tens_tc (= 5)
                          │
 carry_out = enable · units_tc · tens_tc ──► next stage (e.g. minutes or hours)
```

### 3. When the tens counter is enabled

The tens digit must advance only when the units digit wraps from 9 to 0, which means on the same clock edge when both of these are true:

**tens_en = enable · (units == 9)**

In binary, units = 9 is 1001, so with the unreachable values 10–15 as don't-cares:

**units_tc = Q3 · Q0**

and therefore **tens_en = enable · Q3 · Q0**.

Why this works:

- If units ≠ 9 the tens digit holds, because a carry has not occurred.
- If units = 9 and the tick arrives, units goes to 0 and tens goes up by one on that same edge. The carry is computed from the old value (9), so there is no ripple delay.

### 4. Wrap behavior

- **Units:** counts 0 → 9, then clears to 0 when enabled at 9.
- **Tens:** counts 0 → 5 when tens_en = 1, and clears to 0 when tens_en = 1 and tens = 5. Binary 5 is 101, so **tens_tc = T2 · T0** (don't-cares for 6 and 7).
- **Full wrap:** at 59 (tens = 5, units = 9) the next tick clears both digits to 00 together and produces a carry-out:

**carry_out = enable · Q3 · Q0 · T2 · T0**

Sample sequence:

| Present (tens, units) | enable | Next                          |
|-----------------------|--------|-------------------------------|
| 0, 8                  | 1      | 0, 9                          |
| 0, 9                  | 1      | 1, 0 (tens enabled)           |
| 3, 9                  | 1      | 4, 0                          |
| 5, 8                  | 1      | 5, 9                          |
| 5, 9                  | 1      | 0, 0 and carry_out = 1        |

### 5. Verilog

```verilog
module mod60_bcd (
    input  wire       clk,
    input  wire       rst,        // synchronous, active high
    input  wire       en,         // count enable (e.g. 1 Hz tick)
    output reg  [3:0] units,      // 0-9
    output reg  [2:0] tens,       // 0-5
    output wire       carry_out   // 1 when 59 and en
);

    wire units_tc = (units == 4'd9);
    wire tens_tc  = (tens  == 3'd5);

    wire tens_en  = en & units_tc;

    assign carry_out = tens_en & tens_tc;

    always @(posedge clk) begin
        if (rst) begin
            units <= 4'd0;
            tens  <= 3'd0;
        end else begin
            if (en)
                units <= units_tc ? 4'd0 : units + 4'd1;
            if (tens_en)
                tens  <= tens_tc  ? 3'd0 : tens + 3'd1;
        end
    end

endmodule
```

### 6. Design notes

- **Enable, not clock:** the tens counter shares the same clock and uses `tens_en` as an enable. Using the units' output as the tens' clock would make a ripple design with late and possibly glitchy digit changes.
- **Don't forget the `en` term:** if `tens_en` were only `units == 9`, the tens digit would advance on every clock while units sits at 9 between ticks, since the fast clock runs far more often than the 1 Hz tick. This is the most common bug in this design.
- **Same pattern elsewhere:** a 24-hour counter can be built the same way, as a units digit (mod-10, but wrapping at 3 when tens = 2) and a tens digit (mod-3).
