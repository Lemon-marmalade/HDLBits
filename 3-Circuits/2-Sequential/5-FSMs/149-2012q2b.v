module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    reg [5:0] Y;
    parameter A=0,B=1,C=2,D=3,E=4,F=5;
    
    assign Y[A] = ~w & (y[A]|y[D]);
    assign Y[B] = w & y[A];
    assign Y[C] = w & (y[B]|y[F]);
    assign Y[D] = ~w & (y[B]|y[C]|y[E]|y[F]);
    assign Y[E] = w & (y[C]|y[E]);
    assign Y[F] = w & y[D];
    
    assign Y1 = Y[1];
    assign Y3 = Y[3];

endmodule
