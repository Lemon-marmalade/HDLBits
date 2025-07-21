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
