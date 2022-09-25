module InstMem(Address, Instruction);
  input [31:0] Address;
  output wire [31:0] Instruction;
  
  wire [15:0] ramAdd = Address[15:0];
  reg [7:0] Instruction_Mem [0:65535];
  
  initial
  begin
    $readmemb ("Mem_Inst.data", Instruction_Mem);
  end
  assign Instruction = {Instruction_Mem[ramAdd], Instruction_Mem[ramAdd + 16'b0000000000000001], 
  						          	Instruction_Mem[ramAdd + 16'b0000000000000010], Instruction_Mem[ramAdd + 16'b0000000000000011]};
endmodule
