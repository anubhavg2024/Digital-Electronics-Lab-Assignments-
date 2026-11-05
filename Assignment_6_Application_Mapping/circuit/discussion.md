# A6 - Discussion
Each block was matched to a real system and demonstrated in Logisim. The
flip-flop shows how a register bit holds data, the counter shows how a clock is
divided into time units, and the shift register shows conversion between serial
and parallel data.

## Edge cases
- The flip-flop must keep its value while enable is 0.
- The counter wraps from 59 to 0 and carries only at 59.
- The shift register needs exactly 8 clocks after loading to hold the full byte.

## Issues found while building
None. 
