module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg[7:0] last;
    always @ (posedge clk) begin
        last <= in;
        anyedge <= last^in;
    end
        
endmodule


/* Different format

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg[7:0] previn;
    always @(posedge clk) begin
        previn<=in;
        anyedge<= (~previn & in) | (previn & ~in);
    end
    
endmodule

*/
