# Prompt–Response Log: Three Sequential Building Blocks in Real Systems

## Prompt

For these three sequential building blocks, name one real system that uses each and describe the block's role in it: (1) a D flip-flop, (2) a Mod-60 counter, (3) a shift register (SIPO/PISO). Use examples such as a CPU register bit or keypad debounce, a digital clock or frequency divider, and UART/SPI serial communication.

---

## Response

### 1. D flip-flop: CPU register bit

**System:** the register file and pipeline registers inside a CPU.

**Role:** a D flip-flop stores one bit. A 32-bit register is 32 of them sharing one clock and a write-enable. On each clock edge, if the enable is 1, every flip-flop captures the value on its D input (the ALU result, for example) and holds it steadily until the next write.

This is what makes a processor synchronous. The ALU's outputs may wobble while the logic settles, but the flip-flops sample only at the clock edge, so the next stage always sees a clean, stable value. Without flip-flops there would be no storage between pipeline stages and no program counter.

**Secondary example, keypad debounce:** a mechanical key bounces for a few milliseconds. Passing the key line through one or two D flip-flops clocked at about 1 kHz samples it slowly and also synchronizes it to the system clock. A debounce circuit then accepts a change only after the sampled value stays the same for several consecutive samples. The flip-flop chain also provides the two-flop synchronizer discussed in the traffic-light check.

### 2. Mod-60 counter: digital clock seconds and minutes

**System:** a digital wall clock, wristwatch or stopwatch.

**Role:** a mod-60 counter counts 0 to 59 and wraps to 0 on the next pulse. It is used twice in the clock from the previous design:

- The **seconds counter** advances once per 1 Hz tick. Its wrap (59 → 0) produces a carry.
- The **minutes counter** uses that carry as its enable. Its own wrap produces the carry that advances the hours counter (mod-24).

The counter divides frequency by 60 at each stage: 1 Hz in, 1/60 Hz (once a minute) out, then once an hour. This is why a mod-N counter is also a frequency divider. The same block, set to a different modulus, divides a 50 MHz board clock down to the 1 Hz tick that drives the clock.

### 3. Shift register: UART and SPI serial communication

**System:** a UART between a microcontroller and a PC, or an SPI link between a microcontroller and a sensor, flash chip or display.

**PISO (parallel-in, serial-out), the transmitter side:**

- The CPU loads a whole byte, say 8 bits, into the register in parallel.
- Each bit-clock then shifts it out one bit at a time on the TX (UART) or MOSI (SPI) line.
- A UART adds a start bit before the data and a stop bit after it.

**SIPO (serial-in, parallel-out), the receiver side:**

- Bits arrive one at a time on RX (UART) or MISO (SPI) and shift in. In SPI each bit is shifted in on the shared clock line. A UART has no clock line, so its receiver samples RX at the agreed baud rate using its own clock, starting from the falling edge of the start bit.
- After 8 shifts, the register holds the complete byte, which is read out in parallel into the CPU's data bus.

A typical SPI master uses one register that does both jobs at once: as it shifts a byte out on MOSI, it shifts the incoming byte in from MISO, so the data is exchanged in the same 8 clocks.

The point of the shift register is the width conversion. The CPU works with 8 or 32 bits at a time, but the wire carries only 1 bit at a time. This saves pins and cable at the cost of speed.

### Summary

| Block          | Real system                                              | Role                                                         |
|----------------|----------------------------------------------------------|--------------------------------------------------------------|
| D flip-flop    | CPU register or pipeline stage (also keypad debounce input) | Stores one bit, captures it only on the clock edge        |
| Mod-60 counter | Digital clock seconds/minutes (also frequency divider)   | Counts 0–59, wraps, and passes a carry to the next stage     |
| Shift register | UART / SPI                                               | PISO sends a parallel byte serially, SIPO rebuilds it at the receiver |
