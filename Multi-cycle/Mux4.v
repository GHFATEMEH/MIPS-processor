module Mux4(a, b, c, d, sel, y);
  input [31:0] a, b, c, d;
  input [1:0] sel;
  output wire [31:0] y;
  assign y = (sel == 2'b00) ? a:
             (sel == 2'b01) ? b:
             (sel == 2'b10) ? c:
             (sel == 2'b11) ? d: a;
endmodule
