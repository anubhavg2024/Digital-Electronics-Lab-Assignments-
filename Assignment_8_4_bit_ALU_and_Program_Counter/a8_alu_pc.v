module fa(input a, b, c, output s, co);
  assign s  = a ^ b ^ c;
  assign co = (a & b) | (b & c) | (a & c);
endmodule

// m = 0: y = a + b ; m = 1: y = a - b (B XOR m, carry-in = m)
module alu4(input [3:0] a, b, input m, output [3:0] y, output cout);
  wire [3:0] bx = b ^ {4{m}};
  wire c1, c2, c3;
  fa f0(a[0], bx[0], m,  y[0], c1);
  fa f1(a[1], bx[1], c1, y[1], c2);
  fa f2(a[2], bx[2], c2, y[2], c3);
  fa f3(a[3], bx[3], c3, y[3], cout);
endmodule

module pc4(input clk, rst, en, output reg [3:0] pc);
  always @(posedge clk or posedge rst)
    if (rst)     pc <= 0;
    else if (en) pc <= pc + 1;
endmodule

// hardware for: for (i = 0; i < 8; i++) acc = acc + 1;
module loop_demo(input clk, rst, output [3:0] i, acc, output run);
  reg  [3:0] acc_r;
  wire [3:0] sum;
  wire co;
  assign run = (i < 8);                                           // comparator
  pc4  counter(.clk(clk), .rst(rst), .en(run), .pc(i));           // i / sequencing
  alu4 alu(.a(acc_r), .b(4'd1), .m(1'b0), .y(sum), .cout(co));    // the "+"
  always @(posedge clk or posedge rst)
    if (rst)      acc_r <= 0;
    else if (run) acc_r <= sum;                                   // register
  assign acc = acc_r;
endmodule

module tb;
  reg [3:0] a, b;
  reg m;
  wire [3:0] y;
  wire cout;
  integer x, z, k, errors;
  reg [4:0] exp5;
  reg clk = 0, rst = 1;
  wire [3:0] i, acc;
  wire run;

  alu4 u(a, b, m, y, cout);
  loop_demo d(clk, rst, i, acc, run);
  always #5 clk = ~clk;

  initial begin
    errors = 0;
    for (k = 0; k < 2; k = k + 1)
      for (x = 0; x < 16; x = x + 1)
        for (z = 0; z < 16; z = z + 1) begin
          a = x; b = z; m = k; #1;
          exp5 = k ? (x - z) : (x + z);
          if (y !== exp5[3:0]) begin
            errors = errors + 1;
            $display("ERROR m=%b a=%0d b=%0d y=%0d", m, a, b, y);
          end
        end
    a = 4'd9; b = 4'd5; m = 0; #1; $display("9 + 5 = %0d (4-bit, cout=%b)", y, cout);
    a = 4'd9; b = 4'd5; m = 1; #1; $display("9 - 5 = %0d", y);
    a = 4'd5; b = 4'd9; m = 1; #1; $display("5 - 9 = %0d (wraps in 4 bits)", y);
    if (errors == 0) $display("ALU PASS: all 512 cases");
    else             $display("ALU FAIL: %0d errors", errors);

    #12 rst = 0;
    $display("loop: i acc run");
    repeat (10) begin
      @(posedge clk); #1;
      $display("      %0d  %0d   %b", i, acc, run);
    end
    if (i === 8 && acc === 8 && run === 0) $display("LOOP PASS: i=8, acc=8, stopped");
    else                                   $display("LOOP FAIL");
    $finish;
  end
endmodule
