module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1;
    reg [0:0] state, next_state;
    
    always @ (*) begin
        if (areset) begin
            next_state = A;
        	z = x;
        end
        else begin
            case (state)
                A: begin
                    next_state = x? B:A;
                    z = x? 1'b1:1'b0;
                end
                B: begin
                    next_state = B;
                    z = x? 1'b0:1'b1;
                end
            endcase
        end
    end
    always @ (posedge clk or posedge areset)
        if (areset)
            state = A;
    	else
        state <= next_state;
endmodule

/* Version from revisitng question a second time

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter ZERO=0, INVERT=1;
    reg state, next_state;
    always @(*) begin
        case (state)
            ZERO: next_state = x? INVERT:ZERO;
            INVERT: next_state = INVERT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state<=ZERO;
        end
        else begin
            state<=next_state;
        end
    end
    
    assign z=(state==ZERO)? (x? 1:0):(x? 0:1);

endmodule

*/
