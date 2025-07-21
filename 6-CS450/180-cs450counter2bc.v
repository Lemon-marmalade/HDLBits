module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] next_state;
    parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11;
    
    always @ (*) begin
        if (train_valid) begin
            case(state)
                SNT: next_state = train_taken? WNT:SNT;
                WNT: next_state = train_taken? WT:SNT;
                WT: next_state = train_taken? ST:WNT;
                ST: next_state = train_taken? ST:WT;
            endcase
        end
        else
            next_state=state;
    end
    always @ (posedge clk, posedge areset) begin
        if (areset)
            state <= WNT;
        else begin
            state <= next_state;
        end
    end

endmodule