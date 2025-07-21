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
