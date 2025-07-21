module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] count;
    always @ (posedge clk) begin
        if (load)
            count <= data;
        else if (count != 0)
            count <= count - 1'b1;
        else
            count <= 0;
    end
    assign tc = (count==0);

endmodule
