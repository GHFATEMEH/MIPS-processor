module ALU(a, b, ALU_Operation, ALU_Result, Zero);
  input [31:0] a, b;
  input [2:0] ALU_Operation;
  output reg[31:0] ALU_Result;
  output wire Zero;
  
  always@(a, b , ALU_Operation)
  begin
    case(ALU_Operation)
      3'b000:ALU_Result = a & b;
      3'b001:ALU_Result = a | b;
      3'b010:ALU_Result = a + b;
      3'b011:ALU_Result = a - b;
      3'b111:begin if(a < b)
                      ALU_Result = 32'b00000000000000000000000000000001;
                  else
                    ALU_Result = 32'b0;
                  end
      default:ALU_Result = 32'b0;
    endcase
  end
  assign Zero = (ALU_Result == 32'b0) ?
                1'b1 : 1'b0;
endmodule
  
