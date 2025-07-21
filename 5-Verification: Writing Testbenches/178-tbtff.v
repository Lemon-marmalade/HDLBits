module top_module ();
    reg clk=0, reset, t;
    always begin
        #5;
        clk=~clk;
    end
    initial begin
        reset = 1;
        #6;
        reset = 0;
        t = 1;
    end
    
    tff inst(.clk(clk),.reset(reset),.t(t));
endmodule
