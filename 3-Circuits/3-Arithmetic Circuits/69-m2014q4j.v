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