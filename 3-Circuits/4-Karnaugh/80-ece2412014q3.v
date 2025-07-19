module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    assign mux_in[0] = c?c:d; //2 to 1 mux... could also use c|d
    assign mux_in[1] = 0;
    assign mux_in[2] = ~d;
    assign mux_in[3] = c?d:c;//2 to 1 mux... could also use c&d
    
endmodule