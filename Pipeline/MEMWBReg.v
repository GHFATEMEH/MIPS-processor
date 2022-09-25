module MemWbReg(clk, rst, wbIn, wbOut, readDataIn, readDataOut, resultIn, resultOut, registerRdIn, registerRdOut);
input clk, rst;
input [1:0]wbIn;
input [31:0]readDataIn, resultIn;
input [4:0]registerRdIn;
output wire[1:0]wbOut;
output wire[31:0]readDataOut ,resultOut;
output wire[4:0]registerRdOut;

Reg2bits WB(clk, rst, wbIn, wbOut);
Reg32bits Result(clk, rst, resultIn, resultOut);
Reg32bits ReadData(clk, rst, readDataIn, readDataOut);
Reg5bits RegisterRd(clk, rst, registerRdIn, registerRdOut);

endmodule
