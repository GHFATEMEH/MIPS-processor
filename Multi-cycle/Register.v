module Register(a, clk, reset, w);
  input [31:0] a;
  input clk, reset;
  output reg [31:0] w;
  always @(posedge clk, posedge reset)
  begin
    if(reset == 1'b1)
      w <= 32'b0;
    else
      w <= a;
    end
  endmodule