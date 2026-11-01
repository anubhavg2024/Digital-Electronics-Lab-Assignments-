module digital_clock(input clk, rst, output reg [4:0] h, output reg [5:0] m, s);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      h <= 0;
      m <= 0;
      s <= 0;
    end else if (s == 59) begin
      s <= 0;
      if (m == 59) begin
        m <= 0;
        h <= (h == 23) ? 5'd0 : h + 1;
      end else
        m <= m + 1;
    end else
      s <= s + 1;
  end
endmodule

module tb;
  reg clk = 0, rst = 1;
  wire [4:0] h;
  wire [5:0] m, s;
  integer t, errors;

  digital_clock u(clk, rst, h, m, s);
  always #5 clk = ~clk;

  initial begin
    errors = 0;
    #12 rst = 0;                       // released between clock edges
    for (t = 1; t <= 86400; t = t + 1) begin
      @(posedge clk);
      #1;
      if (h !== (t % 86400) / 3600 || m !== (t % 3600) / 60 || s !== t % 60) begin
        errors = errors + 1;
        $display("Mismatch at t=%0d: %0d:%0d:%0d", t, h, m, s);
      end
      if (t <= 3 || t >= 86395)
        $display("t=%0d  %02d:%02d:%02d", t, h, m, s);
    end
    if (errors == 0) $display("PASS: all 86400 ticks verified, rollover OK");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
