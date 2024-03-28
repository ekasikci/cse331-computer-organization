module shift_left_2(
    output [31:0] shifted_address,
    input [31:0] 	address
);

    // Connect each input bit to the output bit shifted left by 2 positions
    or (shifted_address[31], address[29]);
    or (shifted_address[30], address[28]);
    or (shifted_address[29], address[27]);
    or (shifted_address[28], address[26]);
    or (shifted_address[27], address[25]);
    or (shifted_address[26], address[24]);
    or (shifted_address[25], address[23]);
    or (shifted_address[24], address[22]);
    or (shifted_address[23], address[21]);
    or (shifted_address[22], address[20]);
    or (shifted_address[21], address[19]);
    or (shifted_address[20], address[18]);
    or (shifted_address[19], address[17]);
    or (shifted_address[18], address[16]);
    or (shifted_address[17], address[15]);
    or (shifted_address[16], address[14]);
    or (shifted_address[15], address[13]);
    or (shifted_address[14], address[12]);
    or (shifted_address[13], address[11]);
    or (shifted_address[12], address[10]);
    or (shifted_address[11], address[9]);
    or (shifted_address[10], address[8]);
    or (shifted_address[9], address[7]);
    or (shifted_address[8], address[6]);
    or (shifted_address[7], address[5]);
    or (shifted_address[6], address[4]);
    or (shifted_address[5], address[3]);
    or (shifted_address[4], address[2]);
    or (shifted_address[3], address[1]);
    or (shifted_address[2], address[0]);

    // The lowest two bits are zero
    or (shifted_address[1], 1'b0);
    or (shifted_address[0], 1'b0);

endmodule
