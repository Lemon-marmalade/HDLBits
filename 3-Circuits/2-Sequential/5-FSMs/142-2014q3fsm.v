module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    reg[0:0] state, next_state, prev, prev_prev;
    parameter A=0, B=1;
    integer cycle;
    
    always @ (*) begin
        case (state)
            A: next_state = s? B:A;
            B: next_state = B;
        endcase
    end
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            cycle <= 0;
            prev <= 0;
            prev_prev <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
            prev_prev <= prev;
            prev <= w;
            if (next_state==B && state==A)
                cycle <= 1;
                z <= 0;
            if (state==B) begin
                cycle <= cycle + 1;
                if (cycle==3) begin
                    if ((prev_prev + prev + w)==2)
                        z <= 1;
                    else
                        z <= 0;
                    cycle <= 1;
                end
            end

        end
    end
        
endmodule

/* Different method

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0, B=1;
    reg state, next_state;
    reg [1:0] clkcount, wcount;
    wire [1:0] wnext = wcount + w;   // must have this variable done combinationally or there's delay
    
    always @(*) begin
        case(state)
            A: next_state = s? B:A;
            B: next_state = B;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state<=A;
            clkcount<=0;
            wcount<=0;
            z<=0;
        end
        else begin
            state<=next_state;
            if (state==B) begin
                if (clkcount==2) begin
                    clkcount<=0;
                    wcount<=0;
                    z<=(wnext==2);
                end
                else begin
                    clkcount<=clkcount+1;
                    wcount<=wnext;
                    z<=0; // z is inactive between windows
                end
            end
        end
    end
endmodule

*/
