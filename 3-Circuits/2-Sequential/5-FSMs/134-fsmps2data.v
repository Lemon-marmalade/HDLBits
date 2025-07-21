module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
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
        // New: Datapath to store incoming bytes.
        case (next_state)
            b2: out_bytes[23:16] <= in; //for b1
            b3: out_bytes[15:8] <= in; //for b2
            DONE: out_bytes[7:0] <= in; //for b3
        endcase
    end
    // Output logic
    assign done = (state==DONE);

endmodule