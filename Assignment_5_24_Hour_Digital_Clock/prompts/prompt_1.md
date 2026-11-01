# Prompt–Response Log: 24-Hour Digital Clock, FSM and Flip-Flop Design

## Prompt

Derive the FSM and flip-flop-based design for a 24-hour digital clock with seconds, minutes and hours counters driven by a 1 Hz clock. Give the state transitions, carry/enable logic between the counters, the number of flip-flops needed for each counter, and the reset condition.

---

## Response

### 1. FSM view

The clock is a Moore machine with no data input, and its state is the time itself:

- State = (hours, minutes, seconds), where hours are 0–23 and minutes and seconds are 0–59.
- Number of states = 24 × 60 × 60 = **86,400**.
- Outputs = the stored counter values (a Moore machine whose outputs are decoded from the state).
- Every tick (1 Hz) moves to the next state. After 23:59:59 it wraps to 00:00:00, so the state graph is a single 86,400-state cycle.

Listing 86,400 states is impractical, so the machine is decomposed into three cascaded modulo counters.

### 2. Flip-flops per counter

| Counter | Modulus | Range | Binary FFs        | BCD FFs (for 7-segment) |
|---------|---------|-------|-------------------|-------------------------|
| Seconds | 60      | 0–59  | 6 (2⁶ = 64 ≥ 60) | 7 (3 + 4)               |
| Minutes | 60      | 0–59  | 6                 | 7 (3 + 4)               |
| Hours   | 24      | 0–23  | 5 (2⁵ = 32 ≥ 24)  | 6 (2 + 4)               |
| **Total** | 86,400 |      | **17**            | **20**                  |

17 is also the theoretical minimum, since 2¹⁶ = 65,536 < 86,400 ≤ 2¹⁷ = 131,072. The binary design uses D flip-flops with synchronous clear. The BCD version is easier to display but costs 3 more flip-flops.

### 3. State transitions

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

### 5. Carry/enable logic

All flip-flops share one clock (fully synchronous), and the carries act as enables, not as clocks:

```
sec_en = tick            (the 1 Hz tick)
min_en = sec_en · sec_tc
hr_en  = min_en · min_tc
```

Each counter's flip-flops update on the same clock edge, and a higher counter only changes when its enable is 1.

Per-counter next-state equations, with qᵢ the bits, en the counter's enable and tc its terminal-count signal:

```
clr = en · tc                                   (wrap to zero)
Dᵢ  = ¬rst · ¬clr · (qᵢ ⊕ (en · qᵢ₋₁ · … · q₀))
```

For bit 0 the carry term is just en, so D₀ = ¬rst · ¬clr · (q₀ ⊕ en). When en = 0 the counter holds, and when en = 1 it counts up or clears.

### 6. Reset condition

**Power-on or manual reset:** rst = 1 forces all 17 flip-flops to 0, which is 00:00:00. It is synchronous and has priority over everything else.

**Natural wrap (no extra reset needed):** the clear happens on the tick when

- seconds: s = 59 → clr_s = tick · sec_tc
- minutes: m = 59 and s = 59 → clr_m = min_en · min_tc
- hours: h = 23, m = 59 and s = 59 → clr_h = hr_en · hr_tc

So 23:59:59 followed by a tick sets all three counters to 0 in the same edge.

### 7. Verilog

```verilog
module clock24 (
    input  wire       clk,    // fast system clock
    input  wire       rst,    // synchronous, active high -> 00:00:00
    input  wire       tick,   // one-clock-wide pulse at 1 Hz
    output reg  [4:0] hr,     // 0-23
    output reg  [5:0] min,    // 0-59
    output reg  [5:0] sec     // 0-59
);

    // Terminal counts (>= so out-of-range values also wrap)
    wire sec_tc = (sec >= 6'd59);
    wire min_tc = (min >= 6'd59);
    wire hr_tc  = (hr  >= 5'd23);

    // Carry/enable chain
    wire sec_en = tick;
    wire min_en = sec_en & sec_tc;
    wire hr_en  = min_en & min_tc;

    always @(posedge clk) begin
        if (rst) begin
            sec <= 6'd0;
            min <= 6'd0;
            hr  <= 5'd0;
        end else begin
            if (sec_en) sec <= sec_tc ? 6'd0 : sec + 6'd1;
            if (min_en) min <= min_tc ? 6'd0 : min + 6'd1;
            if (hr_en)  hr  <= hr_tc  ? 5'd0 : hr  + 5'd1;
        end
    end

endmodule

// 1 Hz tick generator from a fast clock (set CLK_HZ to your clock frequency)
module tick_gen #(parameter integer CLK_HZ = 50_000_000) (
    input  wire clk,
    input  wire rst,
    output reg  tick
);
    reg [$clog2(CLK_HZ)-1:0] cnt;
    always @(posedge clk) begin
        if (rst) begin
            cnt  <= 0;
            tick <= 1'b0;
        end else if (cnt == CLK_HZ - 1) begin
            cnt  <= 0;
            tick <= 1'b1;
        end else begin
            cnt  <= cnt + 1'b1;
            tick <= 1'b0;
        end
    end
endmodule
```

If your board literally gives a 1 Hz clock, drop `tick` and use `sec_en = 1`. A tick-enable on a fast clock is usually preferred, because it avoids derived clocks and timing problems.

### 8. Design notes

- **Synchronous, not ripple:** a ripple design with each counter clocking the next would make minute or hour changes appear a few nanoseconds late, and decoded displays could glitch. The enable chain avoids this.
- **Illegal states:** values such as sec = 60–63 or hr = 24–31 can only occur from a power-up or noise upset. The `>=` comparison in the Verilog sends them back into range on the next carry. If you use the shorter `==` decode with don't-cares, an out-of-range value still counts up to a pattern that matches (for example 60 → 61 → 62 → 63, where 63 matches the shortened sec_tc) and wraps, but it can run for a few extra ticks.
- **Display glitches:** if you decode the counters to 7-segment outputs, binary-to-BCD conversion (or BCD counters) is needed. The BCD version replaces "+1" with a decade counter: the units digit wraps at 9, the tens digit wraps at 5 (minutes, seconds), and the hours wrap at 23.
