module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg [3:0] state, next_state, delay;
    int counter;
    parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6;
    
    always @ (*) begin
        case (state)
            A: next_state = data? B:A; // want 1
            B: next_state = data? C:A; // want 1
            C: next_state = data? C:D; // want 0 but if not, can treat the 1 as the second 1
            D: next_state = data? E:A; // want 1
            E: next_state = (counter==1)? F:E;
            F: next_state = (counter==999 && delay == 4'b0)? G:F;
            G: next_state = ack? A:G;
        endcase
    end
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            counter <= 0;
            delay <= 4'b0;
        end
        else begin
            if (next_state==E)
                counter<=4;
            if (state==E) begin
                counter <= counter - 1;
                delay <= {delay[2:0],data};
            end
            else if (state==F) begin
                if (counter==999 && delay!=4'b0) begin
                    delay <= delay-4'b1;
                    counter <= 0;
                end
                else
                    counter <= counter+1;
            end
            state <= next_state;
        end
       
    end
    assign count = delay;
    assign counting = (state==F);
    assign done = (state==G);

endmodule
