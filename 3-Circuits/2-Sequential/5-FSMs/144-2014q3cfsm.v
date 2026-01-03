module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
	reg Y;
    always @ (*) begin
        case (y)
            3'b000: Y = x? 3'b001:3'b000;
            3'b001: Y = x? 3'b100:3'b001;
            3'b010: Y = x? 3'b001:3'b010;
            3'b011: Y = x? 3'b010:3'b001;
            3'b100: Y = x? 3'b100:3'b011;
            default: Y = 3'b000;
        endcase
    end
    assign z = ((y==3'b011)||(y==3'b100));
    assign Y0 = Y;
endmodule

/* Decimal representation version of part c

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] Y;
    always @(*) begin
        case(y)
            0: Y = x? 1:0;
            1: Y = x? 4:1;
            2: Y = x? 1:2;
            3: Y = x? 2:1;
            4: Y = x? 4:3;
        endcase
    end
    assign Y0 = Y[0];
    assign z = (y==3 || y==4);
endmodule

*/
