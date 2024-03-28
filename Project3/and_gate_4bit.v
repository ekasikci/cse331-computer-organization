module and_gate_4bit(
	output [3:0] result,
	input [3:0] A,
	input [3:0] B
    
);
	and_gate_1bit and0 (result[0], A[0], B[0]);
	and_gate_1bit and1 (result[1], A[1], B[1]);
	and_gate_1bit and2 (result[2], A[2], B[2]);
	and_gate_1bit and3 (result[3], A[3], B[3]);
	
endmodule
