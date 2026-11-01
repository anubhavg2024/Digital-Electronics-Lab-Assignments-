module alarm(input door_open, armed, smoke, output F);
  assign F = (door_open & armed) | smoke;
endmodule

module tb;
  reg d, a, s;
  wire F;
  reg expected;
  integer i, errors;

  alarm u(d, a, s, F);

  initial begin
    errors = 0;
    $display("door armed smoke | ALARM");
    for (i = 0; i < 8; i = i + 1) begin
      {d, a, s} = i;
      #1;
      expected = (d && a) || s;     // the plain-English rule
      if (F !== expected) errors = errors + 1;
      $display("  %b     %b     %b   |   %b", d, a, s, F);
    end
    if (errors == 0) $display("PASS: circuit matches the sentence for all 8 inputs");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
