module instruction_block(
	output [31:0] instruction,
	input [31:0] pc
);

	reg [31:0] instruction_memory [1023:0]; // Memory array to store up to 1024 instructions.
	
	assign instruction = instruction_memory[pc[9:0]];
	
	initial begin
		$readmemb("instructions.mem", instruction_memory); // Load instructions from file
	end
	 
	always @(*) begin
		$display("Time: %t, PC: %b, Fetched Instruction: %b", $time, pc, instruction);
	end


endmodule
