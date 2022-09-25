module Mux3(a, b, c, sel, y);
  input [31:0] a, b, c;
  input [1:0] sel;
  output wire [31:0] y;
  assign y = (sel == 2'b00) ? a:
             (sel == 2'b01) ? b:
             (sel == 2'b10) ? c : a;
endmodule