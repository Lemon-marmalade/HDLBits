module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
	parameter GO=0, MIDDLE=1, IDLE=2, DONE=3, ERROR=4, PAR=5;
    reg [3:0] state, next_state;
    reg odd;
    integer count_bit;
    
    // New: Add parity checking.
    parity instances (.clk(clk), .reset(reset||(state==ERROR)||(state==IDLE)), .in(in), .odd(odd));
    
    // state transition
    always @ (*) begin
        case (state)
            GO: next_state = (count_bit==9 && in == ~odd)? PAR:(count_bit==9 && ~(in==~odd))? ERROR:GO;
            PAR: next_state = in? DONE:ERROR;
            IDLE: next_state = in? IDLE:GO;
            DONE: next_state = in? IDLE:GO;
            ERROR: next_state = in? IDLE:ERROR;
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
            if (next_state==GO)
                count_bit <= count_bit + 1;
                            // datapath to store incoming bytes.
            else
                count_bit <= 0;
            out_byte[count_bit-1] = in;

        end
    // output
    assign done = (state==DONE);
            
endmodule

