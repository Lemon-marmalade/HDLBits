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
