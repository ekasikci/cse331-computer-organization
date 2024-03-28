module mux_8x1_1bit (output out, input in0, in1, in2, in3, in4, in5, in6, in7, input [2:0] select);
	wire not_s0, not_s1, not_s2;
	wire [7:0] and_gate_outputs;
	
	not not0 (not_s0, select[0]);
	not not1 (not_s1, select[1]);
	not not2 (not_s2, select[2]);
	
	and and0 (and_gate_outputs[0], in0, not_s2, not_s1, not_s0);
	and and1 (and_gate_outputs[1], in1, not_s2, not_s1, select[0]);
	and and2 (and_gate_outputs[2], in2, not_s2, select[1], not_s0);
	and and3 (and_gate_outputs[3], in3, not_s2, select[1], select[0]);
	and and4 (and_gate_outputs[4], in4, select[2], not_s1, not_s0);
	and and5 (and_gate_outputs[5], in5, select[2], not_s1, select[0]);
	and and6 (and_gate_outputs[6], in6, select[2], select[1], not_s0);
	and and7 (and_gate_outputs[7], in7, select[0], select[1], select[2]);

	or or0 (out, and_gate_outputs[0], and_gate_outputs[1], and_gate_outputs[2], and_gate_outputs[3], and_gate_outputs[4], and_gate_outputs[5], and_gate_outputs[6], and_gate_outputs[7]);
endmodule
