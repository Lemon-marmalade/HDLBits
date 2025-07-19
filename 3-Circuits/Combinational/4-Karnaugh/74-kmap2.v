module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out = (~a&~d)|(c&d&(a|b))|(~b&~c); // SOP form
endmodule
