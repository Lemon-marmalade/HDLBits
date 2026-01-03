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

/* Revisited version with explanation, better concision, and clearer naming

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    //to form two’s complement starting from LSB, copy bits unchanged until the first 1 is seen, then invert all remaining

    parameter ZERO=0, INVERT=1;
    reg state, next_state;
    always @(*) begin
        case (state)
            ZERO: next_state = x? INVERT:ZERO;
            INVERT: next_state = INVERT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state<=ZERO;
            z<=0;
        end
        else begin
            state<=next_state;
            z<=(state==ZERO)? (x? 1:0):(x? 0:1); // else if INVERT, output is inverted
        end
    end

endmodule

*/

/* Properly implementing Moore's version as required by the question this time

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    //to form two’s complement starting from LSB, copy bits unchanged until the first 1 is seen, then invert all remaining

    parameter COPY_0=0, COPY_1=1, INVERT_0=2, INVERT_1=3;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            COPY_0: next_state = x? COPY_1:COPY_0;
            // first time 1 is seen, copy, then enter invert phase
            COPY_1: next_state = x? INVERT_1:INVERT_0;
            INVERT_0: next_state = x? INVERT_1:INVERT_0;
            INVERT_1: next_state = x? INVERT_1:INVERT_0;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            state<=COPY_0;
        else
            state<=next_state;
    end
    
    assign z = (state==COPY_1 || state==INVERT_0);

endmodule

*/
