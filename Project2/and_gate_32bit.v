module and_gate_32bit(
	 output [31:0] result,
    input [31:0] A,
    input [31:0] B
    
);
    and_gate_1bit and0 (result[0], A[0], B[0]);
	and_gate_1bit and1 (result[1], A[1], B[1]);
	and_gate_1bit and2 (result[2], A[2], B[2]);
	and_gate_1bit and3 (result[3], A[3], B[3]);
	and_gate_1bit and4 (result[4], A[4], B[4]);
	and_gate_1bit and5 (result[5], A[5], B[5]);
	and_gate_1bit and6 (result[6], A[6], B[6]);
	and_gate_1bit and7 (result[7], A[7], B[7]);
	and_gate_1bit and8 (result[8], A[8], B[8]);
	and_gate_1bit and9 (result[9], A[9], B[9]);
	and_gate_1bit and10 (result[10], A[10], B[10]);
	and_gate_1bit and11 (result[11], A[11], B[11]);
	and_gate_1bit and12 (result[12], A[12], B[12]);
	and_gate_1bit and13 (result[13], A[13], B[13]);
	and_gate_1bit and14 (result[14], A[14], B[14]);
	and_gate_1bit and15 (result[15], A[15], B[15]);
	and_gate_1bit and16 (result[16], A[16], B[16]);
	and_gate_1bit and17 (result[17], A[17], B[17]);
	and_gate_1bit and18 (result[18], A[18], B[18]);
	and_gate_1bit and19 (result[19], A[19], B[19]);
	and_gate_1bit and20 (result[20], A[20], B[20]);
	and_gate_1bit and21 (result[21], A[21], B[21]);
	and_gate_1bit and22 (result[22], A[22], B[22]);
	and_gate_1bit and23 (result[23], A[23], B[23]);
	and_gate_1bit and24 (result[24], A[24], B[24]);
	and_gate_1bit and25 (result[25], A[25], B[25]);
	and_gate_1bit and26 (result[26], A[26], B[26]);
	and_gate_1bit and27 (result[27], A[27], B[27]);
	and_gate_1bit and28 (result[28], A[28], B[28]);
	and_gate_1bit and29 (result[29], A[29], B[29]);
	and_gate_1bit and30 (result[30], A[30], B[30]);
	and_gate_1bit and31 (result[31], A[31], B[31]);

endmodule
