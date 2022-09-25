module Mux32bits(a, b, sel, y);
  input [31:0] a, b;
  input sel;
  output wire [31:0] y;
  assign y = sel ? a : b;
endmodule
