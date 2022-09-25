module IfIdReg(clk, rst, IfIdWrite, IfFlush, nextPCIn, instIn, nextPCOut, instOut);
	input clk, rst, IfIdWrite, IfFlush;
	input [31:0]nextPCIn, instIn;
	output wire[31:0]nextPCOut, instOut;
	
	RegisterWithControl nextPC(clk, rst, IfIdWrite, nextPCIn, nextPCOut);
	RegisterWithClear Inst(clk, rst, IfIdWrite, IfFlush, instIn, instOut);

endmodule