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
