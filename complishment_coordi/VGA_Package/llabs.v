`include "header.v"

module llabs(
	Clck,
	// input : the clock,
	board,
	// input : the board status
	gaming_status,
	// input : the status of gaming
	pointer_loc_x,
	pointer_loc_y,
	// inputs : the location of pointer, x, y coordinate
	Reset,
	// inputs : the reset
	VGA_CLK, // VGA_CLK;
	VGA_HS, // VGA_H_SYNC
	VGA_VS, // VGA_V_SYNC
	VGA_BLANK_N, // VGA_BLANK
	VGA_SYNC_N, //VGA SYNC
	VGA_R, // VGA Red[9:0]
	VGA_G, // VGA Green[9:0]
	VGA_B // VGA Blue[9:0]
);


	input Clck, Reset;
	input [`BOARD_SIZE_BITS - 1 : 0] board;
	input [`WINNING_STATUS_BITS - 1 : 0] gaming_status;
	input [`BOARD_WIDTH_BITS - 1 : 0] pointer_loc_x;
	input [`BOARD_HEIGHT_BITS - 1 : 0] pointer_loc_y;

 	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	wire [`SCR_WIDTH_BITS - 1 : 0] x_co;
	wire [`SCR_HEIGHT_BITS - 1 : 0] y_co;
	wire [`COLOR_SIZE - 1 : 0] color_output;
	wire print_enable;

 painter pt(
	.board(board),
	// input : the huge number of wires indicating a board
	.winning_information(gaming_status),
	// input : the information about winning status
	.pointer_loc_x(pointer_loc_x),
	.pointer_loc_y(pointer_loc_y),
	// input : the information of pointer location
	.Clck(Clck),
	// input : the clock
	.Reset(Reset),
    // input : indicating the reset
	.paint_x_co_all_dimension(x_co),
	.paint_y_co_all_dimension(y_co),
	// output : The output for the coordinates of x and y
	.color_all_dimension_output(color_output),
	// output : The color information which is going to be written to memory
	.print_enable_all_dimension(print_enable)
	// output : The output indicating starting to write information to the memory
	);

	vga_adapter VGA(
		.resetn(Reset),
		.clock(Clck),
		.colour(color_output),
		.x(x_co),
		.y(y_co),
		.plot(print_enable),
		/* Signals for the DC to drive the monitor. */
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK(VGA_BLANK_N),
		.VGA_SYNC(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK));
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA.BACKGROUND_IMAGE = "black.mif";








endmodule