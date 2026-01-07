module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg next_state;
    always @ (*) begin
        if (state==0) begin
            next_state = (a&b);
        	q = a^b;
        end
        else begin
            next_state = (a||b);
            q = ~(a^b);
        end
    end
    always @ (posedge clk) begin
        state <= next_state;
    end

endmodule

/* More concise version with ternary operator

module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg next_state;
    always @(*) begin
        next_state = state? a|b:a&b;
        q = state? ~(a^b):(a^b);
    end
    always @ (posedge clk) begin
        state <= next_state;
    end
    
endmodule

*/
