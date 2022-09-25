module Mux8bits(controlSignalStage, zero, controlSel, EX, MEM, WB);
  input [7:0] controlSignalStage, zero;
  input controlSel;
  output wire [1:0] MEM;
  output wire [1:0] WB;
  output wire [3:0] EX;
  assign {MEM,WB,EX} = controlSel ? controlSignalStage : zero;
endmodule

  
