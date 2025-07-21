module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
    parameter LEFT=2'b00, RIGHT=2'b01, AHHH=2'b10, DIG=2'b11;
    reg [1:0] state, next_state, last, prev_dig;
    // state transition logic
    always @ (*) begin
        if (bump_left & bump_right & ground & state !== AHHH & state !== DIG & !dig) begin
            if (state==LEFT)
                next_state = RIGHT;
        	else if (state==RIGHT)
                next_state = LEFT;
        end
        else if (bump_left & bump_right & ground & state == AHHH) begin
            if (last==LEFT)
                next_state = LEFT;
            else if (last==RIGHT)
                next_state = RIGHT;
        end
        else if (bump_left & ground & state != AHHH & state != DIG & !dig)
            next_state = RIGHT;
        else if (bump_right & ground & state != AHHH & state != DIG & !dig)
            next_state = LEFT;
        else if (dig & ground & state != AHHH)
            next_state = DIG;
        else if (!ground)
            next_state = AHHH;
        else if (ground & state==AHHH)
            next_state = last;
       	else
            next_state = state;
    end
    // state flipflips and asynchronous reset
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
        state <= LEFT;
        last <= LEFT;
    	end 
        else begin
        state <= next_state;
            if (state==RIGHT|state==LEFT) begin
            	last <= state;
            end
    	end
    end
    // assign
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign aaah = (state==AHHH);
    assign digging = (state==DIG);

endmodule
