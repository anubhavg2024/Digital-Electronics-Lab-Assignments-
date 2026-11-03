# Prompt–Response Log: 24-Hour Digital Clock, FSM and Flip-Flop Design

## Prompt

Derive the FSM and flip-flop-based design for a 24-hour digital clock with seconds, minutes and hours counters driven by a 1 Hz clock. Give the state transitions, carry/enable logic between the counters, the number of flip-flops needed for each counter, and the reset condition.

---

## Response

### FSM view

The clock is a Moore machine with no data input, and its state is the time itself:

- State = (hours, minutes, seconds), where hours are 0–23 and minutes and seconds are 0–59.
- Number of states = 24 × 60 × 60 = **86,400**.
- Outputs = the stored counter values (a Moore machine whose outputs are decoded from the state).
- Every tick (1 Hz) moves to the next state. After 23:59:59 it wraps to 00:00:00, so the state graph is a single 86,400-state cycle.

Listing 86,400 states is impractical, so the machine is decomposed into three cascaded modulo counters.

### Flip-flops per counter

| Counter | Modulus | Range | Binary FFs        | BCD FFs (for 7-segment) |
|---------|---------|-------|-------------------|-------------------------|
| Seconds | 60      | 0–59  | 6 (2⁶ = 64 ≥ 60) | 7 (3 + 4)               |
| Minutes | 60      | 0–59  | 6                 | 7 (3 + 4)               |
| Hours   | 24      | 0–23  | 5 (2⁵ = 32 ≥ 24)  | 6 (2 + 4)               |
| **Total** | 86,400 |      | **17**            | **20**                  |

17 is also the theoretical minimum, since 2¹⁶ = 65,536 < 86,400 ≤ 2¹⁷ = 131,072. The binary design uses D flip-flops with synchronous clear. The BCD version is easier to display but costs 3 more flip-flops.

### State transitions

**Seconds (s):**

- s → s + 1 for s = 0 … 58
- 59 → 0 (and generates a carry)

**Minutes (m),** only when the seconds carry fires:

- m → m + 1 for m = 0 … 58
- 59 → 0 (and generates a carry)

**Hours (h),** only when the minutes carry fires:

- h → h + 1 for h = 0 … 22
- 23 → 0

Example full-clock transitions:

| Present  | Next     |
|----------|----------|
| 05:23:41 | 05:23:42 |
| 05:23:59 | 05:24:00 |
| 12:59:59 | 13:00:00 |
| 23:59:59 | 00:00:00 |

### 4. Terminal-count detection

Binary encodings of the last values:

| Value | Binary | Full decode          | Simplified decode (unreachable values as don't-cares) |
|-------|--------|----------------------|--------------------------------------------------------|
| 59    | 111011 | s5·s4·s3·s2′·s1·s0   | s5·s4·s3·s1·s0 |
| 23    | 10111  | h4·h3′·h2·h1·h0      | h4·h2·h1·h0    |

The simplification works because the counters never reach 60–63 or 24–31, so no other reachable value matches these shorter products. The full decode costs one more input per gate. It is the `>=` comparison in the Verilog (section 7) that forces out-of-range values to wrap, as discussed in section 8.

```
sec_tc = (sec == 59)
min_tc = (min == 59)
hr_tc  = (hr  == 23)
```

### Carry/enable logic

The architecture is fully synchronous, sharing a single master clock across all flip-flops. Carries function as enable lines rather than secondary clocks:

[sec_en = tick]

[min_en = sec_en . sec_tc]

[hr_en = min_en . min_tc]

Higher-order counters remain in a hold state unless their respective enable conditions evaluate to true.

### Reset condition

A synchronous reset signal forces all counter flip-flops to zero, immediately initializing the time to 00:00:00. Natural rollover occurs when 23:59:59 transitions on the next clock edge, simultaneously clearing all counters back to zero.

### Design notes

- Synchronous Execution: Utilizing an enable-chain approach instead of a ripple architecture avoids propagation delays and eliminates transient display glitches.

- Robust Range Handling: Terminal count detection ensures correct wrap-around behavior across all active states.
