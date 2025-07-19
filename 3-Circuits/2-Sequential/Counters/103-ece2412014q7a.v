module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    count4 the_counter (clk, c_enable, c_load, c_d);
    always @ (posedge clk) begin
        if (reset || (enable&&Q==12))
            Q <= 4'b1;
        else
            if (enable)
                Q <= Q +4'b1;
    end
    assign c_enable = enable;
    assign c_load = reset || (enable&&Q==12);
    assign c_d = c_load? 4'b1:4'b0;

 

endmodule