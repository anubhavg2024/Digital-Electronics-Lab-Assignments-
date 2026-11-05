# Prompt–Response Log: The 23:59:59 → 00:00:00 Clock Edge

## Prompt

Explain exactly what happens on the clock edge when the time goes from 23:59:59 to 00:00:00.

---

### Before the edge (everything settled)

The registers hold:

| Counter | Value | Binary |
|---------|-------|--------|
| Hours   | 23    | 10111  |
| Minutes | 59    | 111011 |
| Seconds | 59    | 111011 |

The combinational logic has already settled on these values:

| Signal | Value | Why                        |
|--------|-------|----------------------------|
| sec_tc | 1     | seconds = 59               |
| min_tc | 1     | minutes = 59               |
| hr_tc  | 1     | hours = 23                 |
| sec_en | 1     | the 1 Hz tick is active    |
| min_en | 1     | sec_en · sec_tc = 1 · 1    |
| hr_en  | 1     | min_en · min_tc = 1 · 1    |
| rst    | 0     | normal operation           |

All three enables are 1 at the same moment. The carry chain is combinational, so it finished settling before the edge arrived. It is computed only from the old register values.

### At the edge

Every flip-flop samples its D input at the same instant. Each counter sees its enable and its terminal count both at 1, which means "wrap to zero":

- **Seconds:** D = 000000
- **Minutes:** D = 000000
- **Hours:** D = 00000

All 17 flip-flops capture 0 together, and the new state is **00:00:00**. The reset has no part in this, since `rst` is 0 and the clear comes from the counters' own wrap rule.

### Why all three change at once

- **No ripple.** Minutes and hours don't wait for seconds to change first. Their enables were already computed from the old values (59 and 59), so all three counters wrap on the same edge.
- **Next state depends only on the old state.** Every D input is a function of the pre-edge register contents. A flip-flop captures its input at the edge and its output changes only after that, so no flip-flop sees another one's new value in the same cycle.

### Just after the edge

- **Brief transient.** Clock-to-output delays differ slightly between flip-flops, so for a few nanoseconds the outputs can show a mix of old and new bits. The next edge samples only after this has settled, so the counters are unaffected. A display decoded directly from these bits could flicker, which is why displays are usually fed from registered or latched outputs.
- **Enables fall.** Once the counters read 00:00:00, `sec_tc`, `min_tc` and `hr_tc` all drop to 0, so `min_en` and `hr_en` go to 0. With a one-clock-wide tick, `sec_en` (= `tick`) also drops, because the pulse has ended. With a true 1 Hz clock, `sec_en` is tied to 1 and stays high. Nothing more changes until the next tick.
- **Next tick.** Only the seconds counter is enabled, and the time becomes 00:00:01.

### Timeline

| Moment                                   | hh:mm:ss | sec_en / min_en / hr_en |
|------------------------------------------|----------|-------------------------|
| Just before the edge                     | 23:59:59 | 1 / 1 / 1               |
| Just after the edge, settled             | 00:00:00 | 0 / 0 / 0 (until next tick) |
| Cycle before the next tick edge          | 00:00:00 | 1 / 0 / 0               |
| Just after the next tick edge, settled   | 00:00:01 | 0 / 0 / 0               |

### Fast clock vs. true 1 Hz clock

If the design uses a fast system clock with a one-clock-wide 1 Hz tick, the clock holds 23:59:59 across all the fast-clock edges where `tick = 0`, and the wrap happens only on the edge where `tick = 1`. With a true 1 Hz clock, `sec_en` is tied to 1 and the wrap happens on the first clock edge after the clock has displayed 23:59:59.
