module fa_golden(input a, b, cin, output s, cout);
  assign s    = a ^ b ^ cin;
  assign cout = (a & b) | ((a ^ b) & cin);
endmodule

// Fault: B is not connected to the first XOR (A ^ Cin instead of A ^ B)
module fa_faulty(input a, b, cin, output s, cout);
  wire p = a ^ cin;                  // should be a ^ b
  assign s    = p;
  assign cout = (a & b) | (p & cin);
endmodule

module fa_fixed(input a, b, cin, output s, cout);
  wire p = a ^ b;
  assign s    = p ^ cin;
  assign cout = (a & b) | (p & cin);
endmodule

module tb;
  reg a, b, c;
  wire sg, cg, sf, cf, sx, cx;
  integer i, faults, bad;

  fa_golden g(a, b, c, sg, cg);
  fa_faulty f(a, b, c, sf, cf);
  fa_fixed  x(a, b, c, sx, cx);

  initial begin
    faults = 0;
    bad = 0;
    $display("A B Cin | golden(S,Co) | faulty(S,Co) | fixed(S,Co)");
    for (i = 0; i < 8; i = i + 1) begin
      {a, b, c} = i;
      #1;
      if ({sg, cg} !== {sf, cf}) begin
        faults = faults + 1;
        $display("%b %b  %b  |     %b %b      |     %b %b      |    %b %b   <-- FAULT",
                 a, b, c, sg, cg, sf, cf, sx, cx);
      end else
        $display("%b %b  %b  |     %b %b      |     %b %b      |    %b %b",
                 a, b, c, sg, cg, sf, cf, sx, cx);
      if ({sg, cg} !== {sx, cx}) bad = bad + 1;
    end
    $display("Faulty design differs from golden in %0d of 8 rows", faults);
    if (bad == 0) $display("PASS: fixed design matches golden for all 8 rows");
    else          $display("FAIL: fixed design wrong in %0d rows", bad);
    $finish;
  end
endmodule
