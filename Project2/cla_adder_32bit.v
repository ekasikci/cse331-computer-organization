module cla_adder_32bit(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [7:1] carry; // Intermediate carry signals between 4-bit blocks
	 wire unused_carry;  // Internal wire for unused carry-out of the last CLA block
	 
    // Instantiate 4-bit CLA blocks
    cla_adder_4bit cla_block0(a[3:0], b[3:0], 1'b0, sum[3:0], carry[1]); 
    cla_adder_4bit cla_block1(a[7:4], b[7:4], carry[1], sum[7:4], carry[2]);
    cla_adder_4bit cla_block2(a[11:8], b[11:8], carry[2], sum[11:8], carry[3]);
    cla_adder_4bit cla_block3(a[15:12], b[15:12], carry[3], sum[15:12], carry[4]);
    cla_adder_4bit cla_block4(a[19:16], b[19:16], carry[4], sum[19:16], carry[5]);
    cla_adder_4bit cla_block5(a[23:20], b[23:20], carry[5], sum[23:20], carry[6]);
    cla_adder_4bit cla_block6(a[27:24], b[27:24], carry[6], sum[27:24], carry[7]);
    cla_adder_4bit cla_block7(a[31:28], b[31:28], carry[7], sum[31:28], unused_carry);

endmodule