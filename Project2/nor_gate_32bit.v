module nor_gate_32bit(
	 output [31:0] result,
    input [31:0] A,
    input [31:0] B
    
);
    nor_gate_1bit nor0 (result[0], A[0], B[0]);
	nor_gate_1bit nor1 (result[1], A[1], B[1]);
	nor_gate_1bit nor2 (result[2], A[2], B[2]);
	nor_gate_1bit nor3 (result[3], A[3], B[3]);
	nor_gate_1bit nor4 (result[4], A[4], B[4]);
	nor_gate_1bit nor5 (result[5], A[5], B[5]);
	nor_gate_1bit nor6 (result[6], A[6], B[6]);
	nor_gate_1bit nor7 (result[7], A[7], B[7]);
	nor_gate_1bit nor8 (result[8], A[8], B[8]);
	nor_gate_1bit nor9 (result[9], A[9], B[9]);
	nor_gate_1bit nor10 (result[10], A[10], B[10]);
	nor_gate_1bit nor11 (result[11], A[11], B[11]);
	nor_gate_1bit nor12 (result[12], A[12], B[12]);
	nor_gate_1bit nor13 (result[13], A[13], B[13]);
	nor_gate_1bit nor14 (result[14], A[14], B[14]);
	nor_gate_1bit nor15 (result[15], A[15], B[15]);
	nor_gate_1bit nor16 (result[16], A[16], B[16]);
	nor_gate_1bit nor17 (result[17], A[17], B[17]);
	nor_gate_1bit nor18 (result[18], A[18], B[18]);
	nor_gate_1bit nor19 (result[19], A[19], B[19]);
	nor_gate_1bit nor20 (result[20], A[20], B[20]);
	nor_gate_1bit nor21 (result[21], A[21], B[21]);
	nor_gate_1bit nor22 (result[22], A[22], B[22]);
	nor_gate_1bit nor23 (result[23], A[23], B[23]);
	nor_gate_1bit nor24 (result[24], A[24], B[24]);
	nor_gate_1bit nor25 (result[25], A[25], B[25]);
	nor_gate_1bit nor26 (result[26], A[26], B[26]);
	nor_gate_1bit nor27 (result[27], A[27], B[27]);
	nor_gate_1bit nor28 (result[28], A[28], B[28]);
	nor_gate_1bit nor29 (result[29], A[29], B[29]);
	nor_gate_1bit nor30 (result[30], A[30], B[30]);
	nor_gate_1bit nor31 (result[31], A[31], B[31]);

endmodule
