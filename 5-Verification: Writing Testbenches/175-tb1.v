module top_module ( output reg A, output reg B );//

    // generate input patterns here
    initial begin
		A=0;
        B=0;
        #10;
        A=1;
        #5;
        B=1;
        #5;
        A=0;
        #20;
        B=0;
    end

endmodule

/* Revisited version with fewer lines

module top_module ( output reg A, output reg B );//

    // generate input patterns here
    initial begin
        A=0; B=0;
		#10 A=1;
        #5 B=1;
        #5 A=0;
        #20 B=0; // Delays don't need semicolons
    end

endmodule

*/
