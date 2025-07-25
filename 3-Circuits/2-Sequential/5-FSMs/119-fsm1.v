module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    //parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        if (in==1'b0)
            next_state =~state;
        else
            next_state = state;
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset)
            state <= 1;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = state;

endmodule