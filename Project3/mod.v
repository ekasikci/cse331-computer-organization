module mod(
	input clk,
	input [31:0] A,
	input [31:0] B,
	input reset,
	output [31:0] Result
);  

	wire lt, subtract_enable;
	
	mod_dp datapath (.A(A), .B(B), .clk(clk), .subtract_enable(subtract_enable), .lt(lt), .reset(reset), .RESULT(Result));
	mod_cu control_unit (.clk(clk), .lt(lt), .reset(reset), .subtract_enable(subtract_enable));
	
endmodule
