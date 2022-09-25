module Controller(opcode, EX, MEM, WB, Jump, Branch, BranchNot);
  input [5:0] opcode;
  output reg [1:0] MEM;
  output reg [1:0] WB;
  output reg [3:0] EX;
  output reg Jump,  Branch, BranchNot;

  always @(opcode)
      begin
      {Jump,  Branch, BranchNot} = 3'b000;
      MEM = 2'b00;
      WB = 2'b00;
      EX = 4'b0000;
      case(opcode)
        6'b000000: begin 
          EX = 4'b0101;
          WB = 2'b10;
        end
        6'b001000:begin
          EX = 4'b1000;
          WB = 2'b10;
        end
        6'b001100:begin
          EX = 4'b1110;
          WB = 2'b10;
        end
        6'b100011:begin
          EX = 4'b1000;
          MEM = 2'b10;
          WB = 2'b11;
        end
        6'b101011:begin
          EX = 4'b100x;
          MEM = 2'b01;
          WB = 2'b0x;
        end
        6'b000100:begin
          EX = 4'b001x;
          WB = 2'b0x;
          Branch = 1'b1;
        end
        6'b000101:begin
          EX = 4'b001x;
          WB = 2'b0x;
          BranchNot = 1'b1;
        end
        6'b000010:begin
          EX = 4'bxxxx;
          WB = 4'b0x;
          Jump = 1'b1;
        end
      endcase
  end
endmodule
        