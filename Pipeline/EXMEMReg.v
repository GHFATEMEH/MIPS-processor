module ExMemReg(clk, rst, wbIn, wbOut, mIn, mOut, resultIn, resultOut, writeDataIn, writeDataOut, registerRdIn, registerRdOut, registerRtIn, registerRtOut);
input clk, rst;
input [1:0]wbIn, mIn;
input [31:0]resultIn, writeDataIn;
input [4:0]registerRdIn, registerRtIn;
output wire[1:0]wbOut, mOut;
output wire[31:0]resultOut, writeDataOut;
output wire[4:0]registerRdOut, registerRtOut;

Reg2bits WB(clk, rst, wbIn, wbOut);
Reg2bits M(clk, rst, mIn, mOut);
Reg32bits Result(clk, rst, resultIn, resultOut);
Reg32bits WriteData(clk, rst, writeDataIn, writeDataOut);
Reg5bits RegisterRd(clk, rst, registerRdIn, registerRdOut);
Reg5bits RegisterRt(clk, rst, registerRtIn, registerRtOut);

endmodule