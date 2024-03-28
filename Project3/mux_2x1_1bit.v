module mux_2x1_1bit(
	output out,
	input in0, in1,
	input select
);

	wire not_select;
	wire and_gate_0, and_gate_1;
	
	not not_gate(not_select, select);
	
	and and_gate0(and_gate_0, in0, not_select);
	and and_gate1(and_gate_1, in1, select);     
	
	or or_gate(out, and_gate_0, and_gate_1);

endmodule
