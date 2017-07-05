`include "header.v"

module painter(
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
	paint_x_co,
	paint_y_co,
	// output : The output for the coordinates of x and y
	color,
	// output : The color information which is going to be written to memory
	print_enable
	// output : The output indicating starting to write information to the memory
	);
	

	reg [2:0] PAINTING_STAGE;
	reg [`BOARD_WIDTH_BITS - 1 : 0] board_x;
	reg [`BOARD_HEIGHT_BITS - 1 : 0] board_y;

	reg [`SCR_WIDTH_BITS - 1 : 0] pixel_x_start, pixel_x_end;
	reg [`SCR_HEIGHT_BITS - 1 : 0] pixel_y_start, pixel_y_end;

	reg paint_chess_start_working;
	reg [3:0] what_is_painted;
	reg [31:0] counter;



	localparam 	PAINTING_BOARD = 3'd00,
				PAINTING_CHESS_LOAD1 = 3'd01,
				PAINTING_CHESS_LOAD2 = 3'd02,
				PAINTING_CHESS_LOAD3 = 3'd03,
				PAINTING_CHESS_LOAD4 = 3'd04,
				PAINTING_CHESS = 3'd03,
				PAINTING_POINT = 3'd04,
				PAINTING_UPPER = 3'd05,
				NOTHING_PAINTED = 3'd0,
				CHESSES_PAINTED = 3'd1,
				CHESSES_NOT_PAINTED_YET = 3'd2,
				POINTER_PAINTED = 3'd3;

	initial
	begin
	  PAINTING_STAGE = PAINTING_BOARD;
	  board_x = 0;
	  board_y = 0;
	  counter = 0;
	  chesses_painted = 0;
	  pixel_x_start = 0;
	  pixel_x_end = 0;
	  pixel_y_start = 0;
	  pixel_y_end = 0;
	  what_is_painted = NOTHING_PAINTED;
	  paint_chess_start_working = 0;
	end


	always@(posedge Clck)
	begin
		case(PAINTING_STAGE)
		PAINTING_BOARD : PAINTING_STAGE = PAINTING_CHESS_LOAD1;
		PAINTING_CHESS_LOAD1 :
			begin
				if(board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS] != `CHESS_WITH_NONE)
				begin
					pixel_x_start = `MAP_BOARDXCO_PIXELXCOSTART(board_x);
					pixel_x_end = `MAP_BOARDXCO_PIXELXCOEND(board_x);
					pixel_y_start = `MAP_BOARDYCO_PIXELYCOSTART(board_y);
					pixel_y_end = `MAP_BOARDYCO_PIXELYCOEND(board_y);
					PAINTING_STAGE = PAINTING_CHESS_LOAD2;
					color = board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS];
					counter = (pixel_x_end - pixel_x_start) * (pixel_y_end - pixel_y_start) * `ENSURE + 10;
					paint_chess_start_working = 1;
				end
				else
					PAINTING_STAGE = PAINTING_CHESS_LOAD1;
				
				// Change board_x, board_y, move to next location
				if(board_x == `BOARD_WIDTH - 1 && board_y == `BOARD_HEIGHT - 1)
				begin
				  board_x = 0;
				  board_y = 0;
				  what_is_painted = CHESSES_PAINTED;
				end
				else
					if(board_x == `BOARD_WIDTH - 1)
					begin
				  		board_x = 0;
				  		board_y = board_y + 1;
						what_is_painted = CHESSES_NOT_PAINTED_YET;
					end
					else
						board_x = board_x + 1;
						what_is_painted = CHESSES_NOT_PAINTED_YET;
				
			end
		PAINTING_CHESS_LOAD2:
			PAINTING_STAGE = PAINTING_CHESS_LOAD3;
		PAINTING_CHESS_LOAD3:
			PAINTING_STAGE = PAINTING_CHESS_LOAD4;		
		PAINTING_CHESS_LOAD4:
			// close working signal
			paint_chess_start_working = 0;
			PAINTING_STAGE = PAINTING_CHESS;
		PAINTING_CHESS:
		begin
		  if(counter == 0)
		  begin
		  	// Jumpping.
			case(what_is_painted)
			CHESSES_NOT_PAINTED_YET :
				PAINTING_STAGE = PAINTING_CHESS_LOAD1;
			CHESSES_PAINTED :
				PAINTING_STAGE = PAINTING_POINT;
			POINTER_PAINTED :
				PAINTING_STAGE = PAINTING_UPPER;
			default :
				PAINTING_STAGE = PAINTING_BOARD;
		  end
		  else
		  	counter = counter - 1;
		end
		PAINTING_POINT:
		begin
		  	pixel_x_start = `MAP_BOARDXCO_PIXELXCOSTART(pointer_loc_x);
			pixel_x_end = `MAP_BOARDXCO_PIXELXCOEND(pointer_loc_x);
			pixel_y_start = `MAP_BOARDYCO_PIXELYCOSTART(pointer_loc_y);
			pixel_y_end = `MAP_BOARDYCO_PIXELYCOEND(pointer_loc_y);
			PAINTING_STAGE = PAINTING_CHESS_LOAD2;
			color = 3'b100;
			counter = (pixel_x_end - pixel_x_start) * (pixel_y_end - pixel_y_start) * `ENSURE + 10;
			paint_chess_start_working = 1;
			what_is_painted = POINTER_PAINTED;
		end
		PAINTING_UPPER:
			PAINTING_STAGE = PAINTING_BOARD;
		endcase

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
	paint_x_co,
	paint_y_co,
	// output : the video coordinates to write with
	print_enable,
	// output : the enabling for writing
	Clck,
	// input : Clock,
	working
	// input : indicating start working, continue for one clock cycle is ok
);

input [`SCR_WIDTH_BITS - 1 : 0] pixel_x_start, pixel_x_end;
input [`SCR_HEIGHT_BITS - 1 : 0] pixel_y_start, pixel_y_end;
input Clck, in_cont_signal, pixel_load_signal;

output reg print_enable;


	localparam
		CP_LOAD_VAL = 3'd0,
		CP_PAINT_EN = 3'd1,
		CP_PAINT_EN_WAIT = 3'd2,
		CP_PAINT_DE = 3'd2,
		CP_NEXT_VAL = 3'd3,
		CP_WAITING_FOR_START = 3'd4;
		COLOR_BLACK = 3'b000,
		COLOR_BLUE  = 3'b001,
		COLOR_YELLOW= 3'b110;
		// BOARD_PAINTING = 2'd0,
		// CHESS_PAINTING = 2'd1,
		// POINTER_PAINTING = 2'd2,
		// UPPER_PAINTING = 2'd3,
		// FINDING = 1'd0,
		// PAINTING = 1'd1;
	
reg [2:0] CHESS_PAINTING_STAGE;
reg [`SCR_WIDTH_BITS - 1 : 0] pixel_x, pixel_x_reco_start, pixel_x_reco_end;
reg [`SCR_HEIGHT_BITS - 1 : 0] pixel_y, pixel_y_reco_start, pixel_y_reco_end;

	initial
	begin
	  paint_x_co = 0;
	  paint_y_co = 0;
	  print_enable = 0;
	  CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;
	  pixel_x_reco_start = 0;
	  pixel_x_reco_end = 0;
	  pixel_y_reco_start = 0;
	  pixel_y_reco_end = 0;
	end
	always@(pixel_load_signal)
	begin

	end

	always@(posedge Clck)
	begin
		// Draw first, then change coordinates of pixel
					case(CHESS_PAINTING_STAGE)
					CP_WAITING_FOR_START:
						if(working == 1)
						begin
						  pixel_x = pixel_x_start;
						  pixel_y = pixel_y_start;
						  CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						end
						else
						  CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;
					CP_LOAD_VAL :
					begin
						paint_x_co = pixel_x;
						paint_y_co = pixel_y;
						
						CHESS_PAINTING_STAGE = CP_PAINT_EN;
					end		
					CP_PAINT_EN :
					begin
						print_enable = 1;
						CHESS_PAINTING_STAGE = CP_PAINT_EN_WAIT1;
					end
					CP_PAINT_EN_WAIT1 :
					  CHESS_PAINTING_STAGE = CP_PAINT_EN_WAIT2;
					CP_PAINT_EN_WAIT2 :
					  CHESS_PAINTING_STAGE = CP_PAINT_DE;
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
							CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;	
						end
						else
						if(pixel_x == pixel_x_end - 1)
						begin
							pixel_y = pixel_y + 1;
							pixel_x = pixel_x_start;
							CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						end
						else
						begin
							pixel_x = pixel_x + 1;
							CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						end
					end
					endcase
		  

	end




endmodule
