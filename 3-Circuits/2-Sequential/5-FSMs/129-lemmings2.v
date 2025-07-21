module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT=2'b00, RIGHT=2'b01, AHHH= 2'b10;
    reg [1:0] state, next_state, before_ahhh;
    // state transition logic
    always @ (*) begin
        if (bump_left & bump_right & ground & state !== AHHH) begin
            if (state==LEFT)
                next_state = RIGHT;
        	else if (state==RIGHT)
                next_state = LEFT;
        end
        else if (bump_left & ground & state !== AHHH)
            next_state = RIGHT;
        else if (bump_right & ground & state !== AHHH)
            next_state = LEFT;
        else if (!ground)
            next_state = AHHH;
        else if (ground & state==AHHH)
            next_state = before_ahhh;
       	else
            next_state = state;
    end
    // state flipflips and asynchronous reset
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
        state <= LEFT;
        before_ahhh <= LEFT;
    	end 
        else begin
        state <= next_state;
        if (!ground & state != AHHH)
            before_ahhh <= state;
    	end
    end
    // assign
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign aaah = (state==AHHH);

endmodule
