module Controller(clk, rst, opcode, PCWrite, PCWriteCond, PCBne, MemWrite, MemRead, IRWrite, 
					IorD, MemToReg, RegWrite, Sel1, Sel2, Sel3, RegDst, ALUSrcB, ALUSrcA, PCSrc, ALUOp);
input [5:0] opcode;
input clk, rst;
output reg PCWrite, PCWriteCond, PCBne, MemWrite, MemRead, IRWrite, IorD, MemToReg, RegWrite, 
			Sel1, Sel2, Sel3, RegDst, ALUSrcA;
output reg [1:0] ALUSrcB, PCSrc, ALUOp;
reg [3:0] ps, ns;
localparam IF = 4'b0000;
localparam ID = 4'b0001;
localparam j = 4'b0010;
localparam beq = 4'b0011;
localparam rt = 4'b0100;
localparam rtFinish = 4'b0101;
localparam memRef = 4'b0110;
localparam lw = 4'b0111;
localparam lwFinish = 4'b1000;
localparam sw = 4'b1001;
localparam bne = 4'b1010;
localparam andi = 4'b1011;
localparam addi = 4'b1100;
localparam immFinish = 4'b1101;
localparam jr = 4'b1110;
localparam jal = 4'b1111;

always @(posedge clk or posedge rst)begin
	if(rst)
		ps <= IF;
	else
		ps <= ns;
end

always @(opcode or ps)begin
	case(ps)
		IF: ns = ID;
		ID: begin
			if(opcode == 6'b0) ns = rt;
			else if(opcode == 6'b001000) ns = addi;
			else if(opcode == 6'b001100) ns = andi;
			else if(opcode == 6'b000100) ns = beq;
			else if(opcode == 6'b000101) ns = bne;
			else if(opcode == 6'b000001) ns = jr;
			else if(opcode == 6'b000011) ns = jal;
			else if(opcode == 6'b000010) ns = j;
			else ns = memRef;
		end
		j: ns = IF;
		beq: ns = IF;
		rt: ns = rtFinish;
		memRef: begin
			if(opcode == 6'b100011) ns = lw;
			else ns = sw;
		end
		lw: ns = lwFinish;
		sw: ns = IF;
		rtFinish: ns = IF;
		lwFinish: ns = IF;
		jal: ns = IF;
		bne: ns = IF;
		andi: ns = immFinish;
		addi: ns = immFinish;
		immFinish: ns = IF;
		jr: ns = IF;
	endcase
end

always @(ps)begin
	{PCWrite, PCWriteCond, PCBne, MemWrite, MemRead, IRWrite, IorD, MemToReg, RegWrite, 
		Sel1, Sel2, Sel3, RegDst, ALUSrcA} = 14'b0;
	ALUSrcB = 2'b00;
	PCSrc = 2'b00;
	ALUOp = 2'b00;
	case(ps)
		IF: begin
			{MemRead, IRWrite, PCWrite} = 3'b111;
			ALUSrcB = 2'b01;
		end
		ID: ALUSrcB = 2'b11;
		j: begin
			PCWrite = 1'b1;
			PCSrc = 2'b01;
		end
		beq: begin
			{ALUSrcA, PCWriteCond} = 2'b11;
			ALUOp = 2'b01;
			PCSrc = 2'b10; 
		end
		rt: begin
			ALUOp = 2'b10;
			ALUSrcA = 1'b1;
		end
		rtFinish: {RegDst, RegWrite} = 2'b11;
		memRef: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b10;
		end
		lw: {IorD, MemRead} = 2'b11;
		lwFinish: {MemToReg, RegWrite} = 2'b11;
		sw: {IorD, MemWrite} = 2'b11;
		jal: {Sel1, Sel2, RegWrite, PCSrc, PCWrite} = 5'b11111;
		bne: begin
			{ALUSrcA, PCBne} = 2'b11;
			ALUOp = 2'b01;
			PCSrc = 2'b10; 
		end
		andi: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b10;
			ALUOp = 2'b11;
		end
		addi: begin
			ALUSrcA = 1'b1;
			ALUSrcB = 2'b10;
			ALUOp = 2'b00;
		end
		immFinish: RegWrite = 1'b1;
		jr: begin
			{ALUSrcA, Sel3, PCWrite} = 3'b111;
			ALUSrcB = 2'b01;
		end
	endcase
end

endmodule