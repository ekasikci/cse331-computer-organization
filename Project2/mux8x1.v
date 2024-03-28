module mux8x1 #(parameter WIDTH = 32) (
    input [2:0] sel,
    input [WIDTH-1:0] in0, in1, in2, in3, in4, in5, in6, in7,
    output [WIDTH-1:0] out
);

wire [7:0] decoder_out;
wire [WIDTH-1:0] gated_outputs[7:0];

// 3-bit decoder
decoder_3_to_8 decoder_inst (
    .sel(sel),
    .out(decoder_out)
);

// Gating each input line
generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin : gate_loop
        and(gated_outputs[0][i], in0[i], decoder_out[0]);
        and(gated_outputs[1][i], in1[i], decoder_out[1]);
        and(gated_outputs[2][i], in2[i], decoder_out[2]);
        and(gated_outputs[3][i], in3[i], decoder_out[3]);
        and(gated_outputs[4][i], in4[i], decoder_out[4]);
        and(gated_outputs[5][i], in5[i], decoder_out[5]);
        and(gated_outputs[6][i], in6[i], decoder_out[6]);
        and(gated_outputs[7][i], in7[i], decoder_out[7]);

        // Combining the gated outputs
        or(out[i], gated_outputs[0][i], gated_outputs[1][i], gated_outputs[2][i], gated_outputs[3][i],
                gated_outputs[4][i], gated_outputs[5][i], gated_outputs[6][i], gated_outputs[7][i]);
    end
endgenerate

endmodule

// 3-to-8 line decoder module
module decoder_3_to_8(
    input [2:0] sel,
    output [7:0] out
);

wire [2:0] not_sel;

// Inverting sel bits
not (not_sel[0], sel[0]);
not (not_sel[1], sel[1]);
not (not_sel[2], sel[2]);

// Generating decoder outputs
and (out[0], not_sel[2], not_sel[1], not_sel[0]);
and (out[1], not_sel[2], not_sel[1], sel[0]);
and (out[2], not_sel[2], sel[1], not_sel[0]);
and (out[3], not_sel[2], sel[1], sel[0]);
and (out[4], sel[2], not_sel[1], not_sel[0]);
and (out[5], sel[2], not_sel[1], sel[0]);
and (out[6], sel[2], sel[1], not_sel[0]);
and (out[7], sel[2], sel[1], sel[0]);

endmodule
