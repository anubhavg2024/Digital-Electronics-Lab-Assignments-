Inputs: C = car at entry, T = valid ticket, X = vehicle under barrier
States: CLOSED = 00, OPEN = 01, CLOSING = 10, (11 unused -> CLOSED)

| State | Condition | Next |
|---|---|---|
| CLOSED | C.T = 1 | OPEN |
| CLOSED | otherwise | CLOSED |
| OPEN | X = 1 | OPEN |
| OPEN | X = 0 | CLOSING |
| CLOSING | X = 1 | OPEN |
| CLOSING | X = 0 | CLOSED |
| 11 | any | CLOSED |

D1 = Q1'.Q0.X'
D0 = Q1'.Q0'.C.T + X.(Q1 xor Q0)
Up = Q1'.Q0     MotorClose = Q1.Q0'     Red = NOT Up
