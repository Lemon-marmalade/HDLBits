module top_module (input x, input y, output z);
    wire w1, w2, w3, w4;
    mod_a instancea1 (x,y,w1);
    mod_b instanceb1 (x,y,w2);
    mod_a instancea2 (x,y,w3);
    mod_b instanceb2 (x,y,w4);
    assign z = (w1|w2)^(w3&w4);
endmodule

module mod_a (input x, input y, output z);
    assign z = (x^y)&x;
endmodule
module mod_b(input x, input y, output z);
	assign z = ~(x^y);
endmodule
