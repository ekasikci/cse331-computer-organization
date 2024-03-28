module xor_gate_32bit(
	 output [31:0] result,
    input [31:0] A,
    input [31:0] B
    
);
    xor_gate_1bit xor0 (result[0], A[0], B[0]);
	xor_gate_1bit xor1 (result[1], A[1], B[1]);
	xor_gate_1bit xor2 (result[2], A[2], B[2]);
	xor_gate_1bit xor3 (result[3], A[3], B[3]);
	xor_gate_1bit xor4 (result[4], A[4], B[4]);
	xor_gate_1bit xor5 (result[5], A[5], B[5]);
	xor_gate_1bit xor6 (result[6], A[6], B[6]);
	xor_gate_1bit xor7 (result[7], A[7], B[7]);
	xor_gate_1bit xor8 (result[8], A[8], B[8]);
	xor_gate_1bit xor9 (result[9], A[9], B[9]);
	xor_gate_1bit xor10 (result[10], A[10], B[10]);
	xor_gate_1bit xor11 (result[11], A[11], B[11]);
	xor_gate_1bit xor12 (result[12], A[12], B[12]);
	xor_gate_1bit xor13 (result[13], A[13], B[13]);
	xor_gate_1bit xor14 (result[14], A[14], B[14]);
	xor_gate_1bit xor15 (result[15], A[15], B[15]);
	xor_gate_1bit xor16 (result[16], A[16], B[16]);
	xor_gate_1bit xor17 (result[17], A[17], B[17]);
	xor_gate_1bit xor18 (result[18], A[18], B[18]);
	xor_gate_1bit xor19 (result[19], A[19], B[19]);
	xor_gate_1bit xor20 (result[20], A[20], B[20]);
	xor_gate_1bit xor21 (result[21], A[21], B[21]);
	xor_gate_1bit xor22 (result[22], A[22], B[22]);
	xor_gate_1bit xor23 (result[23], A[23], B[23]);
	xor_gate_1bit xor24 (result[24], A[24], B[24]);
	xor_gate_1bit xor25 (result[25], A[25], B[25]);
	xor_gate_1bit xor26 (result[26], A[26], B[26]);
	xor_gate_1bit xor27 (result[27], A[27], B[27]);
	xor_gate_1bit xor28 (result[28], A[28], B[28]);
	xor_gate_1bit xor29 (result[29], A[29], B[29]);
	xor_gate_1bit xor30 (result[30], A[30], B[30]);
	xor_gate_1bit xor31 (result[31], A[31], B[31]);

endmodule
