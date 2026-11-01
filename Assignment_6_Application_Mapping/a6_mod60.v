// Single 6-bit Mod-60 counter (seconds counter of a clock)
module mod60(input clk, rst, output reg [5:0] q, output carry);
  always @(posedge clk or posedge rst)
    if (rst) q <= 0;
    else     q <= (q == 59) ? 6'd0 : q + 1;
  assign carry = (q == 59);       // feeds the minutes counter
endmodule

// Same counter built as units (Mod-10) + tens (Mod-6)
module mod60_bcd(input clk, rst, output reg [3:0] tens, units);
  always @(posedge clk or posedge rst)
    if (rst) begin
      tens  <= 0;
      units <= 0;
    end else if (units == 9) begin          // tens counts only when units wraps
      units <= 0;
      tens  <= (tens == 5) ? 4'd0 : tens + 1;
    end else
      units <= units + 1;
endmodule

module tb;
  reg clk = 0, rst = 1;
  wire [5:0] q;
  wire carry;
  wire [3:0] tens, units;
  integer t, errors;

  mod60     a(clk, rst, q, carry);
  mod60_bcd b(clk, rst, tens, units);
  always #5 clk = ~clk;

  initial begin
    errors = 0;
    #12 rst = 0;
    for (t = 1; t <= 125; t = t + 1) begin
      @(posedge clk); #1;
      if (q !== t % 60)                  errors = errors + 1;
      if (carry !== (q == 59))           errors = errors + 1;
      if (tens * 10 + units !== q)       errors = errors + 1;
      if (q >= 57 || q <= 2)
        $display("tick %0d: q=%0d carry=%b  (tens=%0d units=%0d)", t, q, carry, tens, units);
    end
    if (errors == 0) $display("PASS: wraps 59 -> 0 every 60 ticks; BCD version matches");
    else             $display("FAIL: %0d errors", errors);
    $finish;
  end
endmodule
