module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    
    always @ (posedge clk) begin
        if (shift_ena) begin
            q <= q<<1;
            if (data)
                q[0] <= data;
        end
        else if (count_ena)
            q <= q - 1'b1;
    end


endmodule

/* More concise method with concatenation

module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (shift_ena)
            q<={q[2:0],data};
        else if (count_ena)
            q<=q-3'b1;
    end

endmodule

*/
