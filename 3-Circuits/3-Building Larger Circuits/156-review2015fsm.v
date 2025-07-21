module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [3:0] state, next_state, count;
    parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6;
    
    always @ (*) begin
        case (state)
            A: next_state = data? B:A; // want 1
            B: next_state = data? C:A; // want 1
            C: next_state = data? C:D; // want 0 but if not, can treat the 1 as the second 1
            D: next_state = data? E:A; // want 1
            E: next_state = (count==3)? F:E;
            F: next_state = (done_counting)? G:F;
            G: next_state = ack? A:G;
        endcase
    end
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 0;
        end
        else begin
            state <= next_state;
            if (state==E)
                count <= (count==3)? 4'b0:(count + 4'b1);
        end
    end
    assign shift_ena = (state==E)? 1:0;
    assign counting = (state==F)? 1:0;
    assign done = (state==G)? 1:0;
endmodule
