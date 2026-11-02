# Circuit Verification Report — A4: AI-Based Fault Detection

## 1. Overview
This document outlines the simulation verification steps comparing the behavior of the faulty full adder against the corrected full adder (`fixed_circuit.png`).

## 2. Truth Table Verification Matrix (A, B, Cin)

| A | B | Cin | Golden Sum | Golden Cout | Tested Sum | Tested Cout | Status / Observation |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :--- |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | Matches |
| 0 | 0 | 1 | 1 | 0 | 1 | 1 | Fails (Cout mismatch) |
| 0 | 1 | 0 | 1 | 0 | 0 | 0 | Fails (Sum mismatch) |
| 0 | 1 | 1 | 0 | 1 | 1 | 1 | Fails (Sum mismatch) |
| 1 | 0 | 0 | 1 | 0 | 1 | 0 | Matches |
| 1 | 0 | 1 | 0 | 1 | 0 | 0 | Fails (Cout mismatch) |
| 1 | 1 | 0 | 0 | 1 | 1 | 0 | Fails (Sum mismatch) |
| 1 | 1 | 1 | 1 | 1 | 1 | 0 | Fails (Sum mismatch) |

## 3. Verification Procedure
1. Inspect the corrected circuit image (`circuit.png`).
2. Apply all 8 possible binary test vectors from [/000/] to [/111/] using inputs [/A/], [/B/], and [/Cin/].
3. Confirm that [/Sum = A XOR B XOR Cin/] and [/Cout = AB + Cin(A XOR B)/] match the golden reference table for every row.
4. Verify zero discrepancies on the corrected outputs.
