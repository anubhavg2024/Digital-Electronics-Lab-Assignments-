module piso8(input clk, rst, load, input [7:0] d, output sout);
  reg [7:0] r;
  assign sout = r[7];                       // MSB first
  always @(posedge clk or posedge rst)
    if (rst)       r <= 0;
    else if (load) r <= d;
    else           r <= {r[6:0], 1'b0};
endmodule

module sipo8(input clk, rst, sin, output reg [7:0] q);
  always @(posedge clk or posedge rst)
    if (rst) q <= 0;
    else     q <= {q[6:0], sin};
endmodule

module tb;
  reg clk = 0, rst = 1, load = 0;
  reg [7:0] data = 8'hA5;
  wire sout;
  wire [7:0] rx;

  piso8 tx(clk, rst, load, data, sout);
  sipo8 rcv(clk, rst, sout, rx);
  always #5 clk = ~clk;

  always @(posedge clk) #1 $display("t=%0t sout=%b rx=%b", $time, sout, rx);

  initial begin
    #12 rst = 0;
    @(negedge clk) load = 1;
    @(negedge clk) load = 0;
    repeat (8) @(negedge clk);
    if (rx === data) $display("Sent %h, received %h -> PASS", data, rx);
    else             $display("Sent %h, received %h -> FAIL", data, rx);
    $finish;
  end
endmodule
