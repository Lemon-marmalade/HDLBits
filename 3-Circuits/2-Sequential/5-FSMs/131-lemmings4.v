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
    
    parameter LEFT=3'b000, RIGHT=3'b001, AHHH=3'b010, DIG=3'b011, SPLAT=3'b100;
    reg [2:0] state, next_state, last;
    integer clk_count;
    // state transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = AHHH;
                else if (dig)
                    next_state = DIG;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = AHHH;
                else if (dig)
                    next_state = DIG;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            DIG: begin
                if (!ground)
                    next_state = AHHH;
                else
                    next_state = DIG;
            end
            AHHH: begin
                if (ground) begin
                    if (clk_count >= 20)
                        next_state = SPLAT;
                    else
                        next_state = last;
                end 
                else
                    next_state = AHHH;
            end
            SPLAT: next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end
    // state flipflips and asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            last <= LEFT;
            clk_count <= 0;
        end 
        else begin
            state <= next_state;
            if (state == AHHH & next_state!=SPLAT)
                clk_count <= clk_count + 1;
            else
                clk_count <= 0;
            if (state == LEFT || state == RIGHT & next_state!=SPLAT)
                last <= state;
        end
    end
    // assign
	 always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == AHHH);
        digging = (state == DIG);
    end

endmodule