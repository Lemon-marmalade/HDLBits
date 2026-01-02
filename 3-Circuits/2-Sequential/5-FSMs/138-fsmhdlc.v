module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter DISC=0, FLAG=1, ERR=2, DATA=3;
    reg[1:0] state, next_state;
    int one_count;
    
    // state transition logic
    always @ (*) begin
        case (state)
            DISC: next_state <= DATA;
            FLAG: next_state <= DATA;
            ERR: next_state = in? ERR:DATA;
            DATA: begin
                // remember to increment one
                if (one_count==5 && in==0)
                    next_state = DISC;
                else if (one_count==6 && in==0)
                    next_state = FLAG;
                else if (one_count==6 && in==1)
                    next_state = ERR;
                else
                    next_state = DATA;
            end
        endcase
    end
    // clocked dff & reset
    always @ (posedge clk) begin
        if (reset) begin
            state <= DATA;
            one_count <= 0;
        end
        else begin
            state <= next_state;
            if (in)
                one_count <= one_count + 1;
            else
            	one_count <= 0;
        end
    end
    // output
    assign disc = (state==DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERR);

endmodule

/* more proper moore state machine with better concision in output assignment

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter NONE=0, ONE=1, TWO=2, THREE=3, FOUR=4, FIVE=5, SIX=6, ERR=7, DISC=8, FLAG=9;
    reg [3:0] state, next_state;
    always @(*) begin
        case (state)
            NONE: next_state = in? ONE:NONE;
            ONE: next_state = in? TWO:NONE;
            TWO: next_state = in? THREE:NONE;
            THREE: next_state = in? FOUR:NONE;
            FOUR: next_state = in? FIVE:NONE;
            FIVE: next_state = in? SIX:DISC;
            SIX: next_state = in? ERR:FLAG;
            ERR: next_state = in? ERR:NONE;
            DISC: next_state = in? ONE:NONE;
            FLAG: next_state = in? ONE:NONE;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            state<=NONE;
        else
            state<=next_state;
    end
    assign {disc,flag,err} = {(state==DISC),(state==FLAG),(state==ERR)};

endmodule

*/
