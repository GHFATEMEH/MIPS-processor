module SignExtender(a, y);
  input [15:0] a;
  output wire [31:0] y;
  assign y = a[15] ? {16'b1111111111111111, a[15:0]} : 
                     {16'b0000000000000000, a[15:0]};
endmodule
