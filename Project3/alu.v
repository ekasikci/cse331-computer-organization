module alu (
	output [31:0] 		alu_result,
	output 				zero_bit,
	input [31:0] 		alu_src1,
	input [31:0] 		alu_src2,
	input [2:0]			alu_ctr
);

	wire [31:0] and_result, or_result, xor_result, nor_result, less_than_result, add_result, sub_result, mod_result;
   wire [31:0] mux_inputs[7:0];
	wire unused_cout;  // A wire for the unused carry-out

   // Instantiate ALU operations
   and_gate_32bit and_gate_inst(.result(and_result), .A(alu_src1), .B(alu_src2));
   or_gate_32bit or_gate_inst(.result(or_result), .A(alu_src1), .B(alu_src2));
   xor_gate_32bit xor_gate_inst(.result(xor_result), .A(alu_src1), .B(alu_src2));
   nor_gate_32bit nor_gate_inst(.result(nor_result), .A(alu_src1), .B(alu_src2));
   less_than_32bit less_than_inst(.a(alu_src1), .b(alu_src2), .less_than_result(less_than_result));
   adder_32bit adder_inst(.A(alu_src1), .B(alu_src2), .c0(1'b0), .out(add_result), .cout(unused_cout));
   subtractor_32bit subtractor_inst(.a(alu_src1), .b(alu_src2), .diff(sub_result));
   mod mod_inst(.clk(clk), .A(alu_src1), .B(alu_src2), .Result(mod_result), .reset(reset));
	
	// Instantiate the 8-to-1 MUX for selecting the ALU operation result
	mux_8x1_32bit mux_8x1_32bit_inst(
		.out(alu_result),
		.in0(and_result), 		// AND - 000
		.in1(or_result),  		// OR - 001
		.in2(xor_result), 		// XOR - Placeholder for 010
		.in3(nor_result), 		// NOR - Placeholder for 011
		.in4(less_than_result), // LESS THAN - 100
		.in5(add_result), 		// ADD - 101
		.in6(sub_result), 		// SUB - 110
		.in7(mod_result), 		// MOD - Placeholder for R-type or other operations (111)
		.select(alu_ctr)
		);
		
	// NOR gate to determine if all bits of alu_result are zero
	nor nor_zero(zero_bit, alu_result[0], alu_result[1], alu_result[2], alu_result[3],
				alu_result[4], alu_result[5], alu_result[6], alu_result[7],
				alu_result[8], alu_result[9], alu_result[10], alu_result[11],
				alu_result[12], alu_result[13], alu_result[14], alu_result[15],
				alu_result[16], alu_result[17], alu_result[18], alu_result[19],
				alu_result[20], alu_result[21], alu_result[22], alu_result[23],
				alu_result[24], alu_result[25], alu_result[26], alu_result[27],
				alu_result[28], alu_result[29], alu_result[30], alu_result[31]);
		
	
endmodule
