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

/* Slightly different format
module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q<=10'b0;
        else begin
            q<=(q>=10'd999)? 10'b0:(q+10'b1);
        end
    end

endmodule

*/
