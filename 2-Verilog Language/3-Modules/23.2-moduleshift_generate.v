module top_module ( input clk, input d, output q );
// Solution using generate for loop instead
    wire [3:0] w;
    genvar i;
    assign w[0]=d;
    generate
        for (i = 0; i < 3; i = i + 1) begin : dff_chain // Must name as something
            my_dff inst (clk, w[i], w[i+1]);
        end
    endgenerate
    assign q = w[3];
endmodule