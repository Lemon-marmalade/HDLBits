module top_module();
	reg clk=0, in;
    reg [2:0] s;
    always begin
        #5;
        clk=~clk;
    end
    initial begin
        s=2;
        #10;
        s=6;
        #10;
        s=2;
        #10;
        s=7;
        #10;
        s=0;
    end
    initial begin //only one variable can change in one initial block
        in=0;
        #20;
		in=1;
        #10;
        in=0;
        #10;
        in=1;
        #30;
        in=0;
    end
    q7 inst(.clk(clk),.in(in),.s(s));
endmodule
