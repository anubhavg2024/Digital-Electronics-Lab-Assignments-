# A5 - Verification
| Preset (H:M:S) | Ticks | Expected | Observed | Match |
|---|---|---|---|---|
| 00:00:58 | 1 | 00:00:59 | | |
| 00:00:58 | 2 | 00:01:00 | | |
| 00:59:58 | 2 | 01:00:00 | | |
| 23:59:58 | 1 | 23:59:59 | | |
| 23:59:58 | 2 | 00:00:00 | | |
| any | reset | 00:00:00 | | |

Figures: rollover_23_59_59.png, rollover_00_00_00.png

## Verdict
<All three counters wrapped on the same edge / mismatch at ...>
