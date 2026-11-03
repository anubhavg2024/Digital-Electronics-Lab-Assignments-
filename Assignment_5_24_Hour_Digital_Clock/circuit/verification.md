# A5 - Verification

| Preset (H:M:S) | Ticks | Expected | Observed | Match |
|---|---|---|---|---|
| 00:00:58 | 1 | 00:00:59 | 00:00:59 | Yes |
| 00:00:58 | 2 | 00:01:00 | 00:01:00 | Yes |
| 00:59:58 | 2 | 01:00:00 | 01:00:00 | Yes |
| 23:59:58 | 1 | 23:59:59 | 23:59:59 | Yes |
| 23:59:58 | 2 | 00:00:00 | 00:00:00 | Yes |
| any | reset | 00:00:00 | 00:00:00 | Yes |

Figures: rollover_23_59_59.png, rollover_00_00_00.png

## Verdict
All three counters wrapped on the same edge cleanly without race conditions or glitching states.
