module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=1'b0, RIGHT=1'b1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if(bump_left & bump_right)begin
            next_state = (state==LEFT)? RIGHT:LEFT;
        end
        else if(bump_left)begin
            next_state=RIGHT;
        end
        else if(bump_right)begin
            next_state=LEFT;
        end
        else begin
            next_state=state;
        end
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
