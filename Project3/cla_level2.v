module cla_level2(output[32:0]c,input[31:0] A, B, input c0);

or or1(c[0], c0, 1'b0);

cla_level1_4bit cla1(c[4:1], A[3:0], B[3:0], c[0]);
cla_level1_4bit cla2(c[8:5], A[7:4], B[7:4], c[4]);
cla_level1_4bit cla3(c[12:9], A[11:8], B[11:8], c[8]);
cla_level1_4bit cla4(c[16:13], A[15:12], B[15:12], c[12]);
cla_level1_4bit cla5(c[20:17], A[19:16], B[19:16], c[16]);
cla_level1_4bit cla6(c[24:21], A[23:20], B[23:20], c[20]);
cla_level1_4bit cla7(c[28:25], A[27:24], B[27:24], c[24]);
cla_level1_4bit cla8(c[32:29], A[31:28], B[31:28], c[28]);

endmodule
