module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    reg [1:0] next_state;
    reg prev, prev_prev;
    parameter HIGH=1, LOW=0;
    
    always @ (*) begin
        if (prev_prev==1 && prev==0 && x==1)
            next_state = HIGH;
        else
            next_state = LOW;
    end
    
    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn) begin
        	prev <= 0;
            prev_prev <=0;
        end
        else begin
            prev <= x;
            prev_prev <=prev;
        end
    end
    assign z = (next_state==HIGH);
endmodule

/* Rroperly implementing the Mealy FSM

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    parameter IDLE=0, S1=1, S2=2;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case(state)
            IDLE: next_state = x? S1:IDLE;
            S1: next_state = x? S1:S2;
            S2: next_state = x? S1:IDLE;
        endcase
    end
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state<=IDLE;
        else
            state<=next_state;
    end
    assign z = (state==S2 & x);

endmodule

*/
