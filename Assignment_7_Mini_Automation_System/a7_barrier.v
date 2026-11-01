module barrier(input clk, rst, C, T, X, output up, motor_close, red);
  reg q1, q0;
  wire d1 = ~q1 & q0 & ~X;
  wire d0 = (~q1 & ~q0 & C & T) | (X & (q1 ^ q0));
  always @(posedge clk or posedge rst)
    if (rst) begin q1 <= 1'b0; q0 <= 1'b0; end
    else     begin q1 <= d1;   q0 <= d0;   end
  assign up          = ~q1 & q0;
  assign motor_close = q1 & ~q0;
  assign red         = ~up;
endmodule

module tb;
  reg clk = 0, rst = 1, C = 0, T = 0, X = 0;
  wire up, mc, red;
  reg [1:0] ref_s;
  integer errors = 0, n;
  reg verbose = 1;
  barrier u(clk, rst, C, T, X, up, mc, red);
  always #5 clk = ~clk;

  // reference model written from the state table
  always @(posedge clk or posedge rst)
    if (rst) ref_s <= 2'b00;
    else case (ref_s)
      2'b00:   ref_s <= (C & T) ? 2'b01 : 2'b00;
      2'b01:   ref_s <= X ? 2'b01 : 2'b10;
      2'b10:   ref_s <= X ? 2'b01 : 2'b00;
      default: ref_s <= 2'b00;
    endcase

  task step(input c, t, x);
    begin
      @(negedge clk); C = c; T = t; X = x;
      @(posedge clk); #1;
      if (verbose) $display("%b %b %b | state=%b%b up=%b close=%b red=%b", c, t, x, u.q1, u.q0, up, mc, red);
      if ({u.q1, u.q0} !== ref_s) errors = errors + 1;
    end
  endtask

  initial begin
    $display("C T X | state  outputs");
    #12 rst = 0;
    step(0,0,0);   // idle
    step(1,0,0);   // car, invalid ticket
    step(1,1,0);   // valid ticket -> OPEN
    step(0,0,1);   // car under barrier, hold open
    step(0,0,0);   // cleared -> CLOSING
    step(0,0,1);   // car appears while closing -> OPEN
    step(0,0,0);   // cleared -> CLOSING
    step(0,0,0);   // CLOSED
    verbose = 0;
    for (n = 0; n < 64; n = n + 1) step(n[0], n[1], n[2]);   // many input patterns vs reference
    verbose = 1;
    // force unused state 11 and check it recovers to CLOSED (00)
    @(negedge clk); C = 0; T = 0; X = 0;
    force u.q1 = 1'b1; force u.q0 = 1'b1;
    #1 release u.q1; release u.q0;
    @(posedge clk); #1;
    $display("unused state 11 -> next state %b%b (expected 00)", u.q1, u.q0);
    if ({u.q1, u.q0} !== 2'b00) errors = errors + 1;
    if (errors == 0) $display("PASS: matches reference model");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
