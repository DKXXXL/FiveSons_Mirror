module pospulse_gen(in, pulse, clk);
    input in;
    input clk;
    output pulse;
    reg pul;
    reg got_pos;
    assign pulse = pul;
    initial begin
        pul = 1'b0;
        got_pos = 1'b0;
    end
    always @(in) begin
        if (clk) got_pos = 1'b1;
		pul = pul + 1'b1;
    end
    always @(negedge clk) begin
        if (got_pos) got_pos = got_pos - 1'b1;
		else pul = 1'b0;
    end
endmodule
