module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9;
    assign next_state[S0] = !in & (state[S0]||state[S1]||state[S2]||state[S3]||state[S4]||state[S7]||state[S8]||state[S9]);
    assign next_state[S1] = in &(state[S0]||state[S8]||state[S9]);
    assign next_state[S2] = in & state[S1];
    assign next_state[S3] = in & state[S2];
    assign next_state[S4] = in & state[S3];
    assign next_state[S5] = in & state[S4];
    assign next_state[S6] = in & state[S5];
    assign next_state[S7] = in & (state[S6]||state[S7]);
    assign next_state[S8] = !in & state[S5];
    assign next_state[S9] = !in & state[S6];
    
    assign out1 = state[S8]||state[S9];
    assign out2 = state[S9]||state[S7];
endmodule

/* More concise version (with proper one-hot statements this time)

module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    assign next_state[0] = (state[0]&~in)|(state[1]&~in)|(state[2]&~in)|(state[3]&~in)|(state[4]&~in)|(state[7]&~in)|(state[8]&~in)|(state[9]&~in);
    assign next_state[1] = (state[0]&in)|(state[8]&in)|(state[9]&in);
    assign next_state[6:2] = {state[5]&in, state[4]&in, state[3]&in, state[2]&in, state[1]&in};
    assign next_state[7] = (state[6]&in) | (state[7]&in);
    assign next_state[8] = state[5] & ~in;
    assign next_state[9] = state [6] & ~in;
    
    assign out1 = (state[8]|state[9]);
    assign out2 = (state[7]|state[9]);
    

endmodule

*/
