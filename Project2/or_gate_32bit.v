module or_gate_32bit(
	 output [31:0] result,
    input [31:0] A,
    input [31:0] B
    
);
    or_gate_1bit or0 (result[0], A[0], B[0]);
	or_gate_1bit or1 (result[1], A[1], B[1]);
	or_gate_1bit or2 (result[2], A[2], B[2]);
	or_gate_1bit or3 (result[3], A[3], B[3]);
	or_gate_1bit or4 (result[4], A[4], B[4]);
	or_gate_1bit or5 (result[5], A[5], B[5]);
	or_gate_1bit or6 (result[6], A[6], B[6]);
	or_gate_1bit or7 (result[7], A[7], B[7]);
	or_gate_1bit or8 (result[8], A[8], B[8]);
	or_gate_1bit or9 (result[9], A[9], B[9]);
	or_gate_1bit or10 (result[10], A[10], B[10]);
	or_gate_1bit or11 (result[11], A[11], B[11]);
	or_gate_1bit or12 (result[12], A[12], B[12]);
	or_gate_1bit or13 (result[13], A[13], B[13]);
	or_gate_1bit or14 (result[14], A[14], B[14]);
	or_gate_1bit or15 (result[15], A[15], B[15]);
	or_gate_1bit or16 (result[16], A[16], B[16]);
	or_gate_1bit or17 (result[17], A[17], B[17]);
	or_gate_1bit or18 (result[18], A[18], B[18]);
	or_gate_1bit or19 (result[19], A[19], B[19]);
	or_gate_1bit or20 (result[20], A[20], B[20]);
	or_gate_1bit or21 (result[21], A[21], B[21]);
	or_gate_1bit or22 (result[22], A[22], B[22]);
	or_gate_1bit or23 (result[23], A[23], B[23]);
	or_gate_1bit or24 (result[24], A[24], B[24]);
	or_gate_1bit or25 (result[25], A[25], B[25]);
	or_gate_1bit or26 (result[26], A[26], B[26]);
	or_gate_1bit or27 (result[27], A[27], B[27]);
	or_gate_1bit or28 (result[28], A[28], B[28]);
	or_gate_1bit or29 (result[29], A[29], B[29]);
	or_gate_1bit or30 (result[30], A[30], B[30]);
	or_gate_1bit or31 (result[31], A[31], B[31]);

endmodule
