module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    reg [31:0] pre_history;
    
    always @ (*) begin
        if (train_mispredicted)
            pre_history = {train_history [30:0], train_taken};
        else if (predict_valid)
            pre_history = {predict_history [30:0], predict_taken};
        else
            pre_history = predict_history;
		        
    end
    always @ (posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end
        else
            predict_history <= pre_history;
    end

endmodule
