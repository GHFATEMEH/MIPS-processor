module DataPath(clk, reset, x, IorD, MemWrite, MemRead, IRWrite, RegDst, MemToReg, RegWrite,
 ALUSrcA, ALUSrcB, ALUOperation, PCSrc, Sel1, Sel2, Sel3, zero, func, opcode);
 
  input clk, reset, IorD, MemWrite, MemRead, IRWrite, RegDst, MemToReg, RegWrite, ALUSrcA, x, Sel1, Sel2, Sel3;
  input [2:0] ALUOperation;
  input [1:0] PCSrc, ALUSrcB;
  output wire [5:0] func, opcode;
  output wire zero;

  wire [31:0] nextPc, pc, ALUOUTReg, address, ReadData, BRegOut, ARegOut, ir, mdr, z, WriteData, a,
  l, Read_Data1, Read_Data2, A, B, c, ALUResult, four, zero_num;

  wire [4:0] y, WriteReg,thirthyOne;
  wire ALUZero;
  wire [27:0]b;

  assign thirthyOne = 5'b11111;
  assign four = 32'b00000000000000000000000000000100;
  assign zero_num = 32'b0;
  assign func = ir[5:0];
  assign opcode = ir[31:26];
  assign zero = ALUZero;


  Register_with_control PC (nextPc, clk, reset, x, pc);
  Mux32bits MuxMemory (ALUOUTReg, pc, IorD, address);
  Memory Memory (clk, reset, MemWrite, MemRead, address, BRegOut, ReadData);
  Register_with_control IR (ReadData, clk, reset, IRWrite, ir);
  Register MDR (ReadData, clk, reset, mdr);
  Mux5bits MaxWriteReg1 (ir[15:11], ir[20:16], RegDst, y);
  Mux5bits MaxWriteReg2 (thirthyOne, y, Sel1, WriteReg);
  Mux32bits MuxWriteData1 (mdr, ALUOUTReg, MemToReg, z);
  Mux32bits MuxWriteData2 (pc, z, Sel2, WriteData);
  SignExtender Extender (ir[15:0], l);
  RegisterFile RegFile (ir[25:21], ir[20:16], WriteReg, WriteData, RegWrite, clk, reset, Read_Data1, Read_Data2);
  Register RegA (Read_Data1, clk, reset, ARegOut);
  Register RegB (Read_Data2, clk, reset, BRegOut);
  Shifter32bits Shifter32 (l, a);
  Mux32bits MuxAReg (ARegOut, pc, ALUSrcA, A);
  Mux32bits MuxConstantValue (zero_num, four, Sel3, c);
  Mux4 Mux4 (BRegOut, c, l, a, ALUSrcB, B);
  ALU ALU (A, B, ALUOperation, ALUResult, ALUZero);
  Register ALUOut (ALUResult, clk, reset, ALUOUTReg);
  Shifter26bits Shifter26 (ir[25:0], b);
  Mux3 Mux3 (ALUResult,{pc[31:28],b}, ALUOUTReg, PCSrc, nextPc);

endmodule