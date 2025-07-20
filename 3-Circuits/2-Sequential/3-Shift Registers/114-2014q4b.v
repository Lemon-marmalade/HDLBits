module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    wire w1,w2,w3,w4;
    MUXDFF instance1 (KEY[0], KEY[3], SW[3], KEY[1], KEY[2],w1);
    MUXDFF instance2 (KEY[0], w1, SW[2], KEY[1], KEY[2],w2);
    MUXDFF instance3 (KEY[0], w2, SW[1], KEY[1], KEY[2],w3);
    MUXDFF instance4 (KEY[0], w3, SW[0], KEY[1], KEY[2],w4);
    assign LEDR = {w1,w2,w3,w4};
endmodule

module MUXDFF (input clk, w, R, E, L, output Q);
	wire mux2_0, d;
    assign mux2_0 = E? w:Q;
    assign d = L? R:mux2_0;
    always @ (posedge clk) begin
        Q <= d;
    end
endmodule
