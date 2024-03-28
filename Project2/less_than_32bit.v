module less_than_32bit(
    input [31:0] a,
    input [31:0] b,
    output [31:0] less_than_result
);
    wire [31:0] sub_result;

    // Use the subtractor to subtract a from b
    subtractor_32bit subtractor_inst(
        .a(a), 
        .b(b), 
        .diff(sub_result)
    );

    or_gate_32bit my_or(less_than_result, 32'b0, {31'b0, sub_result[31]});
	 
endmodule
