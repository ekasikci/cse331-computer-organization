module memory_operations(output reg[31:0] content, input [4:0] address);
	reg [31:0] registers [31:0];
	
	always @ (address) begin
		$readmemb("registers.mem", registers);
		content = registers[address];
		registers[address] = 32'b0;
		$writememb("registers.mem", registers);
	end
	
endmodule
