module mips(input clock);

	// Program Counter
	reg [31:0] pc;
	
	wire [31:0] write_data;
	
	// Instruction Memory
	wire [31:0] instruction;
	instruction_block inst_block(
		.instruction(instruction),
		.pc(pc)
	);
	
	// Control Unit
	wire regDst, branch, memRead, memWrite, ALUsrc, regWrite, jump, byteOperations, move;
	wire [2:0] ALUop;
	control_unit ctrl_unit(
		.regDst(regDst),
		.branch(branch),
		.memRead(memRead),
		.memWrite(memWrite),	  
		.ALUop(ALUop), 
		.ALUsrc(ALUsrc),
		.regWrite(regWrite),
		.jump(jump),
		.byteOperations(byteOperations),
		.move(move),
		.opcode(instruction[31:26])
	);
	
	// ALU Control Unit
	wire [2:0] alu_ctr;
	alu_control alu_control_inst(
		.alu_ctr(alu_ctr),
		.function_code(instruction[5:0]),
		.ALUop(ALUop)
	);
	
	wire [4:0] write_reg;
	mux_2x1_5bit mux_2x1_5bit_inst0(
			.out(write_reg),
			.in0(instruction[20:16]), 
			.in1(instruction[15:11]),
			.select(regDst)
	);
	
	// Register File
	wire [31:0] read_data1, read_data2;
	register_block reg_block(
		.read_data1(read_data1),
		.read_data2(read_data2),
		.byteOperations(byteOperations),
		.write_data(write_data),
		.read_reg1(instruction[25:21]),
		.read_reg2(instruction[20:16]),
		.write_reg(write_reg),
		.regWrite(regWrite)
	);
	
	// Sign Extend
	wire [31:0] sign_ext_imm;
	sign_extend sign_extend_inst(
		.sign_ext_imm(sign_ext_imm),
		.imm(instruction[15:0])
	);
	
	wire [31:0] alu_src2;
	mux_2x1_32bit mux_2x1_32bit_inst0(
			.out(alu_src2),
			.in0(read_data2), 
			.in1(sign_ext_imm),
			.select(ALUsrc)
	);
	
	// ALU
	wire [31:0] alu_result;
	wire zero;
	alu alu_inst(
		.alu_result(alu_result),
		.zero_bit(zero),
		.alu_src1(read_data1),
		.alu_src2(alu_src2),
		.alu_ctr(alu_ctr)
	);
	
	// Data Memory
	wire [31:0] read_data;
	memory_block memory_block_inst(
		.read_data(read_data),
		.byteOperations(byteOperations),
		.address(alu_result[17:0]),
		.write_data(read_data2),
		.memRead(memRead),
		.memWrite(memWrite)
	);
	
	wire [31:0] data_out;
	mux_2x1_32bit mux_2x1_32bit_inst1(
			.out(data_out),
			.in0(alu_result), 
			.in1(read_data),
			.select(memRead)
	);
	

	
	// Shift Left 2 (for branch address calculation)
	wire [31:0] shifted_branch_address;
	shift_left_2 shift_left_2_sign_extended(
		.shifted_address(shifted_branch_address),
		.address(sign_ext_imm) // Immediate value is extended with zeros before shifting
	);
	
	wire [31:0] pc_add_result;
	wire unused_cout;  // A wire for the unused carry-out
	adder_32bit pc_adder_inst(
		.A(pc), 
		.B(32'd1),
		.c0(1'b0), 
		.out(pc_add_result), 
		.cout(unused_cout)
	);
	
	wire [31:0] branch_add_result;
	wire unused_cout_2;  // A wire for the unused carry-out
	adder_32bit branch_adder_inst(
		.A(pc_add_result), 
		.B(shifted_branch_address),
		.c0(1'b0), 
		.out(branch_add_result), 
		.cout(unused_cout_2)
	);
	
	wire and_branch_out;
	and and_branch(and_branch_out, branch, zero);
	
	
	wire [31:0] branch_mux_result;
	mux_2x1_32bit mux_2x1_32bit_inst2(
			.out(branch_mux_result),
			.in0(pc_add_result), 
			.in1(branch_add_result),
			.select(and_branch_out)
	);
	
	//wire [31:0] shifted_instruction;
	//shift_left_2 shift_left_2_instruction(
	//	.shifted_address(shifted_instruction),
	//	.address(instruction) // Immediate value is extended with zeros before shifting
	//);
	
		// Shift instruction[25:0] left by 2 and append two zeros
	wire [27:0] shifted_instruction;
	wire [31:0] jump_address;
	
	// Manual shifting - appending two zeros at the end
	assign shifted_instruction[27:2] = instruction[25:0];
	assign shifted_instruction[1:0] = 2'b00;
	
	// Concatenate with the 4 MSB of pc_add_result
	// Manual concatenation
	assign jump_address[31:28] = pc_add_result[31:28];
	assign jump_address[27:0] = shifted_instruction;
	
	wire [31:0] pc_out;
	mux_2x1_32bit mux_2x1_32bit_inst3(
			.out(pc_out),
			.in0(branch_mux_result), 
			.in1(jump_address),
			.select(jump)
	);
	
	
	// Perform move operation by giving data memory result and rs register to a mux
	// wire [31:0] data_mux_out;
	mux_2x1_32bit move_operation_mux(
			.out(write_data),
			.in0(data_out), 
			.in1(read_data1),
			.select(move)
	);
  
	initial begin
		pc <= 32'b00000000000000000000000000000000; // -4 in 32-bit signed representation
	end

	always @(posedge clock) begin	
		pc <= pc_out;
	end


	
endmodule
