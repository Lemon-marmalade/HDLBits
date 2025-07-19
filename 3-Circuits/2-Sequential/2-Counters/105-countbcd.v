module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    integer i;
    
    assign ena[3] = (q[11:8]==9&q[7:4]==9)&(q[3:0]==9);
    assign ena[2] =(q[7:4]==9)&&(q[3:0]==9);
    assign ena[1] = (q[3:0]==9);
    decade_counter instance1 (clk, reset, 1, q[3:0]);
    decade_counter instance2 (clk, reset, ena[1], q[7:4]);
    decade_counter instance3 (clk, reset, ena[2], q[11:8]);
    decade_counter instance4 (clk, reset, ena[3], q[15:12]);

endmodule

module decade_counter (input clk,reset, ena, output [3:0] q);
    always @ (posedge clk) begin
        if (reset || (ena &&q==9))
            q <= 4'b0;
        else if (ena && q<9)
            q <= q + 4'h1;
        else
            q <= q;
    end
endmodule
