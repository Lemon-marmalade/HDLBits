module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = ~(~a&~b)&&~(~c&~d);

endmodule

/* Version with much clearer logic

module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
	// b with c or d, a with c or d, b and a can only be together if not alone
    assign q = (a|b)&(c|d); // Fix me

endmodule

*/
