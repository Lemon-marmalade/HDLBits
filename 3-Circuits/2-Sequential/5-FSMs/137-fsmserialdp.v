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

/* Edited parity check version

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
	parameter IDLE=0, DATA=1, PAR=2, STOP=3, ERROR=4;
    reg [2:0] state, next_state;
    integer bitcount=0;
    
    // New: Add parity checking.
    reg odd_parity;
    parity check(clk, (reset|state!=DATA), in, odd_parity);
    
    always @(*) begin
        case(state)
            IDLE: next_state = in? IDLE:DATA;
            DATA: next_state = (bitcount==8)? ((in == ~odd_parity)? PAR:ERROR):DATA; // 8th bit is parity bit. 
            //Parity bit is not the last bit, so it must make odd_parity false. 
            //However, parity module has not yet incorporated the new input bit at this stage so a manual comparison must be made.
            PAR: next_state = in? STOP:ERROR; // 9th bit is stop bit
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
