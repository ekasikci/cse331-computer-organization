module or_gate_4bit(
	output [3:0] result,
	input [3:0] A,
	input [3:0] B
    
);
	or_gate_1bit or0 (result[0], A[0], B[0]);
	or_gate_1bit or1 (result[1], A[1], B[1]);
	or_gate_1bit or2 (result[2], A[2], B[2]);
	or_gate_1bit or3 (result[3], A[3], B[3]);
	
endmodule
