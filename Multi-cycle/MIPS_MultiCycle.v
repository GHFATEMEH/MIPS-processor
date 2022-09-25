module MIPS_MultiCycle(clk, reset);
  input clk, reset;
  wire x, IorD, MemWrite, MemRead, IRWrite, RegDst, MemToReg, RegWrite, ALUSrcA, Sel1, Sel2, Sel3, zero,
  PCWrite, PCWriteCond, PCBne;
  wire [1:0] ALUSrcB, PCSrc, ALUOp;
  wire [2:0] ALUOperation;
  wire [5:0] func, opcode;
  wire e,f;
  
  DataPath DataPath (clk, reset, x, IorD, MemWrite, MemRead, IRWrite, RegDst, MemToReg, RegWrite,
  ALUSrcA, ALUSrcB, ALUOperation, PCSrc, Sel1, Sel2, Sel3, zero, func, opcode);
  
  Controller Controller (clk, reset, opcode, PCWrite, PCWriteCond, PCBne, MemWrite, MemRead, IRWrite, 
	IorD, MemToReg, RegWrite, Sel1, Sel2, Sel3, RegDst, ALUSrcB, ALUSrcA, PCSrc, ALUOp);
					
	AluController AluController (ALUOp, func, ALUOperation);	
  
  assign e = PCWriteCond & zero;
  assign f = PCBne & ~zero;
  assign x = PCWrite | e | f;
  
endmodule
  