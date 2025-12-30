module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    integer i;
    always @ (posedge clk) begin
        if (load)
            q <= data;
        else begin
            q[0]<=q[0]^1'b0;
            q[511]<=q[511]|q[510];
            for (i=1;i<511;i=i+1)
                q[i]<=(q[i]|q[i-1])&&(q[i+1]==0 || q[i]==0 || q[i-1]==0);
        end
    end

endmodule

/* Redid this question while practicing my minimal POS
module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    always @(posedge clk) begin
        if (load)
            q<=data;
        else begin
            int i;
            //From kmap (POS): left|center & ~left|~center|~right

            
            // edge cases
            q[0]<=(1'b0|q[0]) & (~1'b0|~q[0]|~q[1]);
            q[511]<=(q[510]|q[511]) & (~q[510]|~q[511]|~1'b0);
            
            for (i=1;i<511;i++) begin
                q[i]<=(q[i-1]|q[i]) & (~q[i-1]|~q[i]|~q[i+1]);
            end
        end
    end

endmodule
*/
