module Test1();
  reg clk = 1'b0;
  reg reset = 1'b1;
  MIPS T(clk, reset); 
  always #60 clk = ~clk;
  initial begin
    #120 reset = 1'b0;
    #8100 $stop;
  end
endmodule