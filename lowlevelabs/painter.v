`include header.v

module painter(
	in_cont_signal,
	// input : The signal to start 
	out_cont_signal,
	// output: The signal for next continuation to start
	next_out_cont_signal,
	// input : indicating the next continuation is finished, going to the next after the next
	board,
	// input : the huge number of wires indicating a board
	winning_information,
	// input : the information about winning status
	pointer_loc_x,
	pointer_loc_y,
	// input : the information of pointer location
	Clck,
	// input : the clock
	Reset,
    // input : indicating the reset
	address,
	// output : The output for the next memaddress to write in
	color,
	// output : The color information which is going to be written to memory
	print_enable
	// output : The output indicating starting to write information to the memory
	);

	input in_cont_signal, next_out_cont_signal, Clck, Reset;
	input [`BOARD_SIZE - 1:0] board;
	input [`WINNING_STATUS_BITS - 1 : 0] winning_information;
	input [`BOARD_WIDTH_BITS - 1:0] pointer_loc_x;
	input [`BOARD_HEIGHT_BITS - 1:0] pointer_loc_y;
	output reg out_cont_signal, print_enable;
	output [`MEMORY_SIZE_BITS - 1 : 0] address;

	output reg [2:0] color;


	localparam
		CP_LOAD_VAL = 2'd0,
		CP_PAINT_EN = 2'd1,
		CP_PAINT_DE = 2'd2,
		CP_NEXT_VAL = 2'd3,
		POINTERP_LOAD_VAL = 2'd0,
		POINTERP_PAINT = 2'd1,
		COLOR_BLACK = 3'b010,
		COLOR_BLUE  = 3'b001,
		COLOR_YELLOW= 3'b110,
		BOARD_PAINTING = 2'd0,
		CHESS_PAINTING = 2'd1,
		POINTER_PAINTING = 2'd2,
		UPPER_PAINTING = 2'd3,
		FINDING = 1'd0,
		PAINTING = 1'd1;
		

	reg [1:0] PAINTING_STAGE;
	reg [1:0] POINTER_PAINTING_STAGE;
	reg [`BOARD_WIDTH_BITS - 1 : 0] board_x;
	reg [`BOARD_HEIGHT_BITS - 1 : 0] board_y;
	reg [`SCR_WIDTH_BITS - 1 : 0] pixel_x_start, pixel_x_end;
	reg [`SCR_HEIGHT_BITS - 1 : 0] pixel_y_start, pixel_y_end;
	reg CHESS_CYCLE;
	reg [1:0] CHESS_PAINTING_STAGE;
	reg start_paint_chess,  paint_chess_load;
	wire end_paint_chess;

	initial
	begin
		board_x = 0;
		board_y = 0;
		// pixel_x = 0;
		// pixel_y = 0;
		pixel_x_start = 0;
		pixel_y_start = 0;
		pixel_x_end = 0;
		pixel_y_end = 0;
		PAINTING_STAGE = BOARD_PAINTING;
		CHESS_CYCLE = FINDING;
		color = 0;
		POINTER_PAINTING_STAGE = POINTERP_LOAD_VAL;
		CHESS_PAINTING_STAGE = 2'b0;
		start_paint_chess = 0;
		paint_chess_load = 0;
	end



	
	paint_chess pc(
		.pixel_x_start(pixel_x_start),
	// input : the start point for x coordinate
		.pixel_y_start(pixel_y_start),
	// input : the start point for y coordinate
		.pixel_x_end(pixel_x_end),
	// input : the end point for x  coordinate
		.pixel_y_end(pixel_y_end),
	// input : the end point for y coordinate
		.address(address),
	// output : the Video memory address to write
		.print_enable(print_enable),
	// output : the enabling for writing
		.Clck(Clck),
	// input : Clock,
		.in_cont_signal(start_paint_chess),
	// input : The signal indicating start working
		.out_cont_signal(end_paint_chess),
	// output : The signal indicating this work has been finished
		.pixel_load_signal(paint_chess_load)
	// input : The signal to flash the pixel_x, pixel_y
	);

	always@(posedge Clck)
	begin
		if(Reset == 0)
		begin
		end
		else
		if(in_cont_signal == 1 && out_cont_signal == 0)
		begin
			if(PAINTING_STAGE == BOARD_PAINTING)
			begin
				PAINTING_STAGE = CHESS_PAINTING;
			end

			if(PAINTING_STAGE == CHESS_PAINTING)
			begin
				if(CHESS_CYCLE == FINDING)
				begin
					if(board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS] != `CHESS_WITH_NONE)
					begin
						CHESS_CYCLE = PAINTING;

						case(board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS])
						`CHESS_WITH_BLACK: color = COLOR_BLACK;
						`CHESS_WITH_BLUE : color = COLOR_BLUE;
						`CHESS_WITH_WIN: color = COLOR_YELLOW;
						`CHESS_WITH_NONE : color = COLOR_BLACK;
						endcase

						pixel_x_start = `MAP_XCO_PIXELXCOSTART(board_x);
						pixel_y_start = `MAP_YCO_PIXELYCOSTART(board_y);
						pixel_x_end = `MAP_XCO_PIXELXCOEND(board_x);
						pixel_y_end = `MAP_YCO_PIXELYCOEND(board_y);
						// pixel_x = pixel_x_start;
						// pixel_y = pixel_y_start;
						paint_chess_load = ~paint_chess_load;
						start_paint_chess = 1;
							
					end

					
						if(board_x == `BOARD_WIDTH - 1 &&
							board_y == `BOARD_HEIGHT - 1)
						begin
							PAINTING_STAGE = POINTER_PAINTING;
							CHESS_CYCLE = FINDING;

						end
						else
						if(board_x == `BOARD_WIDTH - 1)
						begin
							board_y = board_y + 1;
							board_x = 0;
						end
						else
							board_x = board_x + 1;
					

				end	
				else // (CHESS_CYCLE == PAINTING)
				begin 
					if(end_paint_chess == 1)
					begin
					  start_paint_chess = 0;
					  CHESS_CYCLE = FINDING;
					end

				end
			end

			if(PAINTING_STAGE == POINTER_PAINTING)
			begin
			  if(POINTER_PAINTING_STAGE == POINTERP_LOAD_VAL)
			  begin
			  	pixel_x_start = `MAP_POINTERCO_PIXELCO(pointer_loc_x);
				pixel_y_start = `MAP_POINTERCO_PIXELCO(pointer_loc_y);
				pixel_x_end = `MAP_POINTERCO_PIXELCOEND(pointer_loc_x);
				pixel_y_end = `MAP_POINTERCO_PIXELCOEND(pointer_loc_y);
				POINTER_PAINTING_STAGE = POINTER_PAINTING;
				start_paint_chess = 1;
			  end
			  else
			  begin
				if(end_paint_chess == 1)
				begin
				  start_paint_chess = 0;
				  POINTER_PAINTING_STAGE = POINTERP_LOAD_VAL;
				  PAINTING_STAGE = UPPER_PAINTING;
				end
			  end
			end

			if(PAINTING_STAGE == UPPER_PAINTING)
			begin
				PAINTING_STAGE = BOARD_PAINTING;
				out_cont_signal = 1;
				address = 0;
			end

			



		end
		else
		begin
		  if(next_out_cont_signal == 1)
		  	out_cont_signal = 0;


		end
	

	end

