module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    wire[7:0] Q;
    wire[2:0] i;

    mydff instance1 (S,clk,enable,Q[0]);
    mydff instance2 (Q[0],clk,enable,Q[1]);
    mydff instance3 (Q[1],clk,enable,Q[2]);
    mydff instance4 (Q[2],clk,enable,Q[3]);
    mydff instance5 (Q[3],clk,enable,Q[4]);
    mydff instance6 (Q[4],clk,enable,Q[5]);
    mydff instance7 (Q[5],clk,enable,Q[6]);
    mydff instance8 (Q[6],clk,enable,Q[7]);
    
    assign i = {A,B,C};
    assign Z = Q[i];
endmodule

module mydff (input d, clk, enable, output q );
    always @(posedge clk)
        if (enable)
            q <= d;
endmodule