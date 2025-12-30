module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    wire [3:0] Q;
    assign out = Q[0];
    
    always @ (posedge clk) begin
        if (~resetn) // low reset
            Q <= 4'b0;
        else
            Q <= {in, Q[3:1]};
    end

endmodule

/* Found more concise way

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire[2:0] Q;
    
    always @(posedge clk) begin
        if (~resetn)
        	{Q,out}<=0;
        else begin
            {Q,out}<={in,Q};
        end
    end

endmodule

*/
