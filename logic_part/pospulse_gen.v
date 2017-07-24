module pospulse_gen(in, pulse, clk);
	input in;
	input clk;
	output pulse;
	reg state;
	always @(posedge clk) state <= in;
	assign pulse = state != in;
endmodule