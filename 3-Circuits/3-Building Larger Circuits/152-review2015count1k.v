module top_module (
    input clk,
    input reset,
    output [9:0] q);
    integer count;
    
    always @ (posedge clk) begin
        if (reset || count==999)
            count <= 0;
        else
            count <= count + 1;
    end
	assign q = count;
endmodule
