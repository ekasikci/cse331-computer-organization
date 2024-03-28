module control_unit (
	output       regDst,
	output   	 branch,
	output 	 	 memRead, 			// (This can also be used as memToReg)
	output 	 	 memWrite, 
	output [2:0] ALUop, 				// (This was assigned as [1:0] before, by mistake. It should be [2:0])
	output 	    ALUsrc,
	output 	 	 regWrite,
	output 	 	 jump, 
	output 	 	 byteOperations,  // (This is an optional signal for lb and sb operations) 
	output 	 	 move, 				// (This is an optional signal for MOVE operation)
	input [5:0]  opcode
);

    // Logic gates for control signal generation
	wire r_format, lw, sw, beq;

   // Opcodes for different instruction types
   wire opcode_0_n, opcode_1_n, opcode_2_n, opcode_3_n, opcode_4_n, opcode_5_n;
   not not0(opcode_0_n, opcode[0]);
   not not1(opcode_1_n, opcode[1]);
   not not2(opcode_2_n, opcode[2]);
   not not3(opcode_3_n, opcode[3]);
   not not4(opcode_4_n, opcode[4]);
   not not5(opcode_5_n, opcode[5]);

   // Decoded instruction types
	wire add,
	   subtract,
	   add_immediate,
	   subtract_immediate,
	   and_,
	   or_,
	   and_immediate,
	   or_immediate,
	   load_word,
	   store_word,
	   load_byte,
	   store_byte,
	   set_on_less_than,
	   set_on_less_than_immediate,
	   branch_on_equal,
	   branch_on_not_equal,
	   jump_,
	   jump_and_link,
	   jump_register,
		move_;

   
   // Decode each instruction based on its opcode
   and and_0(add, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // add (opcode 000000)
   and and_1(subtract, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // subtract (opcode 000000)

   and and_2(add_immediate, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode[1], opcode_0_n); // addi (opcode 000010)
   and and_3(subtract_immediate, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode[1], opcode[0]); // subi (opcode 000011)

   and and_4(and_, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // and (opcode 000000)
   and and_5(or_, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // or (opcode 000000)

   and and_6(and_immediate, opcode_5_n, opcode_4_n, opcode_3_n, opcode[2], opcode_1_n, opcode_0_n); // andi (opcode 000100)
   and and_7(or_immediate, opcode_5_n, opcode_4_n, opcode_3_n, opcode[2], opcode_1_n, opcode[0]); // ori (opcode 000101)

   and and_8(load_word, opcode_5_n, opcode_4_n, opcode[3], opcode_2_n, opcode_1_n, opcode_0_n); // lw (opcode 001000)
   and and_9(store_word, opcode_5_n, opcode[4], opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // sw (opcode 010000)

   and and_10(load_byte, opcode_5_n, opcode_4_n, opcode[3], opcode_2_n, opcode_1_n, opcode[0]); // lb (opcode 001001)
	and and_11(store_byte, opcode_5_n, opcode[4], opcode_3_n, opcode_2_n, opcode_1_n, opcode[0]); // sb (opcode 010001)

	and and_12(set_on_less_than, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // slt (opcode 000000)
	and and_13(set_on_less_than_immediate, opcode_5_n, opcode_4_n, opcode_3_n, opcode[2], opcode[1], opcode[0]); // slti (opcode 000111)

	and and_14(branch_on_equal, opcode[5], opcode_4_n, opcode_3_n, opcode_2_n, opcode[1], opcode[0]); // beq (opcode 100011)
	and and_15(branch_on_not_equal, opcode[5], opcode_4_n, opcode_3_n, opcode[2], opcode[1], opcode[0]); // bne (opcode 100111)

	and and_16(jump_, opcode[5], opcode[4], opcode[3], opcode_2_n, opcode_1_n, opcode_0_n); // j (opcode 111000)
	and and_17(jump_and_link, opcode[5], opcode[4], opcode[3], opcode_2_n, opcode_1_n, opcode[0]); // jal (opcode 111001)

	and and_18(jump_register, opcode_5_n, opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // jr (opcode 000000)
	and and_19(move_, opcode[5], opcode_4_n, opcode_3_n, opcode_2_n, opcode_1_n, opcode_0_n); // jr (opcode 100000)
	
	
	or or_0(regDst, add, subtract, and_, or_, set_on_less_than, set_on_less_than_immediate);
   or or_1(branch, branch_on_equal, branch_on_not_equal);
   or or_2(memRead, load_word, load_byte);
   or or_3(memWrite, store_word, store_byte);
   or or_4(ALUsrc, add_immediate, subtract_immediate, and_immediate, or_immediate, load_word, load_byte, store_word, store_byte, 
	branch_on_equal, branch_on_not_equal, set_on_less_than_immediate);
   or or_5(regWrite, add, subtract, and_, or_, add_immediate, subtract_immediate, and_immediate, or_immediate, set_on_less_than, set_on_less_than_immediate, load_word, load_byte, move_);
   or or_6(jump, jump_, jump_and_link/*, jump_register*/);
   or or_7(byteOperations, load_byte, store_byte);
   or or_8(move, move_);
	
	wire [2:0] aluop_andi, aluop_ori, aluop_slti, aluop_addi_lb_sb_lw_sw, aluop_subi_beq_bne, aluop_r_type;
	
	// Set ALUop based on the instruction
   // ANDI operation (ALUop = 000)
   and and_aluop0_0(aluop_andi[0], and_immediate, 1'b0);
   and and_aluop0_1(aluop_andi[1], and_immediate, 1'b0);
   and and_aluop0_2(aluop_andi[2], and_immediate, 1'b0);

   // ORI operation (ALUop = 001)
   and and_aluop1_0(aluop_ori[0], or_immediate, 1'b1);
   and and_aluop1_1(aluop_ori[1], or_immediate, 1'b0);
   and and_aluop1_2(aluop_ori[2], or_immediate, 1'b0);

   // SLTI operation (ALUop = 100)
   and and_aluop2_0(aluop_slti[0], set_on_less_than_immediate, 1'b0);
   and and_aluop2_1(aluop_slti[1], set_on_less_than_immediate, 1'b0);
   and and_aluop2_2(aluop_slti[2], set_on_less_than_immediate, 1'b1);

   // ADDI, LB, SB, LW, SW operation (ALUop = 101)
   wire addi_lb_sb_lw_sw_op;
   or or_addi_lb_sb_lw_sw(addi_lb_sb_lw_sw_op, add_immediate, load_word, store_word, load_byte, store_byte);
   and and_aluop3_0(aluop_addi_lb_sb_lw_sw[0], addi_lb_sb_lw_sw_op, 1'b1);
   and and_aluop3_1(aluop_addi_lb_sb_lw_sw[1], addi_lb_sb_lw_sw_op, 1'b0);
   and and_aluop3_2(aluop_addi_lb_sb_lw_sw[2], addi_lb_sb_lw_sw_op, 1'b1);

   // SUBI, BEQ, BNE operation (ALUop = 110)
   wire subi_beq_bne_op;
   or or_subi_beq_bne(subi_beq_bne_op, subtract_immediate, branch_on_equal, branch_on_not_equal);
   and and_aluop4_0(aluop_subi_beq_bne[0], subi_beq_bne_op, 1'b0);
   and and_aluop4_1(aluop_subi_beq_bne[1], subi_beq_bne_op, 1'b1);
   and and_aluop4_2(aluop_subi_beq_bne[2], subi_beq_bne_op, 1'b1);

   // R-type operation (ALUop = 111)
   wire r_type_op;
   and and_r_type(r_type_op, add, subtract, and_, or_, set_on_less_than, jump_register);
   and and_aluop5_0(aluop_r_type[0], r_type_op, 1'b1);
   and and_aluop5_1(aluop_r_type[1], r_type_op, 1'b1);
   and and_aluop5_2(aluop_r_type[2], r_type_op, 1'b1);
	
	// ALUop[0]
	or or_aluop_0(ALUop[0], aluop_andi[0], aluop_ori[0], aluop_slti[0], aluop_addi_lb_sb_lw_sw[0], aluop_subi_beq_bne[0], aluop_r_type[0]);

   // ALUop[1]
   or or_aluop_1(ALUop[1], aluop_andi[1], aluop_ori[1], aluop_slti[1], aluop_addi_lb_sb_lw_sw[1], aluop_subi_beq_bne[1], aluop_r_type[1]);

   // ALUop[2]
   or or_aluop_2(ALUop[2], aluop_andi[2], aluop_ori[2], aluop_slti[2], aluop_addi_lb_sb_lw_sw[2], aluop_subi_beq_bne[2], aluop_r_type[2]);
	
	// Display Control Signals and Opcode
	always @(*) begin
		$display("Time: %t, Opcode: %b, Control Signals - regDst: %b, branch: %b, memRead: %b, memWrite: %b, ALUop: %b, ALUsrc: %b, regWrite: %b, jump: %b, byteOperations: %b, move: %b", 
					$time, opcode, regDst, branch, memRead, memWrite, ALUop, ALUsrc, regWrite, jump, byteOperations, move);
	end
	
	// Display Decoded Instruction Types
	always @(*) begin
		$display("Time: %t, Decoded Instructions - Add: %b, Subtract: %b, Addi: %b, Subi: %b, And: %b, Or: %b, Andi: %b, Ori: %b, LW: %b, SW: %b, LB: %b, SB: %b, SLT: %b, SLTI: %b, BEQ: %b, BNE: %b, J: %b, JAL: %b, JR: %b, Move: %b",
					$time, add, subtract, add_immediate, subtract_immediate, and_, or_, and_immediate, or_immediate, load_word, store_word, load_byte, store_byte, set_on_less_than, set_on_less_than_immediate, branch_on_equal, branch_on_not_equal, jump_, jump_and_link, jump_register, move_);
	end

endmodule
