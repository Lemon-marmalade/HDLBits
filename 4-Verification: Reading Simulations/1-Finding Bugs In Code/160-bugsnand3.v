module top_module (input a, input b, input c, output out);//
	wire temp;
    andgate inst1 ( .out(temp), .a(a), .b(b), .c(c), .d(1), .e(1) );
    assign out = ~temp;

endmodule