module Memory(clk, rst, memWrite, memRead, address, writeData, readData);
	input clk, rst, memRead, memWrite;
	input [31:0] address, writeData;
	output wire [31:0] readData;
	wire [15:0] ramAdd = address[15:0];
	reg [7:0] ram [0:65535];
	integer i;
	initial
	begin
		$readmemb("Mem.data", ram);
	end
	always@ (posedge clk)
	begin
		if(memWrite)begin
			ram[ramAdd] <= writeData[31:24];
			ram[ramAdd + 16'b0000000000000001] <= writeData[23:16];
			ram[ramAdd + 16'b0000000000000010] <= writeData[15:8];
			ram[ramAdd + 16'b0000000000000011] <= writeData[7:0];
		end
	end
	assign readData = memRead ? {ram[ramAdd], ram[ramAdd + 16'b0000000000000001], 
  									ram[ramAdd + 16'b0000000000000010], ram[ramAdd + 16'b0000000000000011]} : 32'b0;
endmodule
