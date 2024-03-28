module mod_cu(
    input clk,
    input lt,
	 input reset, 
    output reg subtract_enable
);

    reg [1:0] state;
    localparam START = 2'b00, SUBTRACT = 2'b01, END = 2'b10;
	 
    
	 
    always @(posedge clk) begin
		  if (reset) begin
			state = START;
        end 
		  case (state)
            START: begin
                subtract_enable <= 0;
                state <= SUBTRACT;
            end
            SUBTRACT: begin
                if (lt) begin
                    subtract_enable <= 0;
                    state <= END;
                end else begin
                    subtract_enable <= 1;
                end
            end
            END: begin
            end
        endcase
    end
endmodule
