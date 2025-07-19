`default_nettype none // this disables implicit nets to reduce some chance of bugs
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 

    assign out_n = ~((a & b) || (c & d));
    assign out = ((a & b) || (c & d));

endmodule