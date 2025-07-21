module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A=0, B=1, C=2, D=3;
    reg [3:1] y, Y; // y=state, Y=next_state
    
    always @ (*) begin
        case (y)
            A: begin
                if (r==3'b000)
                    Y = A;
                else if (r[1])
                    Y = B;
                else if (!r[1] && r[2])
                    Y = C;
                else
                    Y = D;
            end
            B: Y = r[1]? B:A;
            C: Y = r[2]? C:A;
            D: Y = r[3]? D:A;
            default: Y = A;
        endcase
    end
    
    always @ (posedge clk) begin
        if (!resetn)
            y <= A;
        else begin
            y <= Y;
        end
    end
    
    assign g = {(y==D),(y==C),(y==B)};

endmodule
