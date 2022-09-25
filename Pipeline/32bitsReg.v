module Reg32bits(clk, rst, a, w);
	input [31:0] a;
	input clk, rst;
	output reg [31:0] w;
	always @(posedge clk, posedge rst)
	begin
		if(rst == 1) w = 32'b0;
		else w <= a;
	end
endmodule