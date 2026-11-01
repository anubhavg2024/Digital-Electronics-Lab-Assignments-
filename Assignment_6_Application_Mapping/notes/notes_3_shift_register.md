# Block 3: Shift register (PISO / SIPO)

## Real system
Serial communication such as UART or SPI. A UART transmitter loads a parallel
byte into a PISO register and shifts it out one bit at a time (with start and
stop bits added). The receiver collects the bits in a SIPO register and reads
the whole byte in parallel. A second example is the 74HC595 SIPO chip, which
lets a microcontroller drive 8 LED outputs from 3 pins.

## Role of the block
It converts between parallel and serial data. PISO: load 8 bits at once, then
shift them out on a single wire. SIPO: shift 8 bits in one by one, then read
all 8 at once. This reduces 8 data wires to 1 data wire plus a clock.

## Simulation result
shift_register.circ and a6_shift_register.v: the byte A5 is loaded into the
PISO register, sent MSB-first over one wire, and after 8 clock edges the SIPO
register holds A5. Testbench result: PASS ("Sent a5, received a5").

Figure: circuit/shift_register.png
