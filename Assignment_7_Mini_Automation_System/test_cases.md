| # | C T X | Start | Expected | Observed | Edge case |
|---|---|---|---|---|---|
| 1 | 000 | CLOSED | CLOSED | CLOSED | idle |
| 2 | 100 | CLOSED | CLOSED | CLOSED | car with invalid ticket |
| 3 | 110 | CLOSED | OPEN | OPEN | valid ticket |
| 4 | 001 | OPEN | OPEN | OPEN | car under barrier |
| 5 | 000 | OPEN | CLOSING | CLOSING | car cleared |
| 6 | 001 | CLOSING | OPEN | OPEN | car appears while closing |
| 7 | 000 | OPEN | CLOSING | CLOSING | cleared again |
| 8 | 000 | CLOSING | CLOSED | CLOSED | fully closed |
| 9 | any | 11 (forced) | CLOSED | CLOSED | unused state recovers |
