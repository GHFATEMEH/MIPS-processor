module Equal(a, b, equal);
  input [31:0] a, b;
  output wire equal;

  assign equal = (a==b) ? 1'b1 : 1'b0;
endmodule