module Mux5bits(a, b, sel, y);
  input [4:0] a, b;
  input sel;
  output wire [4:0] y;
  assign y = sel ? a : b;
endmodule
