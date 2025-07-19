module top_module (
    input clk,
    input d,
    output q
);
    reg p, n;
	
	// positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;
        
    //negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p;
    
    // after posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // after negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
    // at eachclock edge, p and n FFs alternate
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;

endmodule