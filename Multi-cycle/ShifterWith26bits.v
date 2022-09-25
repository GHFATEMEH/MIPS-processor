module Shifter26bits(a, y);
  input [25:0] a;
  output wire [27:0] y;
  assign y = {a[25:0], 2'b00};
endmodule
  
