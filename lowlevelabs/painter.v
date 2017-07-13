`include "header.v"


`define PAINTING_CONFIG_SQUARE 3'b000
`define PAINTING_CONFIG_CIRCLE 3'b001


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
	paint_x_co_all_dimension,
	paint_y_co_all_dimension,
	// output : The output for the coordinates of x and y
	color_all_dimension_output,
	// output : The color information which is going to be written to memory
	print_enable_all_dimension
	// output : The output indicating starting to write information to the memory
	);
	
	input [`BOARD_SIZE_BITS - 1 : 0] board;
	input [`WINNING_STATUS_BITS - 1 : 0] winning_information;
	input [`BOARD_WIDTH_BITS - 1 : 0] pointer_loc_x;
	input [`BOARD_HEIGHT_BITS - 1 : 0] pointer_loc_y;
	input Clck, Reset;
	output print_enable_all_dimension;
	output [`COLOR_SIZE - 1 : 0] color_all_dimension_output; 
	output [`SCR_WIDTH_BITS - 1 : 0] paint_x_co_all_dimension;
	output [`SCR_HEIGHT_BITS - 1 : 0] paint_y_co_all_dimension;

	
	reg [`COLOR_SIZE - 1 : 0] color_input;
	wire [`COLOR_SIZE - 1 : 0] color, color_board, color_vic, color_vic_chess;


	wire [`SCR_WIDTH_BITS - 1 : 0] paint_x_co_chess, paint_x_co_board, paint_x_co_vic, paint_x_co_vic_chess;
	wire [`SCR_HEIGHT_BITS - 1 : 0] paint_y_co_chess, paint_y_co_board, paint_y_co_vic, paint_y_co_vic_chess;
	wire print_enable_chess, print_enable_board, print_enable_vic, print_enable_vic_chess;



	reg [4:0] PAINTING_STAGE;
	reg [2:0] PAINTING_CONFIG;
	reg [`BOARD_WIDTH_BITS : 0] board_x;
	reg [`BOARD_HEIGHT_BITS : 0] board_y;
	reg [`SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE - 1 : 0] bare_board, victory_pic ;

	reg [`SCR_WIDTH_BITS - 1 : 0] pixel_x_start, pixel_x_end;
	reg [`SCR_HEIGHT_BITS - 1 : 0] pixel_y_start, pixel_y_end;

	reg paint_chess_start_working, paint_board_start_working, paint_vic_start_working, paint_vic_chess_start_working;
	reg [2:0] what_is_painted;
	reg [31:0] counter;

	assign color_all_dimension_output = color | color_board | color_vic | color_vic_chess;
	assign paint_x_co_all_dimension = paint_x_co_chess | paint_x_co_board | paint_x_co_vic | paint_x_co_vic_chess;
	assign paint_y_co_all_dimension = paint_y_co_chess | paint_y_co_board | paint_y_co_vic | paint_y_co_vic_chess;
	assign print_enable_all_dimension = print_enable_chess | print_enable_board | print_enable_vic | print_enable_vic_chess;



	localparam 	PAINTING_BOARD = 5'd0,
				PAINTING_CHESS_LOAD1 = 5'd1,
				PAINTING_CHESS_LOAD2 = 5'd2,
				PAINTING_CHESS_LOAD3 = 5'd3,
				PAINTING_CHESS_LOAD4 = 5'd4,
				PAINTING_CHESS = 5'd5,
				PAINTING_POINT = 5'd6,
				PAINTING_UPPER = 5'd7,
				PAINTING_BOARD_LOAD1 = 5'd8,
				PAINTING_BOARD_LOAD2 = 5'd9,
				PAINTING_BOARD_WAIT = 5'd10,
				PAINTING_VICTORY = 5'd11,
				PAINTING_VICTORY_LOAD1 = 5'd12,
				PAINTING_VICTORY_LOAD2 = 5'd13,
				PAINTING_VICTORY_WAIT = 5'd14,
				PAINTING_VICTORY_CHESS = 5'd15,
				PAINTING_VICTORY_CHESS_LOAD1 = 5'd16,
				PAINTING_VICTORY_CHESS_LOAD2 = 5'd17,
				PAINTING_VICTORY_CHESSS_WAIT = 5'd18,
				PAINTING_DEAD = 5'd19,
				NOTHING_PAINTED = 3'd0,
				CHESSES_PAINTED = 3'd1,
				CHESSES_NOT_PAINTED_YET = 3'd2,
				POINTER_PAINTED = 3'd3,
				VICTORY_CHESS_PAINTED = 3'd4;
				
	reg board_bin [`SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE - 1:0];
	reg victory_bin [`SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE - 1:0];
	reg [31 : 0] i;
	
	initial
	begin
	  PAINTING_STAGE = PAINTING_BOARD;
	  PAINTING_CONFIG = `PAINTING_CONFIG_SQUARE;
	  board_x = 0;
	  board_y = 0;
	  counter = 0;
	  pixel_x_start = 0;
	  pixel_x_end = 0;
	  pixel_y_start = 0;
	  pixel_y_end = 0;
	  what_is_painted = NOTHING_PAINTED;
	  paint_chess_start_working = 0;
	  paint_board_start_working = 0;
	  paint_chess_start_working = 0;
	  paint_vic_chess_start_working = 0;
	  paint_vic_start_working = 0;
	  color_input = 0;
	  $readmemb("board_out.ppm", board_bin);
	  $readmemb("victory_out.ppm", victory_bin);
	  for(i = 0; i < `SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE; i=i+1)
	  begin
	  	bare_board[i +: 1] = board_bin[i];
		victory_pic[i +: 1] = victory_bin[i];
		//$write(victory_bin[i]);
		//$write(" ");
	  end

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
	.paint_x_co(paint_x_co_chess),
	.paint_y_co(paint_y_co_chess),
	// output : the video coordinates to write with
	.print_enable(print_enable_chess),
	// output : the enabling for writing
	.Clck(Clck),
	// input : Clock,
	.working(paint_chess_start_working),
	// input : indicating start working, continue for one clock cycle is ok
	.configure(PAINTING_CONFIG),
	// input : the configurance
	.color(color_input),
	// input : the input preference color 
	.color_output(color),
	// output : the real output color
	.Reset(Reset)
	);

	paint_pic paint_board(
	.working(paint_board_start_working),
	// input : indicating working started, 
	.Clck(Clck),
	// input : the clock pulse
	.board_pic(bare_board),
	// input : at maximum size of `SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE
	.pixel_x_start(`SCR_WIDTH_BITS'd0),
	// input : indicating the start point of the pixel_x_co
	.pixel_x_end(`SCR_WIDTH_BITS'd`SCR_WIDTH),
	// input : indicating the start point of the pixel_x_co
	.pixel_y_start(`SCR_HEIGHT_BITS'd0),
	// input : indicating the start point of the pixel_x_co
	.pixel_y_end(`SCR_HEIGHT_BITS'd`SCR_HEIGHT),
	// input : indicating the start point of the pixel_x_co
	.pixel_x_co(paint_x_co_board),
	.pixel_y_co(paint_y_co_board),
	// output : indicating which coordinate should be written to
	.color_output(color_board),
	// output : the color to output to vga
	.print_enable(print_enable_board)
	// output : make vga working now
	);

	paint_pic paint_vic(
	.working(paint_vic_start_working),
	// input : indicating working started, 
	.Clck(Clck),
	// input : the clock pulse
	.board_pic(victory_pic),
	// input : at maximum size of `SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE
	.pixel_x_start(`SCR_WIDTH_BITS'd0),
	// input : indicating the start point of the pixel_x_co
	.pixel_x_end(`SCR_WIDTH_BITS'd80),
	// input : indicating the start point of the pixel_x_co
	.pixel_y_start(`SCR_HEIGHT_BITS'd0),
	// input : indicating the start point of the pixel_x_co
	.pixel_y_end(`SCR_HEIGHT_BITS'd31),
	// input : indicating the start point of the pixel_x_co
	.pixel_x_co(paint_x_co_vic),
	.pixel_y_co(paint_y_co_vic),
	// output : indicating which coordinate should be written to
	.color_output(color_vic),
	// output : the color to output to vga
	.print_enable(print_enable_vic)
	// output : make vga working now
	);


	paint_chess victory_chess(
	.pixel_x_start(`SCR_WIDTH_BITS'd80),
	// input : the start point for x coordinate
	.pixel_y_start(`SCR_HEIGHT_BITS'd0),
	// input : the start point for y coordinate
	.pixel_x_end(`SCR_WIDTH_BITS'd112),
	// input : the end point for x  coordinate
	.pixel_y_end(`SCR_WIDTH_BITS'd31),
	// input : the end point for y coordinate
	.paint_x_co(paint_x_co_vic_chess),
	.paint_y_co(paint_y_co_vic_chess),
	// output : the video coordinates to write with
	.print_enable(print_enable_vic_chess),
	// output : the enabling for writing
	.Clck(Clck),
	// input : Clock,
	.working(paint_vic_chess_start_working),
	// input : indicating start working, continue for one clock cycle is ok
	.configure(`PAINTING_CONFIG_CIRCLE),
	// input : the configurance
	.color(color_input),
	// input : the input preference color 
	.color_output(color_vic_chess),
	// output : the real output color
	.Reset(Reset)

	);

	always@(posedge Clck)
	begin
		if(Reset == 0)
		begin
			PAINTING_STAGE = PAINTING_BOARD;
	  		board_x = 0;
	  		board_y = 0;
	  		counter = 0;
	  		pixel_x_start = 0;
	  		pixel_x_end = 0;
	  		pixel_y_start = 0;
	  		pixel_y_end = 0;
	  		what_is_painted = NOTHING_PAINTED;
	  		paint_chess_start_working = 0;
			PAINTING_CONFIG = `PAINTING_CONFIG_SQUARE;
		end
		else
		case(PAINTING_STAGE)
		PAINTING_BOARD : 
		begin
			paint_board_start_working = 1;
			PAINTING_STAGE = PAINTING_BOARD_LOAD1;  
		end
		PAINTING_BOARD_LOAD1 :
			PAINTING_STAGE = PAINTING_BOARD_LOAD2;
		PAINTING_BOARD_LOAD2 :
		begin
			PAINTING_STAGE = PAINTING_BOARD_WAIT;
			counter = `SCR_HEIGHT * `SCR_WIDTH * `ENSURE;
		end
		PAINTING_BOARD_WAIT :
		begin
		  paint_board_start_working = 0;
		  if(counter == 0)
		  	PAINTING_STAGE = PAINTING_POINT;
		  else
		  	counter = counter - 1;

		end
		PAINTING_CHESS_LOAD1 :
			begin
				if(board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS] != `CHESS_WITH_NONE)
				begin
					pixel_x_start = `MAP_BOARDXCO_PIXELXCOSTART(board_x);
					pixel_x_end = `MAP_BOARDXCO_PIXELXCOEND(board_x);
					pixel_y_start = `MAP_BOARDYCO_PIXELYCOSTART(board_y);
					pixel_y_end = `MAP_BOARDYCO_PIXELYCOEND(board_y);
					PAINTING_STAGE = PAINTING_CHESS_LOAD2;
					color_input = board[`MAP_BOARDXY_BOARDCO(board_x, board_y) +: `CHESS_STATUS_BITS];
					counter = (pixel_x_end - pixel_x_start) * (pixel_y_end - pixel_y_start) * `ENSURE + 10;
					PAINTING_CONFIG = `PAINTING_CONFIG_SQUARE;
					paint_chess_start_working = 1;
				end

				// Change board_x, board_y, move to next location
				if(board_y >= `BOARD_HEIGHT)
				begin
				  board_x = 0;
				  board_y = 0;
				  what_is_painted = CHESSES_PAINTED;
				  PAINTING_STAGE = PAINTING_UPPER;
				end
				else
					if(board_x >= `BOARD_WIDTH - 1)
					begin
				  		board_x = 0;
				  		board_y = board_y + 1'b1;
						what_is_painted = CHESSES_NOT_PAINTED_YET;
					end
					else
						board_x = board_x + 1'b1;
						what_is_painted = CHESSES_NOT_PAINTED_YET;
				
			end
		PAINTING_CHESS_LOAD2:
			PAINTING_STAGE = PAINTING_CHESS_LOAD3;
		PAINTING_CHESS_LOAD3:
			PAINTING_STAGE = PAINTING_CHESS_LOAD4;		
		PAINTING_CHESS_LOAD4:
			// close working signal
			begin
			paint_chess_start_working = 0;
			PAINTING_STAGE = PAINTING_CHESS;
			end
		PAINTING_CHESS:
		begin
		  if(counter == 0)
		  begin
		  	// Jumpping.
			case(what_is_painted)
			CHESSES_NOT_PAINTED_YET :
				PAINTING_STAGE = PAINTING_CHESS_LOAD1;
			CHESSES_PAINTED :
				PAINTING_STAGE = PAINTING_UPPER;
			POINTER_PAINTED :
				PAINTING_STAGE = PAINTING_CHESS_LOAD1;
			default :
				PAINTING_STAGE = PAINTING_BOARD;
			endcase
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
			color_input = 3'b100;
			counter = (pixel_x_end - pixel_x_start) * (pixel_y_end - pixel_y_start) * `ENSURE + 10;
			PAINTING_CONFIG = `PAINTING_CONFIG_SQUARE;
			paint_chess_start_working = 1;
			what_is_painted = POINTER_PAINTED;
		end
		PAINTING_UPPER:
		begin
		  if(winning_information == `WINNING_GAMING)
		  	PAINTING_STAGE = PAINTING_BOARD;
		  else
		  begin
			PAINTING_STAGE = PAINTING_VICTORY;
		  end
		end

		PAINTING_VICTORY:
		begin
		  paint_vic_start_working = 1;
		  PAINTING_STAGE = PAINTING_VICTORY_LOAD1;
		end
		PAINTING_VICTORY_LOAD1:
		  PAINTING_STAGE = PAINTING_VICTORY_LOAD2;
		PAINTING_VICTORY_LOAD2:
		begin
		  PAINTING_STAGE = PAINTING_VICTORY_WAIT;
		  counter = 79 * 31 * `ENSURE;
		end
		  
		PAINTING_VICTORY_WAIT:
		begin
		  paint_vic_start_working = 0;
		  if(counter == 0)
		  	PAINTING_STAGE = PAINTING_VICTORY_CHESS;
		  else
		  	counter = counter - 1;
		end

		PAINTING_VICTORY_CHESS:
		begin
		  paint_vic_chess_start_working = 1;
		  PAINTING_STAGE = PAINTING_VICTORY_CHESS_LOAD1;
		end
		PAINTING_VICTORY_CHESS_LOAD1:
			PAINTING_STAGE = PAINTING_VICTORY_CHESS_LOAD2;
		PAINTING_VICTORY_CHESS_LOAD2: // No more waiting, it just stop working right away.
			PAINTING_STAGE = PAINTING_VICTORY_CHESSS_WAIT;	
		PAINTING_VICTORY_CHESSS_WAIT:
			begin
			  paint_vic_chess_start_working = 0;
			  PAINTING_STAGE = PAINTING_DEAD;
			end
		PAINTING_DEAD:
			PAINTING_STAGE = PAINTING_DEAD;
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
	working,
	// input : indicating start working, continue for one clock cycle is ok
	configure,
	// input : the configurance
	color,
	// input : the input preference color 
	color_output,
	// output : the real output color
	Reset
	// input : the reset
);

input [`SCR_WIDTH_BITS - 1: 0] pixel_x_start, pixel_x_end;
input [`SCR_HEIGHT_BITS- 1: 0] pixel_y_start, pixel_y_end;
input Clck, working, Reset;
input [`COLOR_SIZE - 1 : 0] color;
input [2:0] configure;
output reg [`SCR_WIDTH_BITS - 1 : 0] paint_x_co;
output reg [`SCR_HEIGHT_BITS - 1 : 0] paint_y_co;
output reg [`COLOR_SIZE - 1 : 0] color_output;
output reg print_enable;


	localparam
		CP_LOAD_VAL = 3'd0,
		CP_PAINT_EN = 3'd1,
		CP_PAINT_EN_WAIT1 = 3'd2,
		CP_PAINT_EN_WAIT2 = 3'd3,
		CP_PAINT_DE = 3'd4,
		CP_NEXT_VAL = 3'd5,
		CP_WAITING_FOR_START = 3'd6,
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
reg [`SCR_WIDTH_BITS : 0] pixel_x, pixel_x_reco_start, pixel_x_reco_end;
reg [31:0] chess_radius, new_x, half_x;
reg [`SCR_HEIGHT_BITS : 0] pixel_y;

	initial
	begin
	  paint_x_co = 0;
	  paint_y_co = 0;
	  print_enable = 0;
	  color_output = 0;
	  CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;
	  pixel_x_reco_start = 0;
	  pixel_x_reco_end = 0;
	end

	always@(posedge Clck)
	begin
		if(Reset == 0)
		begin
			paint_x_co = 0;
	 		paint_y_co = 0;
	  		print_enable = 0;
	  		CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;
	  		pixel_x_reco_start = 0;
	  		pixel_x_reco_end = 0;
			color_output = 0;
			chess_radius = 0;
		end
		else
		// Draw first, then change coordinates of pixel
					case(CHESS_PAINTING_STAGE)
					CP_WAITING_FOR_START:
						if(working == 1)
						begin
						  half_x =  ({2'b0, pixel_x_start} + {2'b0, pixel_x_end}) / (2'd2);
						  	new_x = pixel_y - pixel_y_start;
							new_x = (new_x > chess_radius ? (new_x - chess_radius) : (chess_radius - new_x));
							new_x = (chess_radius * chess_radius * chess_radius - new_x * new_x * new_x) / (chess_radius * chess_radius);
						  chess_radius = (pixel_y_end - pixel_y_start) / (2'd2);
						  case(configure)
						  `PAINTING_CONFIG_CIRCLE:
						  begin
						  	pixel_x_reco_start = half_x - new_x;
						  	pixel_x_reco_end = half_x + new_x;
						  end
						  `PAINTING_CONFIG_SQUARE:
						  begin
						  	pixel_x_reco_start = pixel_x_start;
							pixel_x_reco_end = pixel_x_end;
						  end
						  endcase
						  pixel_x = pixel_x_reco_start;
						  pixel_y = pixel_y_start;
						  CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						  color_output = color;
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
						print_enable = 1'b1;
						CHESS_PAINTING_STAGE = CP_PAINT_EN_WAIT1;
					end
					CP_PAINT_EN_WAIT1 :
					  CHESS_PAINTING_STAGE = CP_PAINT_EN_WAIT2;
					CP_PAINT_EN_WAIT2 :
					  CHESS_PAINTING_STAGE = CP_PAINT_DE;
					CP_PAINT_DE :
					begin
						print_enable = 1'b0;
						CHESS_PAINTING_STAGE = CP_NEXT_VAL;
					end
					CP_NEXT_VAL :
					begin
						if(pixel_x >= pixel_x_reco_end - 1 &&
							pixel_y >= pixel_y_end - 1)
						begin
							CHESS_PAINTING_STAGE = CP_WAITING_FOR_START;
							paint_x_co = 0;
							paint_y_co = 0;
							color_output = 0;
							print_enable = 0;
						end
						else
						if(pixel_x >= pixel_x_reco_end - 1)
						begin
							pixel_y = pixel_y + 1'b1;
							new_x = pixel_y - pixel_y_start;
							new_x = (new_x > chess_radius ? (new_x - chess_radius) : (chess_radius - new_x));
							new_x = (chess_radius * chess_radius * chess_radius - new_x * new_x * new_x) / (chess_radius * chess_radius);
							case(configure)
							`PAINTING_CONFIG_CIRCLE:
							begin
								pixel_x_reco_start = half_x - new_x;
								pixel_x_reco_end = half_x + new_x;
							end
							`PAINTING_CONFIG_SQUARE:
							begin
								pixel_x_reco_start = pixel_x_start;
								pixel_x_reco_end = pixel_x_end;
							end
							endcase
							pixel_x = pixel_x_reco_start;
							CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						end
						else
						begin
							pixel_x = pixel_x + 1'b1;
							CHESS_PAINTING_STAGE = CP_LOAD_VAL;
						end
					end
					endcase
		  

	end

endmodule



module paint_pic(
	working,
	// input : indicating working started, 
	Clck,
	// input : the clock pulse
	board_pic,
	// input : at maximum size of `SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE
	pixel_x_start,
	// input : indicating the start point of the pixel_x_co
	pixel_x_end,
	// input : indicating the start point of the pixel_x_co
	pixel_y_start,
	// input : indicating the start point of the pixel_x_co
	pixel_y_end,
	// input : indicating the start point of the pixel_x_co
	pixel_x_co,
	pixel_y_co,
	// output : indicating which coordinate should be written to
	color_output,
	// output : the color to output to vga
	print_enable
	// output : make vga working now
);
	

	input [`SCR_HEIGHT * `SCR_WIDTH * `COLOR_SIZE - 1 : 0] board_pic;
	input working, Clck;
	input [`SCR_WIDTH_BITS - 1: 0] pixel_x_start, pixel_x_end;
	input [`SCR_HEIGHT_BITS- 1: 0] pixel_y_start, pixel_y_end;
	output reg [`COLOR_SIZE - 1 : 0] color_output;
	output reg print_enable;
	output reg [`SCR_HEIGHT_BITS - 1: 0] pixel_x_co;
	output reg [`SCR_WIDTH_BITS - 1: 0] pixel_y_co;

	localparam 
		PRINTINGPIC_WAITING_FOR_START = 3'd0,
		PRINTINGPIC_LOAD = 3'd1,
		PRINTINGPIC_EN1 = 3'd2,
		PRINTINGPIC_EN2 = 3'd3,
		PRINTINGPIC_DE = 3'd4,
		PRINTINGPIC_NEXT_VAL = 3'd5,
		PRINTINGPIC_END = 3'd6;


	reg [2:0] PRINT_PIC_STATUS;

	reg [`SCR_HEIGHT_BITS - 1: 0] pixel_x;
	reg [`SCR_WIDTH_BITS - 1: 0] pixel_y;

	initial
	begin
	  PRINT_PIC_STATUS = PRINTINGPIC_WAITING_FOR_START;
	  pixel_x_co = 0;
	  pixel_y_co = 0;
	  print_enable = 0;
	  color_output = 0;

	end 

	always@(posedge Clck) begin
	  case(PRINT_PIC_STATUS)
	  PRINTINGPIC_WAITING_FOR_START :
	  begin
		if(working == 1'b1) begin
		  pixel_x = pixel_x_start;
		  pixel_y = pixel_y_start;
		  PRINT_PIC_STATUS = PRINTINGPIC_LOAD;
		end
	  end
	  PRINTINGPIC_LOAD:
	  begin
`define MAP_XYPIXELCO_REGCO(x,y) (x * `COLOR_SIZE + y * `COLOR_SIZE * (pixel_x_end - pixel_x_start))
		color_output = board_pic[`MAP_XYPIXELCO_REGCO(pixel_x, pixel_y) +: `COLOR_SIZE];
		pixel_x_co = pixel_x;
		pixel_y_co = pixel_y;
		print_enable = 1;
		PRINT_PIC_STATUS = PRINTINGPIC_EN1;
	  end
	  PRINTINGPIC_EN1:
	  	PRINT_PIC_STATUS = PRINTINGPIC_EN2;
	  PRINTINGPIC_EN2:
	  	PRINT_PIC_STATUS = PRINTINGPIC_DE;
	  PRINTINGPIC_DE:
	  begin
		print_enable = 0;
		PRINT_PIC_STATUS = PRINTINGPIC_NEXT_VAL;
	  end
	  	
	  PRINTINGPIC_NEXT_VAL:
	  begin
		if(pixel_x >= pixel_x_end - 1 &&
			pixel_y >= pixel_y_end - 1)
		begin 
			//END:
			PRINT_PIC_STATUS = PRINTINGPIC_WAITING_FOR_START;
			pixel_x_co = 0;
			pixel_y_co = 0;
			print_enable = 0;
			color_output = 0;
		end
		else
			if(pixel_x >= pixel_x_end - 1)
			begin
			  pixel_x = pixel_x_start;
			  pixel_y = pixel_y + 1'b1;
			  PRINT_PIC_STATUS = PRINTINGPIC_LOAD;
			end
			else
			begin
			  PRINT_PIC_STATUS = PRINTINGPIC_LOAD;
			  pixel_x = pixel_x + 1'b1;
			end
				
	  end
	  endcase



	end


endmodule
