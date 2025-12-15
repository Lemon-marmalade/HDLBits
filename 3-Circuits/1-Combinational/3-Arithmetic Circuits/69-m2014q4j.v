module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire cout1, cout2, cout3;
    fadd instance1 (.x(x[0]),.y(y[0]), .cin(0), .cout(cout1), .sum(sum[0]));
    fadd instance2 (.x(x[1]),.y(y[1]), .cin(cout1), .cout(cout2), .sum(sum[1]));
    fadd instance3 (.x(x[2]),.y(y[2]), .cin(cout2), .cout(cout3), .sum(sum[2]));
    fadd instance4 (.x(x[3]),.y(y[3]), .cin(cout3), .cout(sum[4]), .sum(sum[3]));

endmodule
module fadd (input x, y, cin, output cout, sum);
    assign {cout,sum} = x+y+cin;
endmodule

/* using generate loop

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire cin[3:1];
    
    // First one is special
    FA u1(x[0],y[0],0,cin[1], sum[0]);
    
    genvar i;
    generate
        for (i=1; i<3; i++) begin: FAgenerate
            FA ui (x[i],y[i],cin[i],cin[i+1], sum[i]);
        end
    endgenerate
    // Last one is also special.. in hindsight, not much work is saved using generate
    FA i4(x[3],y[3],cin[3],sum[4], sum[3]);
endmodule

module FA( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a+b+cin;
endmodule

*/
