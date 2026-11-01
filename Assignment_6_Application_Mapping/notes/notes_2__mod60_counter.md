# Block 2: Mod-N counter (Mod-60)

## Real system
The seconds counter of a digital clock. The same idea is used as a frequency
divider (a Mod-N counter divides its input frequency by N) and as a timer in
a traffic-light controller.

## Role of the block
The counter counts 0 to 59 and wraps to 0. At count 59 it raises a carry
signal that enables the minutes counter, which in turn enables the hours
counter. In the clock, a 1 Hz input gives one wrap per minute, so the carry
output is a 1/60 Hz signal. It can be built as one 6-bit counter with a
maximum of 59, or as a Mod-10 units counter and a Mod-6 tens counter. The
tens counter is enabled only when units = 9, so the display reads 00 to 59
directly in decimal digits.

## Simulation result
mod60_counter.circ and a6_mod60.v: the count goes ... 58, 59, 0, 1 ...
with carry = 1 only at 59. The 6-bit version and the Mod-10 + Mod-6 version
agree on all 125 ticks tested. Testbench result: PASS.

Figure: circuit/mod60_wrap_59_to_0.png
