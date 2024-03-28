module mux_8x1_1bit (output result, input and_result, or_result, xor_result, nor_result, less_than_result, add_result, sub_result, mod_result, input [2:0] s);
	wire not_s0, not_s1, not_s2;
	wire [7:0] and_gate_outputs;
	
	not not0 (not_s0, s[0]);
	not not1 (not_s1, s[1]);
	not not2 (not_s2, s[2]);
	
	and and0 (and_gate_outputs[0], and_result, not_s2, not_s1, not_s0);
	and and1 (and_gate_outputs[1], or_result, not_s2, not_s1, s[0]);
	and and2 (and_gate_outputs[2], xor_result, not_s2, s[1], not_s0);
	and and3 (and_gate_outputs[3], nor_result, not_s2, s[1], s[0]);
	and and4 (and_gate_outputs[4], less_than_result, s[2], not_s1, not_s0);
	and and5 (and_gate_outputs[5], add_result, s[2], not_s1, s[0]);
	and and6 (and_gate_outputs[6], sub_result, s[2], s[1], not_s0);
	and and7 (and_gate_outputs[7], mod_result, s[0], s[1], s[2]);

	or or0 (result, and_gate_outputs[0], and_gate_outputs[1], and_gate_outputs[2], and_gate_outputs[3], and_gate_outputs[4], and_gate_outputs[5], and_gate_outputs[6], and_gate_outputs[7]);
endmodule
