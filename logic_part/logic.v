module pointer(inx, iny, reset, loca);
  input inx, iny, reset;
  output [7:0] loca;
  reg [7:0] loc;
  reg temp;
  always @(posedge inx, posedge iny, posedge reset) begin
    if (reset == 1'b0)
      loc = 8'b0;
    else if (inx == 1'b1)
      loc[3:0] = loc[3:0] + 1'b1;
    else if (iny == 1'b1)
      loc[7:4] = loc[7:4] + 1'b1;
  end
  assign loca = loc;
endmodule

module horizontal_check(active, active_next, address, readborad, pointer, chess, success, clk, currstate);
  input active;
  input [1:0] readboard;
  input [7:0] pointer;
  input [1:0] chess;
  input [1:0] currstate;
  input clk;
  output active_next, success;
  output [7:0] address;
  reg [7:0] curradd;
  reg [7:0] end;
  reg [1:0] curstate;
  reg [2:0] count;
  reg [1:0] ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;

  always @(posedge active) begin
    actnxt = 1'b0;
    suc = 1'b0;
    count = 3'd0;
    ches = chess;
    if (pointer[3:0] < 4'd4)
      begin
        curradd = {pointer[7:4], 4'd0};
        end = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    else if (pointer[3:0] > 4'd11)
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        end = {pointer[7:4], 4'd0};
      end
    else
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        end = {pointer[7:4], pointer[3:0] + 4'd4};
      end
  end

  always @(posedge clk) begin
    if(active == 1'b1) begin
      if (curradd == end)
        actnxt = 1'b1;
      else if (count == 3'd5)
        suc = 1'd1;
      else
        curradd[3:0] = curradd[3:0] + 4'd1;
    end
  end

  always @(curradd) begin
    curstate = currstate;
    if (ches == curstate)
      count = count + 3'd1;
    else
      count = 3'd0;
  end
endmodule