# Discussion – FSM Controller

## Design Overview

The circuit implements a finite state machine using two D flip-flops and combinational logic.

The state is represented by two bits, Q1 and Q0. The external inputs R1 and R0 influence the next-state logic.

The circuit generates three outputs: NOGO, UP and DOWN.

## Sequential Logic

Two D flip-flops are used to store the current state.

The clock signal synchronises state updates. The combinational logic determines the values supplied to the D inputs of the flip-flops.

The two state bits provide four possible binary state combinations.

## Combinational Logic

AND gates generate individual product terms, while OR gates combine these terms.

Inverted gate inputs are used to represent complemented logic conditions.

The combinational network is divided into:
- Next-state logic.
- NOGO output logic.
- UP output logic.
- DOWN output logic.

## Input and Output Behaviour

The inputs R1 and R0 represent the external request conditions.

The outputs NOGO, UP and DOWN are generated according to the current state and the implemented logic.

These outputs represent different operating conditions of the controller.

## Design Considerations

- Two flip-flops are required to store the two-bit state.
- The clock must be connected correctly to both flip-flops.
- The next-state logic must be connected to the corresponding D inputs.
- The output logic must use the appropriate state and input signals.
- Complemented signals must be connected according to the implemented Boolean expressions.

## Verification and Limitations

The circuit structure identifies the state storage, external inputs and output signals.

Expected input combinations and sequential behaviour can be described from the circuit arrangement.

The exact output truth table and state-transition table should be obtained from the final Boolean equations or verified circuit behaviour. They should not be inferred solely from the visual arrangement of the gates.

## Conclusion

The design demonstrates the implementation of a two-bit finite state machine using D flip-flops and combinational logic.

It illustrates how external inputs influence state transitions and how multiple output signals can be generated from a sequential logic circuit.
