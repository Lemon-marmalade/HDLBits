module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    integer i;
    
    always @(*) begin
        {cout[0], sum[0]} = a[0] + b[0] + cin;
        for (i=1;i<100;i=i+1) begin
            {cout[i], sum[i]} = a[i] + b[i] + cout[i-1];
        end
    end

endmodule

/* Using generate for-loop

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    fadd u0 (a[0],b[0],cin, cout[0],sum[0]);
    genvar i;
    generate
        for (i=1;i<100;i++) begin: fadd_gen
            fadd ui (a[i],b[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate
endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a+b+cin;
endmodule

*/
