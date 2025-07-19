module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    assign out[3:0]=in[sel*4 +: 4]; // indexed part select. Left argument is LSB, right argument is the value to be added to the LSB to achieve the MSB

endmodule