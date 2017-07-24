module pointer(inx, iny, reset, loca);
  input inx, iny, reset;
  output reg [7:0] loca;
  initial begin
    loca[7:0] = 8'd0;
	 end
  always @(negedge inx, posedge reset) begin
    if (reset == 1'b0) begin
		if (loca[3:0] == 4'b1111) loca[3:0] = 4'd0;
		else loca[3:0] = loca[3:0] + 4'b1;
	end
	else loca[3:0] = 4'd0;
  end
  
  always @(negedge iny, posedge reset) begin
    if (reset == 1'b0) begin
		if (loca[7:4] == 4'b1111) loca[7:4] = 4'd0;
      else loca[7:4] = loca[7:4] + 4'b1;
	end
	else loca[7:4] = 4'd0;
  end
endmodule
