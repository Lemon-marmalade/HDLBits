module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    always @ (posedge clk) begin
        if (reset) begin
            hh <= {4'h1,4'h2};
            mm <= {4'h0,4'h0};
            ss <= {4'h0,4'h0};
            pm <= 1'b0;
        end
        else begin
            if (!ena) begin
                hh <= hh;
                mm <= mm;
                ss <= ss;
                pm <= pm;
            end
            else begin
                if (ss== {4'h5,4'h9}) begin//
                	ss <= {4'h0,4'h0};

                    if (mm !== {4'h5,4'h9}) begin//
                    	if (mm[3:0]==9) begin
                        	mm[3:0] <= 4'b0;
                            mm[7:4] <= mm[7:4]+ 4'h1;
                        end
                        else
                            mm[3:0] <= mm[3:0] + 4'h1;
                    end //

                    else begin//
                        mm <= {4'h0,4'h0};
                        if (hh !=={4'h1,4'h2}) begin//
                            if (hh[3:0]==9) begin
                                hh[3:0] <= 4'b0;
                                hh[7:4] <= hh[7:4]+ 4'h1;
                            end
                            else
                                hh[3:0] <= hh[3:0] + 4'h1;
                            if (hh =={4'h1,4'h1})
                                pm <= ~pm;
                        end//
                        else begin//
                            hh <= {4'h0,4'h1};
                        end//
                    end//
                end//
                else begin//
                    if (ss[3:0]==9) begin
                        ss[3:0] <= 4'b0;
                        ss[7:4] <= ss[7:4]+ 4'h1;
                        end
                    else
                        ss[3:0] <= ss[3:0] + 4'h1;
                end//
            end
        end
    end

endmodule