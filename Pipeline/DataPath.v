module DataPath(clk, reset, controlSignalStage, Jump, func, opcode, ALU_Operation, ALUOp, Branch, BranchNot);
  input clk, reset, Jump, Branch, BranchNot;
  input [7:0] controlSignalStage;
  input [2:0] ALU_Operation;
  output wire [5:0] func, opcode;
  output wire [1:0] ALUOp;
  
  
  wire [31:0] Addr, Inst, nextPCIn, nextPCOut, instOut, writeData, readData1, readData2, resultOutEXMEM,
  readData1InIDEX, readData2InIDEX, extendedAdrIn, readData1OutIDEX, readData2OutIDEX, extendedAdrOut, muxA, b,
  resultInEXMEM, writeDataInEXMEM, writeDataOutEXMEM, readData, readDataOutMEMWB, resultOutMEMWB, addOut, shiftAdder,
  y, nextPC, four;
  wire IfIdWriteSignal, IfFlush, PCWrite, Sel1, Sel2, Zero, Sel, equal, PCSrc, c, d, controlSel;
  wire [4:0] rtOutIDEX, rdOutIDEX, rsOutIDEX, registerRdInEXMEM, registerRdOutEXMEM, registerRdOutMEMWB, registerRtOutEXMEM;
  wire [1:0] MEM , WB, wbOutIDEX, mOutIDEX, ForwardA, ForwardB, wbOutMEMWB, wbOutEXMEM, mOutEXMEM;
  wire [3:0] EX, exOutIDEX;
  wire [27:0] z;
  
  assign four = 32'b00000000000000000000000000000100;
	assign func = instOut[5:0];
	assign opcode = instOut[31:26];
	assign ALUOp = exOutIDEX[2:1];

  assign c = Branch & equal;
  assign d = BranchNot & ~equal;
  assign PCSrc = c | d;
  assign IfFlush = c | d;
  
  

  
  InstMem InstMem(Addr, Inst);
  
  Adder PCAdder(Addr, four, nextPCIn);
  PCRegister_with_control PC(nextPC, clk, reset, PCWrite, Addr);

  //////////////
  Shifter32bits Shifter32bits(extendedAdrIn, shiftAdder);
  Adder Adder(nextPCOut, shiftAdder, addOut);
  Mux32bits AdderMUX(addOut, nextPCOut, PCSrc, y);
  Shifter26bits Shifter26bits(instOut[25:0], z);
  Mux32bits jump({nextPCOut[31:28],z}, y, Jump, nextPC);
  assign controlSel = Sel & ~IfFlush;
  Mux8bits Mux8bits(controlSignalStage, 8'b00000000, controlSel, EX, MEM, WB);
  RegisterFile RegisterFile(instOut[25:21], instOut[20:16], registerRdOutMEMWB, writeData, wbOutMEMWB[1], clk, reset, readData1, readData2);
  Mux32bits MuxRegFile1(resultOutEXMEM, readData1, Sel1, readData1InIDEX);
  Mux32bits MuxRegFile2(resultOutEXMEM, readData2, Sel2, readData2InIDEX);
  Equal Equal(readData1InIDEX, readData2InIDEX, equal);
  IdExReg IdExReg(clk, reset, WB, wbOutIDEX, MEM, mOutIDEX, EX, exOutIDEX, readData1InIDEX, readData1OutIDEX, readData2InIDEX, readData2OutIDEX, instOut[20:16], rtOutIDEX, instOut[15:11], rdOutIDEX, instOut[25:21], rsOutIDEX, extendedAdrIn, extendedAdrOut);

  SignExtender SignExtender(instOut[15:0], extendedAdrIn);
  HazardUnit HazardUnit(instOut[25:21], instOut[20:16], mOutIDEX[1], rtOutIDEX, rdOutIDEX, wbOutIDEX[1], IfIdWriteSignal, Sel, PCWrite, mOutEXMEM[1], Branch, BranchNot, registerRtOutEXMEM);
  IfIdReg IfIdReg(clk, reset, IfIdWriteSignal, IfFlush, nextPCIn, Inst, nextPCOut, instOut);
  ////////////
  Mux3 Mux3_1(readData1OutIDEX, resultOutEXMEM, writeData, ForwardA, muxA);
  Mux3 Mux3_2(readData2OutIDEX, resultOutEXMEM, writeData, ForwardB, writeDataInEXMEM);
  Mux32bits Mux32bits_B (extendedAdrOut, writeDataInEXMEM, exOutIDEX[3], b);
  ALU ALU(muxA, b, ALU_Operation, resultInEXMEM, Zero);
  Mux5bits Mux5bits(rdOutIDEX, rtOutIDEX, exOutIDEX[0], registerRdInEXMEM);
  ExMemReg ExMemReg(clk, reset, wbOutIDEX, wbOutEXMEM, mOutIDEX, mOutEXMEM, resultInEXMEM, resultOutEXMEM, 
  writeDataInEXMEM, writeDataOutEXMEM, registerRdInEXMEM, registerRdOutEXMEM, rtOutIDEX, registerRtOutEXMEM);
  ForwardingUnit ForwardingUnit(wbOutIDEX[1], rdOutIDEX, rtOutIDEX, rsOutIDEX, registerRdOutMEMWB, wbOutMEMWB[1],
  registerRdOutEXMEM, wbOutEXMEM[1], instOut, ForwardA, ForwardB, Sel1, Sel2);
  
  ////////////
  DataMem DataMem(clk, reset, mOutEXMEM[0], mOutEXMEM[1], resultOutEXMEM, writeDataOutEXMEM, readData);
  MemWbReg MemWbReg(clk, reset, wbOutEXMEM, wbOutMEMWB, readData, readDataOutMEMWB, resultOutEXMEM, resultOutMEMWB, registerRdOutEXMEM, registerRdOutMEMWB);
  Mux32bits Mux32bitsMEMWB(readDataOutMEMWB, resultOutMEMWB, wbOutMEMWB[0], writeData);
  
endmodule
  
  
  

  
  
  
  
  

