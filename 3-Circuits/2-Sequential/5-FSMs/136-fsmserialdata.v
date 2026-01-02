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

/* reduced-state version with data output
module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    parameter IDLE=0, DATA=1, STOP=2, ERROR=3;
    reg [1:0] state, next_state;
    integer bitcount=0;
    always @(*) begin
        case(state)
            IDLE: next_state = in? IDLE:DATA;
            DATA: next_state = (bitcount>=8)? (in? STOP:ERROR):DATA;
            STOP: next_state = in? IDLE:DATA;
            ERROR: next_state = in? IDLE:ERROR;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state<=IDLE;
            bitcount<=0;
        end
        else begin
            state<=next_state;
            if (state==DATA) begin
                // New: Datapath to latch input bits.
                out_byte[bitcount]<=in;
                bitcount<=bitcount+1;
            end
            else
                bitcount<=0;
        end
    end
    assign done = (state==STOP);


endmodule
*/
