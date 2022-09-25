module Reg2bits(clk, rst, a, w);
	input [1:0] a;
	input clk, rst;
	output reg [1:0] w;
	always @(posedge clk, posedge rst)
	begin
		if(rst == 1) w = 2'b0;
		else w <= a;
	end
endmodule
