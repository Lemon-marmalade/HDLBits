module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    reg [6:1] Y;
    parameter A=1, B=2, C=3, D=4, E=5, F=6;

    assign Y[A] = w & (y[A]|y[D]);
    assign Y[B] = ~w & y[A];
    assign Y[C] = ~w & (y[B]|y[F]);
    assign Y[D] = w & (y[B]|y[C]|y[E]|y[F]);
    assign Y[E] = ~w & (y[C]|y[E]);
    assign Y[F] = ~w & y[D];
    
    assign Y2 = Y[2];
    assign Y4 = Y[4];

endmodule

/* Much more concise version for what was asked

module top_module (
    input [6:1] y,
    input w,
    output Y2, // state B
    output Y4); // state D
    
    parameter A=6'b000001, B=6'b000010, C=6'b000100, D=6'b001000, E=6'b010000, F=6'b100000;
    
    assign Y2 = (y[1] & ~w);
    assign Y4 = (y[2] & w)|(y[3] & w)|(y[5] & w)|(y[6] & w);
endmodule

*/
