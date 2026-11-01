module f_original(input A, B, C, D, E, output F);
  wire [4:0] m = {A, B, C, D, E};
  assign F = (m==0)  || (m==1)  || (m==4)  || (m==5)  ||
             (m==16) || (m==17) || (m==20) || (m==21) ||
             (m==26) || (m==27) || (m==30) || (m==31);
endmodule

module f_simplified(input A, B, C, D, E, output F);
  assign F = (~B & ~D) | (A & B & D);
endmodule

module tb;
  reg A, B, C, D, E;
  wire F1, F2;
  integer i, errors;

  f_original   u1(A, B, C, D, E, F1);
  f_simplified u2(A, B, C, D, E, F2);

  initial begin
    errors = 0;
    $display("A B C D E | orig simp");
    for (i = 0; i < 32; i = i + 1) begin
      {A, B, C, D, E} = i;
      #1;
      if (F1 !== F2) begin
        errors = errors + 1;
        $display("%b %b %b %b %b |  %b    %b   <-- MISMATCH", A, B, C, D, E, F1, F2);
      end else
        $display("%b %b %b %b %b |  %b    %b", A, B, C, D, E, F1, F2);
    end
    if (errors == 0) $display("PASS: all 32 rows match");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule
