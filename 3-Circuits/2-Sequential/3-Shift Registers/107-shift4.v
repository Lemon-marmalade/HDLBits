module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0;
        end
        else
        	if (load)
            	q[3:0] <= data[3:0];
        	else
            	if (ena) begin
                    q[3] <= 1'b0; // a little repetitive, can use concatenate operator
                    q[2] <= q[3];
                    q[1] <= q[2];
                    q[0] <= q[1];
            	end
                else
                    q <= q;
    end

endmodule