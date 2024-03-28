module testbench;

    reg clock;
    mips mips_inst(
        .clock(clock)
    );

    initial begin
        clock = 0;
        forever #10 clock = ~clock; 
    end

    initial begin
        #100; 
        $finish;
    end

endmodule
