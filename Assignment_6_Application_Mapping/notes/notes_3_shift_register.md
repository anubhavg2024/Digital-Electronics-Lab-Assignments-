# Block 3: Shift register (PISO / SIPO)

## Real system
Serial communication such as UART or SPI. The transmitter loads a parallel byte
into a PISO register and shifts it out one bit per clock. The receiver collects
the bits in a SIPO register and reads the byte in parallel. A second example is
the 74HC595 chip, which drives 8 LEDs from 3 microcontroller pins.

## Role of the block
It converts between parallel and serial data, reducing 8 data wires to one data
wire plus a clock. PISO loads 8 bits at once, then shifts them out. SIPO shifts
8 bits in one by one, then presents all 8 together.

## Simulation result
The sample simulation used the hexadecimal byte A5, equivalent to the
8-bit binary value 10100101.

The byte was loaded into the shift-register arrangement and transferred
through the serial data path. After 8 clock pulses, the SIPO register produced
the parallel output 10100101.

The received output matched the original transmitted byte, demonstrating
the parallel-to-serial and serial-to-parallel data transfer operation.
