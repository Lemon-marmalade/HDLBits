module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    reg [1:0] state, next_state;
	parameter b1=0, b2=1, b3=2, DONE=3;
    // State transition logic (combinational)
    always @ (*) begin
        case (state)
            b1: next_state = in[3]? b2:b1;
            b2: next_state = b3;
            b3: next_state = DONE;
            DONE: next_state = in[3]? b2:b1;
        endcase
    end
    // State flip-flops (sequential)
    always @ (posedge clk) begin
        if (reset)
            state <=b1;
        else
        	state <= next_state;
    end
    // Output logic
    assign done = (state==DONE);

endmodule
