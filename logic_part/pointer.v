module pointer(inx, iny, reset, loca);
  input inx, iny, reset;
  output [7:0] loca;
  reg [7:0] loc;
  reg temp;
  always @(posedge inx, posedge iny, posedge reset) begin
    if (reset == 1'b1)
      loc = 8'b0;
    else if (inx == 1'b1)
      loc[3:0] = loc[3:0] + 1'b1;
    else if (iny == 1'b1)
      loc[7:4] = loc[7:4] + 1'b1;
  end
  assign loca = loc;
endmodule
