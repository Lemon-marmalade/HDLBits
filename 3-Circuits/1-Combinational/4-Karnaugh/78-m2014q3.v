module top_module (
    input [4:1] x, 
    output f );
    assign f = (~x[1]|~x[3])&(x[3]|x[1])&(x[3]|x[2]); // used POS for extra practice w it
endmodule

/* Practicing again with both SOP and POS

module top_module (
    input [4:1] x, 
    output f );
    // sop
    //assign f = (x[3]&~x[1]) | (x[2]&x[4]);
    //pos
    assign f = (x[3]|x[4]) & (~x[1]|x[2]) & (x[1]|x[3]) & (~x[1]|~x[3]);
endmodule

*/
