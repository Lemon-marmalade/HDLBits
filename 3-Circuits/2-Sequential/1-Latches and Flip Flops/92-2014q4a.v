module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
	wire mux2_0, d;
    assign mux2_0 = E? w:Q;
    assign d = L? R:mux2_0;
    always @ (posedge clk) begin
        Q <= d;
    end
endmodule