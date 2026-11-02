
# A2 – Alarm System Truth Table

## Boolean Expression

\[
ALARM=(Door_Open . Armed)+Smoke
\]

## Input and Output Description

| Variable | Description |
|---|---|
| Door_Open | 1 = Door open, 0 = Door closed |
| Armed | 1 = Security system armed, 0 = Disarmed |
| Smoke | 1 = Smoke detected, 0 = No smoke |
| ALARM | 1 = Alarm ON, 0 = Alarm OFF |

## Truth Table

| S.No. | Door_Open | Armed | Smoke | ALARM |
|:-----:|:---------:|:-----:|:-----:|:-----:|
| 1 | 0 | 0 | 0 | 0 |
| 2 | 0 | 0 | 1 | 1 |
| 3 | 0 | 1 | 0 | 0 |
| 4 | 0 | 1 | 1 | 1 |
| 5 | 1 | 0 | 0 | 0 |
| 6 | 1 | 0 | 1 | 1 |
| 7 | 1 | 1 | 0 | 1 |
| 8 | 1 | 1 | 1 | 1 |

## Result Summary

- Total input combinations: 8
- ALARM = 1: 5 combinations
- ALARM = 0: 3 combinations

## Conclusion

The alarm activates when both the door is open and the security system is armed, or whenever smoke is detected.
