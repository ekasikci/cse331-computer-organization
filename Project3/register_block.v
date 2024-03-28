module register_block (
	output [31:0] read_data1,
	output [31:0] read_data2,
	input 				byteOperations,
	input [31:0] 		write_data,
	input [4:0] 		read_reg1,
	input [4:0]			read_reg2,
	input [4:0]			write_reg,
	input 				regWrite	
);

    reg [31:0] registers [31:0];

    initial begin
        $readmemb("registers.mem", registers);
    end

    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    always @(*) begin
		if(regWrite && write_reg != 5'b0) begin
        registers[write_reg] <= write_data;
		  $writememb("registers.mem", registers);
		 end
    end

	
	// Additional logic for byteOperations
	// Depending on the specific requirements of byteOperations,
	// you might need to implement logic to handle byte-wise read/write operations

endmodule