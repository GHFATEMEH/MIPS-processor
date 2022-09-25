module Reg4bits(clk, rst, a, w);
	input [3:0] a;
	input clk, rst;
	output reg [3:0] w;
	always @(posedge clk, posedge rst)
	begin
		if(rst == 1) w = 4'b0;
		else w <= a;
	end
endmodule
