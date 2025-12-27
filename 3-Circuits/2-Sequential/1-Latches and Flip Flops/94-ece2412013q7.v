module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    always @ (posedge clk) begin
        if (~j&~k)
            Q <= Q;
        else if (~j&k)
            Q <= 0;
        else if (j&~k)
            Q <= 1;
        else
            Q <= ~Q;
    end

endmodule

/* Different structure second time around
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk) begin
        case({j,k})
            2'b01: Q<=1'b0;
            2'b10: Q<=1'b1;
            2'b11: Q<=~Q;
        endcase
    end
endmodule

*/
