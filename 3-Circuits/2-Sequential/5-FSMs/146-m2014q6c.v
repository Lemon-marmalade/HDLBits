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
