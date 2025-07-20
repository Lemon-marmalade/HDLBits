module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    

    muxdff instance1 (SW[0],KEY[0], KEY[1], LEDR[2], LEDR[0]);
    muxdff instance2 (SW[1],KEY[0], KEY[1], LEDR[0], LEDR[1]);
    muxdff instance3 (SW[2],KEY[0], KEY[1], (LEDR[1]^LEDR[2]), LEDR[2]);

endmodule
module muxdff (input R, clk, L, qq, output Q);
    always @ (posedge clk) begin
        case (L)
            1'b1: Q <= R;
            1'b0: Q <= qq;
        endcase
    end
endmodule
