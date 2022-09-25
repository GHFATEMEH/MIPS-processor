module RegisterWithControl(clk, rst, controlSignal, a, w);
  input [31:0] a;
  input clk, rst, controlSignal;
  output reg [31:0] w;
  always @(posedge clk, posedge rst)
  begin
    if(rst == 1'b1)
      w <= 32'b0;
    else if(controlSignal == 1'b1)
      w <= a;
  end
endmodule

