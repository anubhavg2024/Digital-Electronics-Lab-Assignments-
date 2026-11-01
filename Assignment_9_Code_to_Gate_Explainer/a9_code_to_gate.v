module max_hw(input [3:0] a, b, output [3:0] c);
  wire gt = (a > b);            // comparator output
  assign c = gt ? a : b;        // 4 x 2:1 mux, select = gt
endmodule

module tb;
  reg [3:0] a, b;
  wire [3:0] c;
  reg [3:0] expected;
  integer i, j, errors;
  max_hw u(a, b, c);
  initial begin
    errors = 0;
    $display(" a  b |  c");
    for (i = 0; i < 16; i = i + 1)
      for (j = 0; j < 16; j = j + 1) begin
        a = i; b = j; #1;
        if (i > j) expected = i; else expected = j;     // the original code
        if (c !== expected) begin
          errors = errors + 1;
          $display("MISMATCH a=%0d b=%0d c=%0d", a, b, c);
        end
        if ((i == j && (i == 0 || i == 7 || i == 15)) || (i == 15 && j == 0) || (i == 0 && j == 15))
          $display("%2d %2d | %2d", a, b, c);
      end
    if (errors == 0) $display("PASS: all 256 combinations match");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
