module mod_dp(
    input [31:0] A,
    input [31:0] B,
    input clk,
    input subtract_enable,
    input reset,
    output reg lt,
	 output reg [31:0] RESULT
);

	 reg [31:0] TEMP;

    always @(posedge clk) begin
        if (reset) begin
            TEMP <= A;
            lt <= 0;
        end else if (subtract_enable) begin
            if (TEMP >= B) begin
                TEMP <= TEMP - B;
                lt <= 0;
            end else begin
                lt <= 1;
            end
        end else begin
            RESULT <= TEMP;
        end
    end

endmodule
