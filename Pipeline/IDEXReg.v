module IdExReg(clk, rst, wbIn, wbOut, mIn, mOut, exIn, exOut, readData1In, readData1Out, readData2In, readData2Out, rtIn, rtOut, rdIn, rdOut, rsIn, rsOut, extendedAdrIn, extendedAdrOut); 
  input clk, rst;
  input [1:0]wbIn, mIn;
  input [3:0]exIn;
  input [31:0]readData1In, readData2In, extendedAdrIn;
  input [4:0]rtIn, rdIn, rsIn;
  output wire[1:0]wbOut, mOut;
  output wire[3:0]exOut;
  output wire[31:0]readData1Out, readData2Out, extendedAdrOut;
  output wire[4:0]rtOut, rdOut, rsOut;

  Reg4bits EX(clk, rst, exIn, exOut);
  Reg2bits WB(clk, rst, wbIn, wbOut);
  Reg2bits M(clk, rst, mIn, mOut);
  Reg32bits ReadData1(clk, rst, readData1In, readData1Out);
  Reg32bits ReadData2(clk, rst, readData2In, readData2Out);
  Reg32bits ExtendedAdr(clk, rst, extendedAdrIn, extendedAdrOut);
  Reg5bits Rt(clk, rst, rtIn, rtOut);
  Reg5bits Rs(clk, rst, rsIn, rsOut);
  Reg5bits Rd(clk, rst, rdIn, rdOut);

endmodule