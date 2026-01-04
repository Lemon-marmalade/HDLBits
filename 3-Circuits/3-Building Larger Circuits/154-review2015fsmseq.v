module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    reg [3:0] state, next_state;
    parameter A=0, B=1, C=2, D=3, E=4;
    
    always @ (*) begin
        case (state)
            A: next_state = data? B:A; // want 1
            B: next_state = data? C:A; // want 1
			C: next_state = data? C:D; // want 0, don't reset if 1 though, cuz can start as if it is the second 1
            D: next_state = data? E:A; // want 1
            E: next_state = E;
        endcase
    end
    always @ (posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    assign start_shifting = (state==E);
endmodule

/* Mealy version

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter IDLE=1'b0, SHIFT=1'b1;
    reg state, next_state;
    reg [3:0] q;
    
    always @(*) begin
        case(state)
            IDLE: next_state = ({q[2:0],data}==4'b1101)? SHIFT:IDLE;
            SHIFT: next_state = SHIFT;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state<=IDLE;
        	q<=3'b0;
        end
        else begin
            state<=next_state;
    		q<={q[2:0],data};
        end
    end
    
    assign start_shifting = (state==SHIFT);

endmodule

*/
