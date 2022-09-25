module PipelineMips(clk, reset);
  input clk, reset;
  wire [1:0] MEM, WB, ALUOp;
  wire [3:0] EX;
  wire Jump,  Branch, BranchNot;
  wire [5:0] opcode, func;
  wire [7:0] controlSignalStage;
  wire [2:0] ALU_Operation;
  assign controlSignalStage[3:0] = EX;
  assign controlSignalStage[5:4] = WB;
  assign controlSignalStage[7:6] = MEM;
  
  DataPath DataPath(clk, reset, controlSignalStage, Jump, func, opcode, ALU_Operation, ALUOp, Branch, BranchNot);
  Controller Controller(opcode, EX, MEM, WB, Jump, Branch, BranchNot);
  AluController AluController(ALUOp, func, ALU_Operation);
  
  
  
endmodule