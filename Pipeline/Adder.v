module Adder(a, b, y);
  input [31:0] a, b;
  output wire [31:0] y;
  wire cout;
  assign {cout, y} = a + b;
endmodule