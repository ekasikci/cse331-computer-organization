module full_adder_1bit(output sum, input A, B, cin);
	wire a_xor_b;
	
	xor xor1 (a_xor_b, A, B);
	xor xor2 (sum, a_xor_b, cin);

endmodule
