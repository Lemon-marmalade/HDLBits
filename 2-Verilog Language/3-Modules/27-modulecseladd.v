module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire[15:0] wtop;
    wire wsel;
    wire[31:16] w0, w1, wbottom;
    add16 instance1 (.a(a[15:0]),.b(b[15:0]),.sum(wtop),.cin(0),.cout(wsel));
    add16 instance2 (.a(a[31:16]),.b(b[31:16]),.sum(w0),.cin(0));
    add16 instance3 (.a(a[31:16]),.b(b[31:16]),.sum(w1),.cin(1));
	always @ (*) 
		begin
            case(wsel)
              2'b0: wbottom = w0; 		
              2'b1: wbottom = w1;
            endcase
          end
                     assign sum[15:0]=wtop;
                     assign sum[31:16]=wbottom;
endmodule
