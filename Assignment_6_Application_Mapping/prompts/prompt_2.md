# Prompt–Response Log: Mod-60 Counter from a Mod-10 and a Mod-6 Counter

## Prompt

Explain how a Mod-60 counter can be built from a Mod-10 and a Mod-6 counter, and when the tens counter should be enabled.

---

## Response

### 1. The idea

Since 60 = 10 × 6, the counter is split into two decimal-style digits:

- **Units digit:** a Mod-10 counter counting 0–9 (BCD, 4 flip-flops).
- **Tens digit:** a Mod-6 counter counting 0–5 (3 flip-flops, since 2² = 4 < 6 ≤ 2³ = 8).

Together they hold 00–59, which is exactly what a seconds or minutes display needs: one 7-segment digit each. Total: **7 flip-flops**, matching the BCD figure in the clock design.

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
 carry_out = enable · units_tc · tens_tc ──► next stage
```

### 3. When the tens counter is enabled

The tens digit must advance only when the units digit wraps from 9 to 0. That means the tens counter is enabled when both of these are true at the same time:

- The overall count enable (for example the 1 Hz tick) is active.
- The units digit currently equals 9.

**tens_en = enable · (units == 9)**

In binary, 9 is 1001. Since units never reaches 10–15, those values are don't-cares, so the detection simplifies to **units_tc = Q3 · Q0**, and **tens_en = enable · Q3 · Q0**.

Why this works:

- **Units ≠ 9:** the tens digit holds, because no carry has occurred.
- **Units = 9 and the tick arrives:** units goes to 0 and tens goes up by one on the same clock edge. The carry is computed from the old value (9), so there is no ripple delay.

#### The common mistake

If `tens_en` were only "units == 9" without the enable term, then with a fast system clock and a slow 1 Hz tick, the units digit would sit at 9 for a whole second. The tens digit would then advance on every fast clock edge during that time. Including the enable in the AND is what ties the tens update to the actual tick.

### 4. Wrap behavior

- **Units:** counts 0 → 9, then clears to 0 on the next enabled clock.
- **Tens:** counts 0 → 5 only when tens_en = 1, and clears to 0 when tens_en = 1 and tens = 5. Binary 5 is 101, so **tens_tc = T2 · T0** (6 and 7 are don't-cares).
- **Full wrap at 59:** with tens = 5 and units = 9, the next tick clears both digits to 00 on the same edge and produces a carry-out:

**carry_out = enable · units_tc · tens_tc**

This carry-out is the enable for the next stage, such as minutes or hours.

Sample sequence:

| Present (tens, units) | Enable | Next                          |
|-----------------------|--------|-------------------------------|
| 0, 8                  | 1      | 0, 9                          |
| 0, 9                  | 1      | 1, 0 (tens enabled)           |
| 3, 9                  | 1      | 4, 0                          |
| 5, 8                  | 1      | 5, 9                          |
| 5, 9                  | 1      | 0, 0, with carry-out = 1      |
| any                   | 0      | unchanged                     |

### 5. Design notes

- **Enable, not clock:** both digits share the same clock, and the tens digit uses `tens_en` as an enable. Using the units digit's output as the tens digit's clock would make a ripple design, with late and possibly glitchy digit changes.
- **Reset:** a synchronous reset forces both digits to 0, giving 00, and has priority over the enables.
- **Same pattern elsewhere:** a 24-hour counter can be built the same way, with a units digit (mod-10, but wrapping at 3 when tens = 2) and a tens digit (mod-3).
