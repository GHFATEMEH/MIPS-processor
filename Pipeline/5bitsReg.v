module Reg5bits(clk, rst, a, w);
	input [4:0] a;
	input clk, rst;
	output reg [4:0] w;
	always @(posedge clk, posedge rst)
	begin
		if(rst == 1) w = 5'b0;
		else w <= a;
	end
endmodule
