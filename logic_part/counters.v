module horizontal_check(reset, active, pointer, chess, address, currstate, success, active_next, clk);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;
  
  reg [3:0] curr_state, nxt_state;
  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;
  
  localparam WAIT = 4'd0,
			    INITIAL = 4'd1,
				 COUNT = 4'd2,
				 COUNT_WAIT = 4'd3,
				 SUCCESS = 4'd4,
				 FAIL = 4'd5;
  initial begin
    curradd = 8'd0;
	endadd = 8'd0;
	count = 3'd0;
	curstate = 2'd0;
	ches = 2'd0;
	actnex = 1'd0;
	suc = 1'd0;
	curr_state = WAIT;
	nxt_state = WAIT;
	end
  always @(*) begin
    case(curr_state)
		WAIT: nxt_state = (active) ? INITIAL : WAIT;
		INITIAL: nxt_state = COUNT;
		COUNT:begin
		    if (curradd == endadd) nxt_state = FAIL;
		    else if (count == 3'd5) nxt_state = SUCCESS;
		    else nxt_state = COUNT_WAIT;
            end
        COUNT_WAIT: nxt_state = COUNT;
		SUCCESS: begin
			suc = 1'd1;
			nxt_state = SUCCESS;
			end
		FAIL: begin
			actnex = 1'b1;
			nxt_state = FAIL;
			end
		default: nxt_state = WAIT;
	endcase
  end
  
  always @(curr_state) begin
    case(curr_state)
		WAIT: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
		INITIAL: begin
			ches = chess;
			 if (pointer[3:0] < 4'd4)
				begin
				  curradd[7:0] = {pointer[7:4], 4'd0};
				  endadd[7:0] = {pointer[7:4], pointer[3:0] + 4'd4};
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
		COUNT:begin
		   curstate = currstate;
           if (ches == curstate) count[2:0] = count[2:0] + 3'd1;
           else count[2:0] = 3'd0;
		   end
		COUNT_WAIT: curradd[3:0] = curradd[3:0] + 4'd1;
		SUCCESS: suc = 1'd1;
		FAIL: actnex = 1'b1;
		default: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
	endcase
  end

  always @(posedge clk, posedge reset) begin
    if (reset == 1'b1) curr_state = WAIT;
	 else curr_state = nxt_state;
  end
endmodule

module verticle_check(reset, active, pointer, chess, address, currstate, success, active_next, clk);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;
  
  reg [3:0] curr_state, nxt_state;
  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;
  
  localparam WAIT = 4'd0,
			    INITIAL = 4'd1,
				 COUNT = 4'd2,
				 COUNT_WAIT = 4'd3,
				 SUCCESS = 4'd4,
				 FAIL = 4'd5;
  initial begin
    curradd = 8'd0;
	endadd = 8'd0;
	count = 3'd0;
	curstate = 2'd0;
	ches = 2'd0;
	actnex = 1'd0;
	suc = 1'd0;
	curr_state = WAIT;
	nxt_state = WAIT;
	end
  always @(*) begin
    case(curr_state)
		WAIT: nxt_state = (active) ? INITIAL : WAIT;
		INITIAL: nxt_state = COUNT;
		COUNT:begin
		    if (curradd == endadd) nxt_state = FAIL;
		    else if (count == 3'd5) nxt_state = SUCCESS;
		    else nxt_state = COUNT_WAIT;
            end
        COUNT_WAIT: nxt_state = COUNT;
		SUCCESS: begin
			suc = 1'd1;
			nxt_state = SUCCESS;
			end
		FAIL: begin
			actnex = 1'b1;
			nxt_state = FAIL;
			end
		default: nxt_state = WAIT;
	endcase
  end
  
  always @(curr_state) begin
    case(curr_state)
		WAIT: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
		INITIAL: begin
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
		COUNT:begin
		   curstate = currstate;
           if (ches == curstate) count[2:0] = count[2:0] + 3'd1;
           else count[2:0] = 3'd0;
		   end
		COUNT_WAIT: curradd[7:4] = curradd[7:4] + 4'd1;
		SUCCESS: suc = 1'd1;
		FAIL: actnex = 1'b1;
		default: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
	endcase
  end

  always @(posedge clk, posedge reset) begin
    if (reset == 1'b1) curr_state = WAIT;
	 else curr_state = nxt_state;
  end
endmodule

module lean1_check(reset, active, pointer, chess, address, currstate, success, active_next, clk);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;
  
  reg [3:0] curr_state, nxt_state;
  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;
  
  localparam WAIT = 4'd0,
			    INITIAL = 4'd1,
				 COUNT = 4'd2,
				 COUNT_WAIT = 4'd3,
				 SUCCESS = 4'd4,
				 FAIL = 4'd5;
  initial begin
    curradd = 8'd0;
	endadd = 8'd0;
	count = 3'd0;
	curstate = 2'd0;
	ches = 2'd0;
	actnex = 1'd0;
	suc = 1'd0;
	curr_state = WAIT;
	nxt_state = WAIT;
	end
  always @(*) begin
    case(curr_state)
		WAIT: nxt_state = (active) ? INITIAL : WAIT;
		INITIAL: nxt_state = COUNT;
		COUNT:begin
		    if (curradd == endadd) nxt_state = FAIL;
		    else if (count == 3'd5) nxt_state = SUCCESS;
		    else nxt_state = COUNT_WAIT;
            end
        COUNT_WAIT: nxt_state = COUNT;
		SUCCESS: begin
			suc = 1'd1;
			nxt_state = SUCCESS;
			end
		FAIL: begin
			actnex = 1'b1;
			nxt_state = FAIL;
			end
		default: nxt_state = WAIT;
	endcase
  end
  
  always @(curr_state) begin
    case(curr_state)
		WAIT: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
		INITIAL: begin
			ches = chess;
			if ((pointer[3:0] < 4'd4) && (pointer[7:4] > 4'd3) && (pointer[7:4] < 4'd12)) begin //left
		      curradd = {pointer[7:4] - pointer[3:0] , 4'd0};
			  endadd = {pointer[7:4] + 4'd4, pointer[3:0] + 4'd4};
			end
						
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] > 4'd3) && (pointer[7:4] < 4'd12)) begin // right
		      curradd = {pointer[7:4] - 4'd4 , pointer[3:0] - 4'd4};
			  endadd = {pointer[7:4] + (4'd15 - pointer[3:0]), 4'd15};
			end
			
			else if ((pointer[7:4] < 4'd4) && (pointer[3:0] > 4'd3) && (pointer[3:0] < 4'd12)) begin // up
			  curradd = {4'd0 , pointer[3:0] - pointer[7:4]};
			  endadd = {pointer[7:4] + 4'd4, pointer[3:0] + 4'd4};
			end
			
			else if ((pointer[7:4] > 4'd11) && (pointer[3:0] > 4'd3) && (pointer[3:0] < 4'd12)) begin // down
			  curradd = {pointer[7:4] - 4'd4 , pointer[3:0] - 4'd4};
			  endadd = {4'd15, pointer[3:0] + (4'd15 - pointer[7:4])};
			end
						
			else if ((pointer[3:0] < 4'd4) && (pointer[7:4] <= 4'd3)) begin // left up
			  endadd = {pointer[7:4] + 4'd4, pointer[3:0] + 4'd4};
			  if (pointer[7:4] < pointer[3:0]) curradd = {4'd0, pointer[3:0] - pointer[7:4]};
			  else curradd = {pointer[7:4] - pointer[3:0], 4'd0};
			end
			
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] >= 4'd12)) begin // right down
			  curradd = {pointer[7:4] - 4'd4 , pointer[3:0] - 4'd4};
			  if (pointer[7:4] > pointer[3:0]) endadd = {4'd15, pointer[3:0] + (4'd15 - pointer[7:4])};
			  else endadd = {pointer[7:4] + (4'd15 - pointer[3:0]), 4'd15};
			end
			
			else if ((pointer[3:0] < 4'd4) && (pointer[7:4] >= 4'd12)) begin // left down
			  curradd = {pointer[7:4] - pointer[3:0] , 4'd0};
			  endadd = {4'd15, pointer[3:0] + (4'd15 - pointer[7:4])};
			end
			
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] <= 4'd3)) begin // right up
		      curradd = {4'd0 , pointer[3:0] - pointer[7:4]};
			  endadd = {pointer[7:4] + (4'd15 - pointer[3:0]), 4'd15};
			end

			else begin// middle
			  curradd = {pointer[7:4] - 4'd4 , pointer[3:0] - 4'd4};
			  endadd = {pointer[7:4] + 4'd4, pointer[3:0] + 4'd4};
			end
		end
		COUNT:begin
		   curstate = currstate;
           if (ches == curstate) count[2:0] = count[2:0] + 3'd1;
           else count[2:0] = 3'd0;
		   end
		COUNT_WAIT:begin
		  curradd[3:0] = curradd[3:0] + 4'd1;
          curradd[7:4] = curradd[7:4] + 4'd1;
          end
		SUCCESS: suc = 1'd1;
		FAIL: actnex = 1'b1;
		default: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
	endcase
  end

  always @(posedge clk, posedge reset) begin
    if (reset == 1'b1) curr_state = WAIT;
	 else curr_state = nxt_state;
  end
endmodule

module lean2_check(reset, active, pointer, chess, address, currstate, success, active_next, clk);
  input active, reset;
  input [7:0] pointer;
  input [1:0] chess, currstate;
  input clk;
  output [7:0] address;
  output active_next, success;
  
  reg [3:0] curr_state, nxt_state;
  reg [7:0] curradd, endadd;
  reg [2:0] count;
  reg [1:0] curstate, ches;
  reg actnex, suc;

  assign active_next = actnex;
  assign success = suc;
  assign address = curradd;
  
  localparam WAIT = 4'd0,
			    INITIAL = 4'd1,
				 COUNT = 4'd2,
				 COUNT_WAIT = 4'd3,
				 SUCCESS = 4'd4,
				 FAIL = 4'd5;
  initial begin
    curradd = 8'd0;
	endadd = 8'd0;
	count = 3'd0;
	curstate = 2'd0;
	ches = 2'd0;
	actnex = 1'd0;
	suc = 1'd0;
	curr_state = WAIT;
	nxt_state = WAIT;
	end
  always @(*) begin
    case(curr_state)
		WAIT: nxt_state = (active) ? INITIAL : WAIT;
		INITIAL: nxt_state = COUNT;
		COUNT:begin
		    if (curradd == endadd) nxt_state = FAIL;
		    else if (count == 3'd5) nxt_state = SUCCESS;
		    else nxt_state = COUNT_WAIT;
            end
        COUNT_WAIT: nxt_state = COUNT;
		SUCCESS: begin
			suc = 1'd1;
			nxt_state = SUCCESS;
			end
		FAIL: begin
			actnex = 1'b1;
			nxt_state = FAIL;
			end
		default: nxt_state = WAIT;
	endcase
  end
  
  always @(curr_state) begin
    case(curr_state)
		WAIT: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
		INITIAL: begin
			ches = chess;
			if ((pointer[3:0] < 4'd4) && (pointer[7:4] > 4'd3) && (pointer[7:4] < 4'd12)) begin //left
		      curradd = {pointer[7:4] + pointer[3:0] , 4'd0};
			  endadd = {pointer[7:4] - 4'd4, pointer[3:0] + 4'd4};
			end
						
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] > 4'd3) && (pointer[7:4] < 4'd12)) begin // right
		      curradd = {pointer[7:4] + 4'd4 , pointer[3:0] - 4'd4};
			  endadd = {pointer[7:4] - (4'd15 - pointer[3:0]), 4'd15};
			end
			
			else if ((pointer[7:4] < 4'd4) && (pointer[3:0] > 4'd3) && (pointer[3:0] < 4'd12)) begin // up
			  curradd = {pointer[7:4] + 4'd4, pointer[3:0] - 4'd4};
			  endadd = {4'd0 , pointer[3:0] + pointer[7:4]};
			end
			
			else if ((pointer[7:4] > 4'd11) && (pointer[3:0] > 4'd3) && (pointer[3:0] < 4'd12)) begin // down
			  curradd = {4'd15, pointer[3:0] - (4'd15 - pointer[7:4])};
			  endadd = {pointer[7:4] - 4'd4 , pointer[3:0] + 4'd4};
			end
						
			else if ((pointer[3:0] < 4'd4) && (pointer[7:4] <= 4'd3)) begin // left up
			  curradd = {pointer[7:4] + pointer[3:0] , 4'd0};
			  endadd = {4'd0, pointer[3:0] + pointer[7:4]};
			end
			
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] >= 4'd12)) begin // right down
			  curradd = {4'd15 , pointer[3:0] - pointer[7:4]};
			  endadd = {pointer[7:4] - (4'd15 - pointer[3:0]), 4'd15};
			end
			
			else if ((pointer[3:0] < 4'd4) && (pointer[7:4] >= 4'd12)) begin // left down
			  endadd = {pointer[7:4] - 4'd4, pointer[3:0] + 4'd4};
			  if ((4'd15 - pointer[7:4]) < pointer[3:0]) curradd = {4'd15, pointer[3:0] - (4'd15 - pointer[7:4])};
			  else curradd = {pointer[7:4] + pointer[3:0], 4'd0};
			end
			
			else if ((pointer[3:0] >= 4'd12) && (pointer[7:4] <= 4'd3)) begin // right up
			  curradd = {pointer[7:4] + 4'd4 , pointer[3:0] - 4'd4};
			  if (pointer[7:4] < (4'd15 - pointer[3:0])) endadd = {4'd0, pointer[3:0] + pointer[7:4]};
			  else endadd = {pointer[7:4] - (4'd15 - pointer[3:0]), 4'd15};
			end

			else begin// middle
			  curradd = {pointer[7:4] + 4'd4 , pointer[3:0] - 4'd4};
			  endadd = {pointer[7:4] - 4'd4, pointer[3:0] + 4'd4};
			end
		end
		COUNT:begin
		   curstate = currstate;
           if (ches == curstate) count[2:0] = count[2:0] + 3'd1;
           else count[2:0] = 3'd0;
		   end
		COUNT_WAIT:begin
		  curradd[3:0] = curradd[3:0] + 4'd1;
		  curradd[7:4] = curradd[7:4] - 4'd1;
          end
		SUCCESS: suc = 1'd1;
		FAIL: actnex = 1'b1;
		default: begin
			curradd = 8'd0;
			endadd = 8'd0;
			count = 3'd0;
			curstate = 2'd0;
			ches = 2'd0;
			actnex = 1'd0;
			suc = 1'd0;
			end
	endcase
  end

  always @(posedge clk, posedge reset) begin
    if (reset == 1'b1) curr_state = WAIT;
	 else curr_state = nxt_state;
  end
endmodule
