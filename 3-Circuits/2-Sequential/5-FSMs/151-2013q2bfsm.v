module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    reg [3:1] s, S; // y=state, Y=next_state
    reg [3:1] xxx;
    reg prev_r;
    int cc;
    
    always @ (*) begin
        case (s)
            A: S = resetn? B:A;
            B: begin
                	S = C;
            end
            C: begin
                if ({x,xxx[3:2]}==3'b101)
                    S = D;
                else
                    S = C;
            end
            D: begin
                if (cc<=2) begin
                    if (cc==2)
                    	S= y? E:F;
                	else
                        S= y? E:D;
                end
                else
                    S=F;
            end
            E: S = E;
            F: S = F;
            default: S = A;
        endcase
    end
    
    always @ (posedge clk) begin        
        if (!resetn) begin
            s <= A;
            cc <= 0;
        end
        else begin
            s <= S;
            if (s==C)
            	xxx <= {x, xxx[3:2]};
            
            if (S==D)
                cc <= cc + 1;
        end
    end
    assign g = ((s==D)|(s==E));
    assign f = (s==B);
endmodule

/* Different method with one less state (although output is dependent on clkcount now too

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, X=2, Y=3, Y0=4, Y1=5;
    reg [2:0] state, next_state;
    reg [1:0] xx;
    reg clkcount;
    
    always @(*) begin
        case(state)
            A: next_state = (clkcount==1)? X:A;
            X: next_state = ({xx,x}==3'b101)? Y:X;
            Y: next_state = y? Y1:((clkcount==1)? Y0:Y);
            Y0: next_state = Y0;
            Y1: next_state = Y1;
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn) begin
            state<=A;
            xx<=2'b0;
            clkcount<=0;
        end
        else begin
            state<=next_state;
            case(state)
                A: clkcount<=clkcount+1;
                X: begin
                    clkcount<=0;
                    xx<={xx[0],x};
                end
                Y: clkcount<=clkcount+1;
            endcase
        end
    end
    assign f = (state==A && clkcount==1); // could add another state after A to make f only state-dependent
    assign g = (state==Y)||(state==Y1);
   
endmodule

*/
