module memory_block (
	output reg [31:0] read_data, 
	input 				byteOperations, 
	input [17:0] 		address, 
	input [31:0]		write_data, 
	input 				memRead, 
	input 				memWrite
);

    reg [7:0] memory [127:0];	

    initial begin
        $readmemb("memory.mem", memory);
		  read_data = 32'b0;
    end


    always @(*) begin
		if(memRead && byteOperations) begin
			read_data <= memory[address];
		end
		else if(memRead && address+3 < 128) begin
			read_data[31:24] <= memory[address+3];
			read_data[23:16] <= memory[address+2];
			read_data[15:8] <= memory[address+1];
			read_data[7:0] <= memory[address];
			$display("memory read_data word: %32b	address: %18b",read_data,address);
		end
    end
	 
    always @(*) begin
		 if(memWrite && byteOperations) begin
			memory[address] <= write_data[7:0];
			#1
			$writememb("memory.mem", memory);
		 end
		 else if(memWrite && address+3 < 128) begin			
			memory[address+3] <= write_data[31:24];
			memory[address+2] <= write_data[23:16];
			memory[address+1] <= write_data[15:8];
			memory[address] <= write_data[7:0];
			#1
			$writememb("memory.mem", memory);
		 end
    end

endmodule
