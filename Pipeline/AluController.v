module AluController(aluOp, func, aluOperation);
  input [1:0] aluOp;
  input [5:0] func;
  output reg [2:0] aluOperation;
  always@ (aluOp or func)
  begin
    if(aluOp == 2'b00)
    	aluOperation = 3'b010;
   	else if(aluOp == 2'b01)
    	aluOperation = 3'b011;
    else if(aluOp == 2'b11)
    	aluOperation = 3'b000;
    else if(aluOp == 2'b10)
    begin
    	if(func == 6'b100100)
    		aluOperation = 3'b000;
    	if(func == 6'b100101)
    		aluOperation = 3'b001;
    	if(func == 6'b100000)
    		aluOperation = 3'b010;
    	if(func == 6'b100010)
    		aluOperation = 3'b011;
    	if(func == 6'b101010)
    		aluOperation = 3'b111;
    end
    else
    	aluOperation = 3'bxxx;
  end
endmodule
