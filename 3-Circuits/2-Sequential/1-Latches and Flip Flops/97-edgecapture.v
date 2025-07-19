module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg[31:0] last;
    
    always @ (posedge clk) begin
        if (reset) begin
            out <= 0;
        end
        else
            out <= out | (last & ~in);
        last <= in;
    end

endmodule