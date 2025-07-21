module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter START=0, MIDDLE=1, IDLE=2, DONE=3, ERROR=4;
    reg [3:0] state, next_state;
    reg prev_in;
    integer count_bit;
    
    // state transition
    always @ (*) begin
        case (state)
            START: next_state = MIDDLE;
            MIDDLE: next_state = (count_bit>=7)? (in? DONE:ERROR):MIDDLE;
            IDLE: next_state = in? IDLE:START;
            DONE: next_state = in? IDLE:START;
            ERROR: next_state = in? IDLE:ERROR;
            default: next_state = IDLE;
        endcase
    end
    // state flip flops and reset
    always @ (posedge clk)
        if (reset) begin
            state <= IDLE;
    		count_bit <= 0;
        end
    	else begin
            state <= next_state;
            prev_in <=in;
            if (state==MIDDLE)
                count_bit <= count_bit + 1;
            else
                count_bit <= 0;
            // New: Datapath to store incoming bytes.
            if (state != ERROR)
                out_byte[count_bit] <= prev_in;
        end
    // output
    assign done = (state==DONE);

endmodule