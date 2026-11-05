# Prompt–Response Log: 24-Hour Digital Clock, FSM and Flip-Flop Design

## Prompt

Derive the FSM and flip-flop-based design for a 24-hour digital clock with seconds, minutes and hours counters driven by a 1 Hz clock. Give the state transitions, carry/enable logic between the counters, the number of flip-flops needed for each counter, and the reset condition.

---

### 1. FSM view

The clock is a Moore machine with no data input. Its state is the time itself:

- State = (hours, minutes, seconds), with hours 0–23 and minutes and seconds 0–59.
- Number of states = 24 × 60 × 60 = **86,400**.
- Outputs are the stored counter values, so they depend only on the state.
- Each 1 Hz tick moves to the next state. After 23:59:59 it wraps to 00:00:00, so the state graph is one 86,400-state cycle.

Drawing 86,400 states is impractical, so the machine is split into three cascaded modulo counters: seconds (mod-60), minutes (mod-60) and hours (mod-24).

### 2. Flip-flops per counter

| Counter   | Modulus | Range | Binary FFs        | BCD FFs (for 7-segment) |
|-----------|---------|-------|-------------------|-------------------------|
| Seconds   | 60      | 0–59  | 6 (2⁶ = 64 ≥ 60)  | 7 (units 4 + tens 3)    |
| Minutes   | 60      | 0–59  | 6                 | 7 (units 4 + tens 3)    |
| Hours     | 24      | 0–23  | 5 (2⁵ = 32 ≥ 24) | 6 (units 4 + tens 2)    |
| **Total** | 86,400  |       | **17**            | **20**                  |

17 is the theoretical minimum, since 2¹⁶ = 65,536 < 86,400 ≤ 2¹⁷ = 131,072. The BCD version costs 3 more flip-flops but maps directly to 7-segment digits.

### 3. State transitions

**Seconds (s):** it advances on every 1 Hz tick.

- s → s + 1 for s = 0 … 58
- 59 → 0, and a carry is generated

**Minutes (m):** it advances only when the seconds carry fires.

- m → m + 1 for m = 0 … 58
- 59 → 0, and a carry is generated

**Hours (h):** it advances only when the minutes carry fires.

- h → h + 1 for h = 0 … 22
- 23 → 0

Example full-clock transitions:

| Present (hh:mm:ss) | Next     |
|--------------------|----------|
| 05:23:41           | 05:23:42 |
| 05:23:59           | 05:24:00 |
| 12:59:59           | 13:00:00 |
| 23:59:59           | 00:00:00 |

### 4. Terminal-count detection

| Value | Binary | Decode (unreachable values as don't-cares) |
|-------|--------|---------------------------------------------|
| 59    | 111011 | s5·s4·s3·s1·s0                              |
| 23    | 10111  | h4·h2·h1·h0                                 |

These shortened decodes work because the counters never reach 60–63 or 24–31. The signals are:

```
sec_tc = (sec == 59)
min_tc = (min == 59)
hr_tc  = (hr  == 23)
```

### 5. Carry/enable logic

All flip-flops share the same clock (fully synchronous), and the carries act as enables, not as clocks:

```
sec_en = tick              (the 1 Hz pulse)
min_en = sec_en · sec_tc
hr_en  = min_en · min_tc
```

Per-counter behavior, with `en` the counter's enable and `tc` its terminal-count signal:

- `en = 0`: the counter holds its value.
- `en = 1` and `tc = 0`: the counter increments.
- `en = 1` and `tc = 1`: the counter clears to 0 (wrap).

With D flip-flops, the D inputs are the next-state value of this rule. The synchronous reset sits above it with the highest priority.

If your board supplies a true 1 Hz clock, `sec_en` is simply tied to 1. If it supplies a fast clock, a divider produces a one-clock-wide 1 Hz tick that is used as `sec_en`. The tick-enable approach is usually preferred because it avoids derived clocks and timing problems.

### 6. Reset condition

- **Power-on or manual reset:** `rst = 1` forces all 17 flip-flops to 0, which is 00:00:00. It is synchronous and overrides everything else.
- **Natural wrap (no extra reset needed):** the counters clear themselves on the tick when
  - seconds: s = 59
  - minutes: m = 59 and s = 59
  - hours: h = 23, m = 59 and s = 59

So 23:59:59 followed by a tick clears all three counters on the same edge.

### 7. Design notes

- **Synchronous, not ripple:** with a ripple design, each counter clocks the next, so minute and hour changes would appear a few nanoseconds late and decoded displays could glitch. The enable chain avoids this, since every enable is computed from the old values before the edge.
- **Illegal states:** values such as sec = 60–63 or hr = 24–31 can only occur from a power-up or noise upset. Using a "greater than or equal to" comparison for the terminal count sends them back into range on the next carry. The shortened `==` decode still recovers, but only after a few extra ticks.
