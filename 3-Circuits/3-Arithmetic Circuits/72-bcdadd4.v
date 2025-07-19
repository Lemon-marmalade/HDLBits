module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire cout_wires[3:0];
    genvar i;
    generate
        // BCDs have 4 bits
        bcd_fadd instance1(a[3:0], b[3:0], cin, cout_wires[0],sum[3:0]);
        for (i=4;i<16;i=i+4) begin: bcd_adder_instances
            bcd_fadd instances(a[i+3:i],b[i+3:i],cout_wires[i/4-1],cout_wires[i/4],sum[i+3:i]);
        end
    endgenerate
    
    assign cout = cout_wires[3];
endmodule