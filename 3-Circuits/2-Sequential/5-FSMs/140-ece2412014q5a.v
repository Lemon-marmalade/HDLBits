module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1;
    reg [0:0] state, next_state;
    
    always @ (*) begin
        case (state)
            A: next_state = x? B:A;
            B: next_state = B;
        endcase
    end
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        	z <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                A: z <= x? 1:0;
                B: z <= x? 0:1;
            endcase
        end
    end
endmodule