# A6 - Verification

## D flip-flop with enable

| en | D | Expected Q after clock | Sample observed Q | Match |
|---|---|---|---|---|
| 1 | 1 | 1 | 1 | Pass |
| 0 | 0 | 1 (holds previous value) | 1 | Pass |
| 1 | 0 | 0 | 0 | Pass |

## Mod-60 counter

| Present | Expected next | Sample observed | Match |
|---|---|---|---|
| 58 | 59 (carry = 0) | 59 | Pass |
| 59 | 0 (carry = 1) | 0 | Pass |
| 0 | 1 | 1 | Pass |

## Shift register (byte sent: A5 = 10100101)

| Clocks after load | Expected SIPO output | Sample observed | Match |
|---|---|---|---|
| 8 | 10100101 | 10100101 | Pass |

## Verdict

The sample results demonstrate the expected behaviour of the three sequential building blocks. The D flip-flop stores its input when enabled and retains its previous value when the enable signal is low. The Mod-60 counter increments from 0 to 59 and returns to 0 on the next clock pulse. The shift register transfers the eight-bit data pattern `10100101` to its parallel output after eight clock pulses.

All listed sample cases match their expected values. These observations are illustrative and should be replaced with actual Logisim readings before being reported as simulation results.
