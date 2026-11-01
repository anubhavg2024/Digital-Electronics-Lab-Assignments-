# Prompt–Response Log: Alarm Circuit in Verilog

## Prompt

Write the same design as a Verilog assign statement.

---

## Response

### Dataflow version (assign statement)

```verilog
module alarm (
    input  wire D,  // door open
    input  wire S,  // system armed
    input  wire M,  // smoke detected
    output wire R   // alarm rings
);

    assign R = (D & S) | M;

endmodule
```

`&` is the AND gate (G1) and `|` is the OR gate (G2), so the one statement maps directly onto the two-gate circuit: `D & S` produces the intermediate signal X, and OR-ing it with `M` gives R.

### Structural version (Verilog primitives)

If you want the gate connections spelled out explicitly:

```verilog
module alarm_gates (
    input  wire D,
    input  wire S,
    input  wire M,
    output wire R
);

    wire X;

    and G1 (X, D, S);  // X = D·S
    or  G2 (R, X, M);  // R = X + M

endmodule
```

### Testbench

A quick testbench to confirm all 8 rows of the truth table:

```verilog
module tb_alarm;
    reg D, S, M;
    wire R;

    alarm dut (.D(D), .S(S), .M(M), .R(R));

    integer i;
    initial begin
        $display(" D S M | R");
        for (i = 0; i < 8; i = i + 1) begin
            {D, S, M} = i[2:0];
            #1 $display(" %b %b %b | %b", D, S, M, R);
        end
        $finish;
    end
endmodule
```

Expected output has R = 1 for DSM = 001, 011, 101, 110 and 111, and R = 0 for 000, 010 and 100, matching the truth table.
