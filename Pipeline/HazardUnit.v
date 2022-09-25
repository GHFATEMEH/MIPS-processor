 module HazardUnit(Rs, Rt, ID_EX_MemRead, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_RegWrite, IF_ID_Write, Sel, PCWrite, EX_MEM_MemRead, Branch, BranchNot, EX_MEM_RegisterRt);
  input [4:0] Rs, Rt, ID_EX_RegisterRt, ID_EX_RegisterRd, EX_MEM_RegisterRt;
  input ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_MemRead, Branch, BranchNot;
  output reg Sel, PCWrite, IF_ID_Write;

  always @(Rs or Rt or ID_EX_MemRead or ID_EX_RegisterRt or ID_EX_RegisterRd or EX_MEM_RegisterRt or ID_EX_RegWrite or EX_MEM_MemRead or Branch or BranchNot)
      begin
          {PCWrite, IF_ID_Write} = 2'b11;
          Sel = 1'b1;
          if((ID_EX_MemRead == 1'b1) && ((ID_EX_RegisterRt == Rs) || (ID_EX_RegisterRt == Rt)) && (ID_EX_RegisterRt !=0))begin
              Sel = 1'b0;
              PCWrite = 1'b0;
              IF_ID_Write = 1'b0;
          end
          else if((EX_MEM_MemRead == 1'b1) && ((Branch == 1'b1) || (BranchNot == 1'b1)) && ((EX_MEM_RegisterRt == Rs) || (EX_MEM_RegisterRt == Rt)) && (EX_MEM_RegisterRt !=0))begin
              Sel = 1'b0;
              PCWrite = 1'b0;
              IF_ID_Write = 1'b0;
          end
          else if((ID_EX_RegWrite == 1'b1) && ((Branch == 1'b1) || (BranchNot == 1'b1)) && ((ID_EX_RegisterRd == Rs) || (ID_EX_RegisterRd == Rt)) && (ID_EX_RegisterRd !=0))begin
              Sel = 1'b0;
              PCWrite = 1'b0;
              IF_ID_Write = 1'b0;
          end
    end
endmodule