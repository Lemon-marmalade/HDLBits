module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a + b;
    always @(*) begin
        if ((a[7]==b[7])& a[7]!=s[7])
            overflow = 1;
        else
            overflow = 0;
    end
endmodule

/* Version with full adder and comparing cin and cout

module top_module (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] c;   // Carry chain

    // Bit 0 (LSB)
    FA fa0 (a[0], b[0], 1'b0, s[0], c[0]);

    genvar i;
    generate
        for (i = 1; i < 8; i = i + 1) begin : fa_chain
            FA fai (a[i], b[i], c[i-1], s[i], c[i]);
        end
    endgenerate

    // Signed overflow
    assign overflow = c[6] ^ c[7];

endmodule

module FA (
    input  a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

*/

/* Using logic gates
module top_module (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output overflow
);

	assign s = a+b;
    // Signed overflow: same as if (a[7]==b[7] & a[7]!=s[7])
    assign overflow = (~a[7]^b[7])&(s[7]^a[7]);

endmodule
*/
