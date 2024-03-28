module full_adder_4bit (output [3:0] sum, input [3:0] A, input [3:0] B, input[3:0] c);

	// a:		a3 a2 a1 a0
	// b:		b3 b2 b1 b0
	// sum:	s3 s2 s1 s0
	full_adder_1bit fa1(sum[0], A[0], B[0], c[0]);
	full_adder_1bit fa2(sum[1], A[1], B[1], c[1]);
	full_adder_1bit fa3(sum[2], A[2], B[2], c[2]);
	full_adder_1bit fa4(sum[3], A[3], B[3], c[3]);
	
endmodule
