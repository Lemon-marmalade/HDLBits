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

/* Alternate solution, possibly better since less wires

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout;
    wire [15:0] sum1, sum2;
	
    add16 first (a[15:0],b[15:0],0,sum[15:0],cout);
    
    add16 second1 (a[31:16], b[31:16], 0, sum1);
    add16 second2 (a[31:16], b[31:16], 1, sum2);
    assign sum[31:16] = cout? sum2:sum1;

endmodule 
*/
