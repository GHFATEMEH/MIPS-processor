module ForwardingUnit(ID_EX_RegWrite, ID_EX_RegisterRd, ID_EX_RegisterRt, ID_EX_RegisterRs, MEM_WB_RegisterRd, MEM_WB_RegWrite, EX_MEM_RegisterRd, EX_MEM_RegWrite,
instruction, ForwardA, ForwardB, Sel1, Sel2);
  input [31:0]instruction;
  input [4:0] ID_EX_RegisterRd, ID_EX_RegisterRt, ID_EX_RegisterRs, MEM_WB_RegisterRd, EX_MEM_RegisterRd;
  input ID_EX_RegWrite, MEM_WB_RegWrite, EX_MEM_RegWrite;
  output reg [1:0] ForwardA, ForwardB;
  output reg Sel1, Sel2;
  wire tempA, tempB;

  assign tempA = (EX_MEM_RegWrite == 1'b1) & ((EX_MEM_RegisterRd == ID_EX_RegisterRs) || (EX_MEM_RegisterRd == ID_EX_RegisterRt)) & (EX_MEM_RegisterRd != 0); 
  
  
  assign tempB = (ID_EX_RegWrite == 1'b1) & ((ID_EX_RegisterRd == instruction[25:21]) ||(ID_EX_RegisterRd == instruction[20:16])) & (ID_EX_RegisterRd != 0);

  always @(instruction or ID_EX_RegWrite or ID_EX_RegisterRd or ID_EX_RegisterRt or ID_EX_RegisterRs or MEM_WB_RegisterRd or MEM_WB_RegWrite or EX_MEM_RegisterRd or EX_MEM_RegWrite)
      begin
          ForwardB = 2'b00;
          ForwardA = 2'b00;
          Sel1 = 1'b0;
          Sel2 = 1'b0;
          if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegisterRd == ID_EX_RegisterRs) && (EX_MEM_RegisterRd != 0))
              ForwardA = 2'b01;

          else if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegisterRd == ID_EX_RegisterRt) && (EX_MEM_RegisterRd != 0))
              ForwardB = 2'b01;
        
          else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_RegisterRd == ID_EX_RegisterRs) && (MEM_WB_RegisterRd != 0) && (!tempA))
              ForwardA = 2'b10;

          else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_RegisterRd == ID_EX_RegisterRt) && (MEM_WB_RegisterRd != 0) && (!tempA))
              ForwardB = 2'b10;
        
          else if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegisterRd == instruction[25:21]) && (EX_MEM_RegisterRd != 0) && (!tempB))
              Sel1 = 1'b1;
        
          else if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_RegisterRd == instruction[20:16]) && (EX_MEM_RegisterRd !=0) && (!tempB))
              Sel2 = 1'b1;
      end
endmodule

