module testbench;

reg clk;
reg [31:0] A, B;
reg [2:0] ALUop;
wire [31:0] Result;
reg reset;

alu myALU(
    .clk(clk),
    .A(A),
    .B(B),
    .ALUop(ALUop),
    .Result(Result),
	 .reset (reset)
);

initial clk = 0;
always #1 clk = ~clk;

initial begin
    A = 0;
    B = 0;
    ALUop = 0;
	 
    // Test AND operation
    A = 32'hFFFFFFFF;  
    B = 32'hAAAAAAAA;  
    ALUop = 3'b000;    
    #10;               
    $display("AND Test: A = %h, B = %h, Result = %h", A, B, Result);

    // Test OR operation
    A = 32'h55555555;  
    B = 32'hAAAAAAAA;  
    ALUop = 3'b001;    
    #10;
    $display("OR Test: A = %h, B = %h, Result = %h", A, B, Result);

    // Test XOR operation
    A = 32'h55555555;  
    B = 32'hAAAAAAAA;  
    ALUop = 3'b010;   
    #10;
    $display("XOR Test: A = %h, B = %h, Result = %h", A, B, Result);

    // Test NOR operation
    A = 32'h0;         
    B = 32'h0;         
    ALUop = 3'b011;    
    #10;
    $display("NOR Test: A = %h, B = %h, Result = %h", A, B, Result);
	 
		

    // Test ADD operation
    A = 32'h12345678;  
    B = 32'h87654321;  
    ALUop = 3'b101;   
    #10;
    $display("ADD Test: A = %h, B = %h, Result = %h", A, B, Result);

    // Additional ADD tests with different scenarios
        // Test ADD operation with overflow
    A = 32'hFFFFFFFF;  
    B = 32'h1;         
    ALUop = 3'b101;    
    #10;
    $display("ADD Overflow Test: A = %h, B = %h, Result = %h", A, B, Result);

    // Test ADD operation with zero
    A = 32'h12345678;  
    B = 32'h0;         
    ALUop = 3'b101;    
    #10;
    $display("ADD Zero Test: A = %h, B = %h, Result = %h", A, B, Result);
	 
	 // Test SUB operation - Simple case
    A = 32'h5;  
    B = 32'h3;  
    ALUop = 3'b110;    
    #10;
    $display("SUB Test (Simple): A = %h, B = %h, Result = %h", A, B, Result);

    // Test SUB operation - Underflow
    A = 32'h0;
    B = 32'h1;
    ALUop = 3'b110;    
    #10;
    $display("SUB Test (Underflow): A = %h, B = %h, Result = %h", A, B, Result);

    // Test SUB operation - Large numbers
    A = 32'h12345678;
    B = 32'h87654321;
    ALUop = 3'b110;    
    #10;
    $display("SUB Test (Large Numbers): A = %h, B = %h, Result = %h", A, B, Result);
	 
	 // Test LESS THAN operation - A Less Than B
    A = 32'd10;  
    B = 32'd20;  
    ALUop = 3'b100;    
    #10;
    $display("LESS THAN Test (A < B): A = %h, B = %h, Result = %h", A, B, Result);

    // Test LESS THAN operation - A Greater Than B
    A = 32'd25;  
    B = 32'd15;  
    ALUop = 3'b100;    
    #10;
    $display("LESS THAN Test (A > B): A = %h, B = %h, Result = %h", A, B, Result);

    // Test LESS THAN operation - A Equals B
    A = 32'd30;  
    B = 32'd30;  
    ALUop = 3'b100;    
    #10;
    $display("LESS THAN Test (A == B): A = %h, B = %h, Result = %h", A, B, Result);

	 
	 // Test MOD Operation - Basic Case
	 A = 32'h22; 
	 B = 32'h4;   
	 ALUop = 3'b111;    
	 reset = 1'b1;
	 #5
	 reset = 1'b0;
	 #300; 
	 $display("MOD Test (Basic): A = %h, B = %h, Result = %h", A, B, Result);

	 
	 // Test MOD Operation - Basic
    A = 32'h6; 
	 B = 32'h10;  
    ALUop = 3'b111;    
	 reset = 1'b1;
	 #5
	 reset = 1'b0;
    #300;
    $display("MOD Test (Basic): A = %h, B = %h, Result = %h", A, B, Result);

 
    $finish;
end

endmodule
