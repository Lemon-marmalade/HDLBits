module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire wconnect;
    wire[15:0] wtop;
    wire[31:16] wbottom;
    add16 instance1 (.a(a[15:0]),.b(b[15:0]),.sum(wtop), .cin(0),.cout(wconnect));
    add16 instance2(.a(a[31:16]),.b(b[31:16]),.sum(wbottom),.cin(wconnect));
    assign sum[15:0]=wtop;
    assign sum[31:16]=wbottom;
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
// Full adder module here
    assign {cout, sum} = a + b + cin;
endmodule

/* newer solution for practice and fuller explanation
module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout;
    add16 inst1 (a[15:0], b[15:0], 0, sum[15:0], cout);
    add16 inst2 (a[31:16], b[31:16], cout, sum[31:16]);

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
// Full adder module here
    wire [1:0] w = a+b+cin;
    assign sum = w[0]; // last binary digit
    assign cout = w[1]; // if sum ends up taking up 2 digits

endmodule
*/
