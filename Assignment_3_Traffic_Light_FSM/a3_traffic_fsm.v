module traffic(input clk, rst, P, output G, Y, R, W);
  reg q1, q0;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      q1 <= 1'b0;
      q0 <= 1'b0;                    // start in Green
    end else begin
      q1 <= q0;                      // D1 = Q0
      q0 <= ~q1 & (P | q0);          // D0 = Q1'(P + Q0)
    end
  end
  assign G = ~q1 & ~q0;
  assign Y = ~q1 &  q0;
  assign R =  q1;                    // red for both R and W states
  assign W =  q1 &  q0;
endmodule

module tb;
  reg clk = 0, rst = 1, P = 0;
  wire G, Y, R, W;
  reg [1:0] ref_s;
  integer errors = 0;

  traffic u(clk, rst, P, G, Y, R, W);
  always #5 clk = ~clk;

  // reference model written directly from the state table
  always @(posedge clk or posedge rst) begin
    if (rst) ref_s <= 2'b00;
    else case (ref_s)
      2'b00:   ref_s <= P ? 2'b01 : 2'b00;
      2'b01:   ref_s <= 2'b11;
      2'b11:   ref_s <= 2'b10;
      default: ref_s <= 2'b00;
    endcase
  end

  always @(posedge clk) begin
    #1;
    $display("%4d  %b | %b %b %b %b", $time, P, G, Y, R, W);
    if ({u.q1, u.q0} !== ref_s) errors = errors + 1;
  end

  initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, tb);
    $display("time P | G Y R W");
    #12 rst = 0;
    #20 P = 1;  #10 P = 0;      // single request while Green
    #80 P = 1;  #30 P = 0;      // request held through Y, W and R (must be ignored)
    #100;
    if (errors == 0) $display("PASS: FSM matches the reference model on every clock edge");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
