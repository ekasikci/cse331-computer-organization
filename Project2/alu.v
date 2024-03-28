module alu(
    input clk,
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUop,
    output [31:0] Result,
	 input reset
);

    wire [31:0] and_result, or_result, xor_result, nor_result, less_than_result, add_result, sub_result, mod_result;
    wire [31:0] mux_inputs[7:0];

    // Instantiate ALU operations
    and_gate_32bit and_gate_inst(.result(and_result), .A(A), .B(B));
    or_gate_32bit or_gate_inst(.result(or_result), .A(A), .B(B));
    xor_gate_32bit xor_gate_inst(.result(xor_result), .A(A), .B(B));
    nor_gate_32bit nor_gate_inst(.result(nor_result), .A(A), .B(B));
    less_than_32bit less_than_inst(.a(A), .b(B), .less_than_result(less_than_result));
    cla_adder_32bit adder_inst(.a(A), .b(B), .sum(add_result));
    subtractor_32bit subtractor_inst(.a(A), .b(B), .diff(sub_result));
    mod mod_inst(.clk(clk), .A(A), .B(B), .RESULT(mod_result), .reset(reset));

	 mux_8x1_32bit result_mux(Result, and_result, or_result, xor_result, nor_result, less_than_result, add_result, sub_result, mod_result, ALUop);

endmodule
