module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire[99:0] cout_wires;
    // only genvar variables can be used in generate loops
    genvar i;
    // generate blockes can be used for modules
    generate
        // BCDs have 4 bits
        bcd_fadd(a[3:0], b[3:0], cin, cout_wires[0],sum[3:0]);
        for (i=4; i<400; i=i+4) begin: bcd_adder_instances
            //modules don't need separate name
            bcd_fadd instances(a[i+3:i], b[i+3:i], cout_wires[i/4-1],cout_wires[i/4],sum[i+3:i]);
        end
    endgenerate
    // connect actual cout with created variable
    assign cout = cout_wires[99];
    
endmodule

/* Different generate version

module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire[98:0] c;
    bcd_fadd u0 (a[3:0],b[3:0],cin, c[0],sum[3:0]);
    genvar i;
    generate
        for (i=1;i<99;i++) begin: bcdfadd_gen
            bcd_fadd ui (a[i*4+3-:4],b[i*4+3-:4],c[i-1],c[i],sum[i*4+3-:4]);
        end
    endgenerate
    bcd_fadd u99 (a[399:396],b[399:396],c[98], cout,sum[399:396]);

endmodule

*/
