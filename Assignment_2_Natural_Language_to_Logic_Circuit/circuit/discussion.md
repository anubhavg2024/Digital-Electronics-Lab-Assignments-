
# Assignment 2 – Discussion

The alarm system was designed using three inputs: Door_Open, Armed and Smoke.

The Boolean expression is:

\[
ALARM=(Door_Open . Armed)+Smoke
\]

The alarm activates when the door is open while the security system is armed, or whenever smoke is detected.

## Observations

- An AND gate combines Door_Open and Armed.
- An OR gate combines the AND output with Smoke.
- The circuit has 8 possible input combinations.
- The alarm activates in 5 combinations.

## Conclusion

The natural-language requirement was successfully converted into a Boolean expression and logic gate implementation. The truth table confirms the expected alarm behavior.
