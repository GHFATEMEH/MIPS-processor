module Register_with_control(a, clk, reset, control_signal, w);
  input [31:0] a;
  input clk, reset, control_signal;
  output reg [31:0] w;
  always @(posedge clk, posedge reset)
  begin
    if(reset == 1'b1)
      w <= 32'b0;
    else if(control_signal == 1'b1)
      w <= a;
    end
endmodule