endmodule


module paint_chess(
	pixel_x_start,
	// input : the start point for x coordinate
	pixel_y_start,
	// input : the start point for y coordinate
	pixel_x_end,
	// input : the end point for x  coordinate
	pixel_y_end,
	// input : the end point for y coordinate
	address,
	// output : the Video memory address to write
	print_enable,
	// output : the enabling for writing
	Clck,
	// input : Clock,
	in_cont_signal,
	// input : The signal indicating start working
	out_cont_signal,
	// output : The signal indicating this work has been finished
	pixel_load_signal
	// input : The signal to flash the pixel_x, pixel_y
);

input [`SCR_WIDTH_BITS - 1 : 0] pixel_x_start, pixel_x_end;
input [`SCR_HEIGHT_BITS - 1 : 0] pixel_y_start, pixel_y_end;
input Clck, in_cont_signal, pixel_load_signal;
output reg [`MEMORY_SIZE_BITS - 1 : 0] address;
output reg print_enable, out_cont_signal;


	localparam
		CP_LOAD_VAL = 2'd0,
		CP_PAINT_EN = 2'd1,
		CP_PAINT_DE = 2'd2,
		CP_NEXT_VAL = 2'd3,
		COLOR_BLACK = 3'b000,
		COLOR_BLUE  = 3'b001,
		COLOR_YELLOW= 3'b110,
		BOARD_PAINTING = 2'd0,
		CHESS_PAINTING = 2'd1,
		POINTER_PAINTING = 2'd2,
		UPPER_PAINTING = 2'd3,
		FINDING = 1'd0,
		PAINTING = 1'd1;
	
reg [1:0] CHESS_PAINTING_STAGE;
reg [`SCR_WIDTH_BITS - 1 : 0] pixel_x, pixel_x_reco_start, pixel_x_reco_end;
reg [`SCR_HEIGHT_BITS - 1 : 0] pixel_y, pixel_y_reco_start, pixel_y_reco_end;

	initial
	begin
	  address = 0;
	  out_cont_signal = 0;
	  print_enable = 0;
	  CHESS_PAINTING_STAGE = CP_LOAD_VAL;
	  pixel_x_reco_start = 0;
	  pixel_x_reco_end = 0;
	  pixel_y_reco_start = 0;
	  pixel_y_reco_end = 0;
	end
	always@(pixel_load_signal)
	begin
	  pixel_x <= pixel_x_start;
	  pixel_y <= pixel_y_start;
	end

	always@(posedge Clck)
	begin
	  if(in_cont_signal == 1 &&
	  out_cont_signal == 0)
	  begin

		// Draw first, then change coordinates of pixel
					case(CHESS_PAINTING_STAGE)
					CP_LOAD_VAL :
					begin
						address = `MAP_PIXELCO_MEMADDR(pixel_x, pixel_y);
						print_enable = 1;
						CHESS_PAINTING_STAGE = CP_PAINT_EN;
					end		
					CP_PAINT_EN :
					begin
						print_enable = 1;
						CHESS_PAINTING_STAGE = CP_PAINT_DE;
					end
					CP_PAINT_DE :
					begin
						print_enable = 0;
						CHESS_PAINTING_STAGE = CP_NEXT_VAL;
					end
					CP_NEXT_VAL :
					begin
						if(pixel_x == pixel_x_end - 1 &&
							pixel_y == pixel_y_end - 1)
						begin
							out_cont_signal = 1;	
						end
						else
						if(pixel_x == pixel_x_end - 1)
						begin
							pixel_y = pixel_y + 1;
							pixel_x = pixel_x_start;
						end
						else
							pixel_x = pixel_x + 1;
						CHESS_PAINTING_STAGE = CP_LOAD_VAL;
					end
					endcase
	  end
	  else
	  if(in_cont_signal == 0)
	  	out_cont_signal = 0;
		  

	end




endmodule
