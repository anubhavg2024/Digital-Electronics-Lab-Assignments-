module dff_cell(input clk, rst, en, d, output reg q);
  always @(posedge clk or posedge rst)
    if (rst)     q <= 1'b0;
    else if (en) q <= d;          // holds its value when en = 0
endmodule

module tb;
  reg clk = 0, rst = 1, en = 0, d = 0;
  wire q;
  integer errors;

  dff_cell u(clk, rst, en, d, q);
  always #5 clk = ~clk;

  initial begin
    errors = 0;
    $display("en d | q");
    #12 rst = 0;

    @(negedge clk) begin en = 1; d = 1; end
    @(posedge clk); #1;
    $display(" %b %b | %b  (write 1)", en, d, q);
    if (q !== 1'b1) errors = errors + 1;

    @(negedge clk) begin en = 0; d = 0; end
    @(posedge clk); #1;
    $display(" %b %b | %b  (hold: still 1)", en, d, q);
    if (q !== 1'b1) errors = errors + 1;

    @(negedge clk) begin en = 1; d = 0; end
    @(posedge clk); #1;
    $display(" %b %b | %b  (write 0)", en, d, q);
    if (q !== 1'b0) errors = errors + 1;

    if (errors == 0) $display("PASS: flip-flop stores and holds a bit");
    else             $display("FAIL: %0d errors", errors);
    $finish;
  end
endmodule
