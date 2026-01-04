module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2:0] state, next_state;
    parameter A=0, B=1, C=2, D=3, E=4;
    
    always @ (*) begin
        case (state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = E;
            default: next_state = A;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    assign shift_ena = (state != E);
endmodule

/* Different version

module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter SHIFT=2'b1, DONE=2'd2;
    reg [1:0] state, next_state;
    reg [3:0] q;
    reg [2:0] clkcount;
    
    always @(*) begin
        case(state)
            SHIFT: next_state = (clkcount==3)? DONE:SHIFT;
            DONE: next_state = DONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state<=SHIFT;
            clkcount<=3'b0;
        end
        else begin
			state<=next_state;
            clkcount<=clkcount+3'b1;
        end
    end
    
    assign shift_ena = (state==SHIFT);

endmodule

*/
