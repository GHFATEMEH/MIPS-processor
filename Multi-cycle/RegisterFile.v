module RegisterFile(Read_Register1, Read_Register2, Write_Register, Write_Data,
RegWrite, clk, reset, Read_Data1, Read_Data2);
input [4:0] Read_Register1, Read_Register2, Write_Register;
input [31:0] Write_Data;
input clk, reset, RegWrite;
output wire [31:0] Read_Data1, Read_Data2;

reg [31:0] reg_File [0:31];
integer i;

always @(posedge clk, posedge reset)
  begin
    if(reset == 1'b1)
      for(i = 0; i < 32; i = i + 1)begin
        reg_File[i] <= 32'b0;
      end
    else if(RegWrite == 1'b1)
            reg_File[Write_Register] <= Write_Data;
    end
    
assign Read_Data1 = reg_File[Read_Register1];
assign Read_Data2 = reg_File[Read_Register2];
endmodule

