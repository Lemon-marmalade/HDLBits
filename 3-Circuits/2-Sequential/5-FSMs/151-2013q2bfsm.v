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
