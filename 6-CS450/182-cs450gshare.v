module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0] PHT[127:0]; // register array (128 entries that are each 2 bits wide)
   	integer i;
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 0;
            for (i=0; i<128; i=i+1) 
                PHT[i] <= 2'b01; // cleared to WT
        end
        else begin
            if (train_valid && train_mispredicted)
                predict_history <= {train_history[6:0], train_taken}; // from previou exercises, but more concise
            else if (predict_valid)
                predict_history <= {predict_history[6:0], predict_taken}; // from previous exercises, but more concise
            
            if (train_valid) begin
                if (train_taken)
                    PHT[train_history ^ train_pc] <= (PHT[train_history ^ train_pc] == 2'b11) ? 2'b11 : (PHT[train_history ^ train_pc] + 1);//hashing to ST or the one more
	            else
                	PHT[train_history ^ train_pc] <= (PHT[train_history ^ train_pc] == 2'b00) ? 2'b00 : (PHT[train_history ^ train_pc] - 1);//hashing to SNT or the one less
            end
        end
    end
    
    assign predict_taken = PHT[predict_history ^ predict_pc][1]; // conditional for whether specific PHT is taken
endmodule