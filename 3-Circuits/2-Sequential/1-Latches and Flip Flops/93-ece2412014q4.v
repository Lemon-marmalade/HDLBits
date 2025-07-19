module top_module (
    input clk,
    input x,
    output z
); 
    wire q1, q2, q3;
    
    always @(posedge clk) begin
        q1 <= q1 ^ x;
        q2 <= ~q2 & x;
        q3 <= ~q3 | x;
    end
    assign z = ~(q1 | q2 | q3); 
        
endmodule