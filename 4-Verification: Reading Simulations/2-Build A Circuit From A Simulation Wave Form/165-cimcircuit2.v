module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = (a&b&~c&~d)||(b&c&~d&~a)||(c&d&~a&~b)||(d&a&~b&~c)||(b&d&~a&~c)||(a&c&~b&~d)||(a&b&c&d)||(~a&~b&~c&~d);

endmodule

/* Much better version

module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
	// none, all, or in pairs of 2
    assign q = ~(a^b^c^d); // Fix me

endmodule

*/
