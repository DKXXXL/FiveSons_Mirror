module horizontal_check(reset, active, active_next, address, pointer, chess, success, clk, currstate);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;

  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;

  always @(posedge reset) begin
    actnex = 1'b0;
    suc = 1'b0;
    curstate = 2'd0;
    ches = 2'd0;
    count = 3'd0;
    curradd = 8'd0;
    endadd = 8'd0;
  end

  always @(posedge active) begin
    ches = chess;
    if (pointer[3:0] < 4'd4)
      begin
        curradd = {pointer[7:4], 4'd0};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    else if (pointer[3:0] > 4'd11)
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], 4'd15};
      end
    else
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
  end

  always @(posedge clk) begin
    if(active == 1'b1) begin
      if (curradd == endadd)
        actnex = 1'b1;
      else if (count == 3'd5)
        suc = 1'd1;
      else if (suc != 1'b1)
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

module verticle_check(reset, active, active_next, address, pointer, chess, success, clk, currstate);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;

  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;

  always @(posedge reset) begin
    actnex = 1'b0;
    suc = 1'b0;
    curstate = 2'd0;
    ches = 2'd0;
    count = 3'd0;
    curradd = 8'd0;
    endadd = 8'd0;
  end

  always @(posedge active) begin
    ches = chess;
    if (pointer[7:4] < 4'd4)
      begin
        curradd = {4'd0, pointer[3:0]};
        endadd = {pointer[7:4] + 4'd4, pointer[3:0]};
      end
    else if (pointer[7:4] > 4'd11)
      begin
        curradd = {pointer[7:4] - 4'd4, pointer[3:0]};
        endadd = {4'd15, pointer[3:0]};
      end
    else
      begin
        curradd = {pointer[7:4] - 4'd4, pointer[3:0]};
        endadd = {pointer[7:4] + 4'd4, pointer[3:0]};
      end
  end

  always @(posedge clk) begin
    if(active == 1'b1) begin
      if (curradd == endadd)
        actnex = 1'b1;
      else if (count == 3'd5)
        suc = 1'd1;
      else if (suc != 1'b1)
        curradd[7:4] = curradd[7:4] + 4'd1;
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

module lean1_check(reset, active, active_next, address, pointer, chess, success, clk, currstate);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;

  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;

  always @(posedge reset) begin
    actnex = 1'b0;
    suc = 1'b0;
    curstate = 2'd0;
    ches = 2'd0;
    count = 3'd0;
    curradd = 8'd0;
    endadd = 8'd0;
  end

  always @(posedge active) begin
    ches = chess;
    if (pointer[3:0] < 4'd4)
      begin
        curradd = {pointer[7:4], 4'd0};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    else if (pointer[3:0] > 4'd11)
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], 4'd15};
      end
    else
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    
    if (pointer[7:4] < 4'd4)
      begin
        curradd = {4'd0, curradd[3:0]};
        endadd = {endadd[7:4] + 4'd4, endadd[3:0]};
      end
    else if (pointer[7:4] > 4'd11)
      begin
        curradd = {curradd[7:4] - 4'd4, curradd[3:0]};
        endadd = {4'd15, endadd[3:0]};
      end
    else
      begin
        curradd = {curradd[7:4] - 4'd4, curradd[3:0]};
        endadd = {endadd[7:4] + 4'd4, endadd[3:0]};
      end
  end

  always @(posedge clk) begin
    if(active == 1'b1) begin
      if (curradd == endadd)
        actnex = 1'b1;
      else if (count == 3'd5)
        suc = 1'd1;
      else if (suc != 1'b1)
        curradd[3:0] = curradd[3:0] + 4'd1;
        curradd[7:4] = curradd[7:4] + 4'd1;
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

module lean2_check(reset, active, active_next, address, pointer, chess, success, clk, currstate);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;

  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;

  always @(posedge reset) begin
    actnex = 1'b0;
    suc = 1'b0;
    curstate = 2'd0;
    ches = 2'd0;
    count = 3'd0;
    curradd = 8'd0;
    endadd = 8'd0;
  end

  always @(posedge active) begin
    ches = chess;
    if (pointer[3:0] < 4'd4)
      begin
        curradd = {pointer[7:4], 4'd0};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    else if (pointer[3:0] > 4'd11)
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], 4'd15};
      end
    else
      begin
        curradd = {pointer[7:4], pointer[3:0] - 4'd4};
        endadd = {pointer[7:4], pointer[3:0] + 4'd4};
      end
    
    if (pointer[7:4] < 4'd4)
      begin
        curradd = {4'd0, curradd[3:0]};
        endadd = {endadd[7:4] + 4'd4, endadd[3:0]};
      end
    else if (pointer[7:4] > 4'd11)
      begin
        curradd = {curradd[7:4] - 4'd4, curradd[3:0]};
        endadd = {4'd15, endadd[3:0]};
      end
    else
      begin
        curradd = {curradd[7:4] + 4'd4, curradd[3:0]};
        endadd = {endadd[7:4] - 4'd4, endadd[3:0]};
      end
  end

  always @(posedge clk) begin
    if(active == 1'b1) begin
      if (curradd == endadd)
        actnex = 1'b1;
      else if (count == 3'd5)
        suc = 1'd1;
      else if (suc != 1'b1)
        curradd[3:0] = curradd[3:0] + 4'd1;
        curradd[7:4] = curradd[7:4] - 4'd1;
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
