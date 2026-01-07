module top_module (
    input clk,
    input a,
    output [3:0] q );
    always @ (posedge clk) begin
        if (a)
            q <= 4;
        else begin
            if (q==6)
                q <= 0;
            else
                q <= q+1;
   		end
    end

endmodule

/* More concise version with ternary operator

module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    always @(posedge clk)
        q<= a? 4'd4:(q==6? 4'b0:q+4'b1);
        
endmodule

*/
