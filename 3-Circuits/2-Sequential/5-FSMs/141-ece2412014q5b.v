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