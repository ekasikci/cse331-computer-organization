module subtractor_32bit(
    input [31:0] a,
    input [31:0] b,
    output [31:0] diff
);
    wire [31:0] b_inverted;
    wire [31:0] add_one_result;

    // Structural NOT Gates for B Inversion
    not invert_b_0(b_inverted[0], b[0]);
    not invert_b_1(b_inverted[1], b[1]);
    not invert_b_2(b_inverted[2], b[2]);
    not invert_b_3(b_inverted[3], b[3]);
    not invert_b_4(b_inverted[4], b[4]);
    not invert_b_5(b_inverted[5], b[5]);
    not invert_b_6(b_inverted[6], b[6]);
    not invert_b_7(b_inverted[7], b[7]);
    not invert_b_8(b_inverted[8], b[8]);
    not invert_b_9(b_inverted[9], b[9]);
    not invert_b_10(b_inverted[10], b[10]);
    not invert_b_11(b_inverted[11], b[11]);
    not invert_b_12(b_inverted[12], b[12]);
    not invert_b_13(b_inverted[13], b[13]);
    not invert_b_14(b_inverted[14], b[14]);
    not invert_b_15(b_inverted[15], b[15]);
    not invert_b_16(b_inverted[16], b[16]);
    not invert_b_17(b_inverted[17], b[17]);
    not invert_b_18(b_inverted[18], b[18]);
    not invert_b_19(b_inverted[19], b[19]);
    not invert_b_20(b_inverted[20], b[20]);
    not invert_b_21(b_inverted[21], b[21]);
    not invert_b_22(b_inverted[22], b[22]);
    not invert_b_23(b_inverted[23], b[23]);
    not invert_b_24(b_inverted[24], b[24]);
    not invert_b_25(b_inverted[25], b[25]);
    not invert_b_26(b_inverted[26], b[26]);
    not invert_b_27(b_inverted[27], b[27]);
    not invert_b_28(b_inverted[28], b[28]);
    not invert_b_29(b_inverted[29], b[29]);
    not invert_b_30(b_inverted[30], b[30]);
    not invert_b_31(b_inverted[31], b[31]);

    // Add 1 to the inverted B using CLA adder
    cla_adder_32bit add_one_to_inverted_b(
        .a(b_inverted), 
        .b(32'b1), 
        .sum(add_one_result)
    );

    // Add A to the two's complement of B using CLA adder
    cla_adder_32bit perform_subtraction(
        .a(a),
        .b(add_one_result),
        .sum(diff)
    );
endmodule

