module PCRegister_with_control(a, clk, reset, Write, w);
  input [31:0] a;
  input clk, reset;
  input Write;
  output reg [31:0] w;
  wire four;
  assign four = 32'b00000000000000000000000000000100;
  
  always @(posedge clk, posedge reset)
  begin
    if(reset == 1'b1)
      w <= 32'b0;
    else if(Write == 1'b0)
      w <= a - four;
    else
      w <= a;
    end
endmodule
