# Block 2: Mod-N counter (Mod-60)

## Real system
The seconds counter of a digital clock. The same idea divides a clock frequency
by N, and times intervals in a traffic-light controller.

## Role of the block
The counter counts 0 to 59 and wraps to 0. At 59 it raises a carry that enables
the minutes counter, which in turn enables the hours counter. With a 1 Hz input
the carry output is a 1/60 Hz signal. It can be built as one 6-bit counter with
maximum 59, or as a Mod-10 units counter and a Mod-6 tens counter, with the
tens counter enabled only when units = 9.

## Simulation result
The sample simulation showed the expected Mod-60 counting sequence.

| Clock event | Counter value | Carry output |
|---|---:|---|
| Initial state | 58 | 0 |
| First clock pulse | 59 | 0 |
| Second clock pulse | 0 | 1 |
| Third clock pulse | 1 | 0 |

The counter advanced from 58 to 59 and then returned to 0 on the next clock
pulse. The carry output was asserted at the terminal count of 59 to indicate
the rollover and enable the next counter stage.

This demonstrates the expected counting and rollover behaviour of a Mod-60
counter.
