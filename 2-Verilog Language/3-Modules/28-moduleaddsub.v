module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire[15:0] wtop;
    wire wconnect;
    wire[31:16] wbottom;
    wire[31:0] wb;
    always @(*)
        begin
            case(sub)
                2'b0: wb = b;
                2'b1: wb = ~b;
            endcase
        end
    add16 instance1 (.a(a[15:0]),.b(wb[15:0]),.cin(sub),.sum(wtop),.cout(wconnect));
    add16 instance2 (.a(a[31:16]),.b(wb[31:16]),.cin(wconnect),.sum(wbottom));
    assign sum[15:0]=wtop;
    assign sum[31:16]=wbottom;    
endmodule

/* Clearer solution (second time trying)
module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire[31:0] bxorsub;
    wire cout;
    assign bxorsub = sub? ~b:b; // Can't actually use an XOR gate because of different sizing. Sub most likely gets padded with zeros, which doesn't products the desired effect
    add16 inst1 (a[15:0], bxorsub[15:0], sub, sum[15:0], cout);
    add16 inst2 (a[31:16], bxorsub[31:16], cout, sum[31:16]);

endmodule
*/
