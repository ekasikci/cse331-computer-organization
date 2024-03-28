module adder_32bit(output[31:0] out, input[31:0] A, B,input c0,output cout);
	wire[32:0] c;
	
	cla_level2 cla1(c[32:0],A,B,c0);
	
	full_adder_4bit fa1(out[3:0], A[3:0], B[3:0], c[3:0]);
	full_adder_4bit fa2(out[7:4] , A[7:4] , B[7:4] , c[7:4]);
	full_adder_4bit fa3(out[11:8], A[11:8], B[11:8], c[11:8]);
	full_adder_4bit fa4(out[15:12], A[15:12], B[15:12], c[15:12]);
	full_adder_4bit fa5(out[19:16], A[19:16], B[19:16], c[19:16]);
	full_adder_4bit fa6(out[23:20], A[23:20], B[23:20], c[23:20]);
	full_adder_4bit fa7(out[27:24], A[27:24], B[27:24], c[27:24]);
	full_adder_4bit fa8(out[31:28], A[31:28], B[31:28], c[31:28]);
	
	or or1(cout,c[32],1'b0);

endmodule
