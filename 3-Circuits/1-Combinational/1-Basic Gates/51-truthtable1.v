module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    assign f = (x3==0 & x2==1 & x1==0)|(x3==0 & x2==1 & x1==1)|(x3==1 & x2==0&x1==1)|(x3==1 & x2==1 & x1==1);
endmodule