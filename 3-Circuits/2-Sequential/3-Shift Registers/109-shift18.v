module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    always @ (posedge clk) begin
        if (load)
            q <= data;
        else
            if (ena) begin
                if (amount==2'b00) // shift left 1 bit
                    q <= {q[62:0],1'b0};
                else if (amount==2'b01) //shift left 8 bits
                    q <= {q[55:0],8'b0};
                else if (amount==2'b10) // shift right 1 bit
                    q <= {q[63],q[63:1]};
                else if (amount==2'b11) //shift right 8 bits
                    q <= {{8{q[63]}}, q[63:8]};
            end
                
    end

endmodule