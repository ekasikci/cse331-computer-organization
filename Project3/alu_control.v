module alu_control (
	output[2:0] alu_ctr, 
	input [5:0] function_code,
	input [2:0] ALUop
);

	wire is_r_type;	
	wire[2:0] r_type_result;
	
	wire not_function_code_2;
	wire not_function_code_1;
	wire not_function_code_0;
	
	wire and_1;
	wire and_2;
	
	not not1(not_function_code_2,function_code[2]);
	not not2(not_function_code_1,function_code[1]);
	not not3(not_function_code_0,function_code[0]);
	
	and and1(is_r_type,ALUop[0],ALUop[1],ALUop[2]);
	
	or  or1(r_type_result[2], function_code[1], 1'b0);
	and and2(r_type_result[1], not_function_code_2, function_code[1], function_code[0]);
	and and3(and_1, function_code[2], not_function_code_1, function_code[0]);
	and and4(and_2, not_function_code_2, function_code[1], not_function_code_0);
	or  or2(r_type_result[0], and_1, and_2);
	
	
	mux_2x1_1bit mux0(alu_ctr[0], ALUop[0], r_type_result[0], is_r_type);
	mux_2x1_1bit mux1(alu_ctr[1], ALUop[1], r_type_result[1], is_r_type);
	mux_2x1_1bit mux2(alu_ctr[2], ALUop[2], r_type_result[2], is_r_type);

endmodule
