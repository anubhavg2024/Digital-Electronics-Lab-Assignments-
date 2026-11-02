
# A2 – Natural Language to Logic Circuit Generator

## Aim

Convert an English description into a Boolean expression and gate-level circuit design using Generative AI (GenAI), then simulate and verify the circuit.

## Problem Statement

"The alarm rings if the door is open and the system is armed, or if smoke is detected."

## Input and Output Variables

| Variable | Meaning |
|---|---|
| D (door_open) | 1 = Door open |
| A (armed) | 1 = System armed |
| S (smoke) | 1 = Smoke detected |
| F (alarm) | 1 = Alarm rings |

## Boolean Expression

\[
\F = D_open . (A+S) 
\]

The alarm activates when the door is open and the system is armed, or whenever smoke is detected.

## Truth Table

| D | A | S | F |
|:-:|:-:|:-:|:-:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

## Gate-Level Design

The circuit uses two logic gates:

1. **AND gate:** Takes D and A as inputs and produces D · A.
2. **OR gate:** Combines the AND gate output with S to produce F.

**Total gates:** 2

The Boolean expression is already minimal.

## Circuit Operation

- When D = 1 and A = 1, the alarm activates.
- When S = 1, the alarm activates regardless of D and A.
- When D = 0, A = 0 and S = 0, the alarm remains OFF.
- When D = 1, A = 0 and S = 0, the alarm remains OFF.
- When D = 0, A = 1 and S = 0, the alarm remains OFF.

## Verification

All 8 possible input combinations were evaluated using the Boolean expression.

| Verification Parameter | Result |
|---|---:|
| Total input combinations | 8 |
| Output 1 (Alarm ON) | 5 |
| Output 0 (Alarm OFF) | 3 |
| Mismatched combinations | 0 |
| Functional correctness | PASS |

The calculated outputs agree with the expected behavior of the problem statement.

## GenAI Usage 

GenAI used - 
Claude Sonnet 5.5, a large language model developed by Anthropic, accessed through the claude.ai chat interface.

Generative AI was used to:

- Interpret the natural-language problem statement.
- Identify the input and output variables.
- Derive the Boolean expression.
- Generate the truth table.
- Identify the required logic gates.
- Explain circuit operation and edge cases.
- Check the logical consistency of the expression. 

The AI-generated results were reviewed to ensure that the Boolean expression and truth table correctly represent the given statement.

## Observations and Edge Cases

1. Smoke activates the alarm regardless of the door and arming states.
2. An open door with the system disarmed and no smoke does not activate the alarm.
3. A closed door with the system armed and no smoke does not activate the alarm.
4. The statement "door is open and system is armed, or smoke is detected" is interpreted as:

\[
(D_open . A)+S
\]

rather than:

\[
D_open . (A+S)
\]

This distinction is important because the two expressions produce different outputs for some input combinations.

## Result

The English description was successfully converted into a Boolean expression and a gate-level logic design.

The final expression is:

\[
(D_open . A)+S 
\]

The circuit uses one AND gate and one OR gate. The truth table confirms that the alarm behaves as expected for all 8 possible input combinations.
