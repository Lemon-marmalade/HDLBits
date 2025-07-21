module top_module ( );
	reg clk = 0;
	always begin
        #5; // wait 5 cycles
        clk = ~ clk;
    end
    
    dut inst(clk) ;
endmodule