module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg [3:0] state, next_state, delay;
    int counter;
    parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6;
    
    always @ (*) begin
        case (state)
            A: next_state = data? B:A; // want 1
            B: next_state = data? C:A; // want 1
            C: next_state = data? C:D; // want 0 but if not, can treat the 1 as the second 1
            D: next_state = data? E:A; // want 1
            E: next_state = (counter==1)? F:E;
            F: next_state = (counter==999 && delay == 4'b0)? G:F;
            G: next_state = ack? A:G;
        endcase
    end
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            counter <= 0;
            delay <= 4'b0;
        end
        else begin
            if (next_state==E)
                counter<=4;
            if (state==E) begin
                counter <= counter - 1;
                delay <= {delay[2:0],data};
            end
            else if (state==F) begin
                if (counter==999 && delay!=4'b0) begin
                    delay <= delay-4'b1;
                    counter <= 0;
                end
                else
                    counter <= counter+1;
            end
            state <= next_state;
        end
       
    end
    assign count = delay;
    assign counting = (state==F);
    assign done = (state==G);

endmodule

/* Another method of implementing final timer (with reduced states)
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter IDLE=2'b0, SHIFT=2'b1, COUNT=2'd2, DONE=2'd3;
    reg [1:0] state, next_state;
    reg [3:0] q; // Pattern detection for shift_ena AND for storing value of delay
    integer clkcount; // For determining delay duration AND for counting
    
    always @(*) begin
        case(state)
            IDLE: next_state = ({q[2:0],data}==4'b1101)? SHIFT:IDLE;
            SHIFT: next_state = (clkcount==1)? COUNT:SHIFT;
            COUNT: next_state = (clkcount==999 && q==4'b0)? DONE:COUNT;
            DONE: next_state = ack? IDLE:DONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state<=IDLE;
        	q<=4'b0;
            clkcount<=4;
        end
        else begin
            state<=next_state;
            case(state) 
                IDLE: q<={q[2:0],data};
                SHIFT: begin
                    clkcount<=clkcount-1;
                    q<={q[2:0],data};
                end
                COUNT: begin
                    if (clkcount==999 && q!=4'b0) begin // Thousand-mark transition
                        q <= q-4'b1;
                        clkcount <= 0;
                    end
                    else
                        clkcount <= clkcount+1;
                    end
                DONE: clkcount<=4; // reset count for next SHIFT
            endcase
        end
    end
    assign count = q;
    assign counting = (state==COUNT);
    assign done = (state==DONE);

endmodule
*/
