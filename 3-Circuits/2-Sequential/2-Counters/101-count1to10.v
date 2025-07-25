module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @ (posedge clk) begin
        if (reset||q==10)
            q <= 4'b1;
        else
            q <= q+4'b1;
    end
endmodule
