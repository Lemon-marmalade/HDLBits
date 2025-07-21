module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter START=0, MIDDLE=1, IDLE=2, DONE=3, ERROR=4;
    reg [3:0] state, next_state;
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
            if (state==MIDDLE)
                count_bit <= count_bit + 1;
            else
                count_bit <= 0;
        end
    // output
    assign done = (state==DONE);

endmodule
