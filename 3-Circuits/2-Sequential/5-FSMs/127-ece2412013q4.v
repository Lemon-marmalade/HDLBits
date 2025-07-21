module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A=3'b111, B=3'b011, C=3'b001, D=3'b000;
    reg [2:0] next_state, state;
    // State transition logic
    always @ (*) begin
        case (s)
            A: next_state = A;
            B: next_state = B;
            C: next_state = C;
            D: next_state = D;
            default: next_state = D;
        endcase
    end
    // State flip-flops with synchronous reset
    always @ (posedge clk) begin
        if (reset) begin
        	{fr3,fr2,fr1} <= 3'b111;
        	state <= D;
            dfr <= 1;
        end
        else begin
            case (next_state)
                A: {fr3,fr2,fr1} = 3'b000;
                B: {fr3,fr2,fr1} = 3'b001;
                C: {fr3,fr2,fr1} = 3'b011;
                D: {fr3,fr2,fr1} = 3'b111;
            endcase
            state <= next_state;
            if (next_state<state)
            	dfr <= 1'b1;
            else if (next_state>state)
                dfr <= 1'b0;
        end
        
        
    end
	
endmodule
