

`define CO_TO_OFFSET(x, y) (x * 2 + y * 16 * 2)

module FiveSons(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
);

	input			CLOCK_50;				//	50 MHz
	input   [17:0]   SW;
	input   [3:0]   KEY;

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

    reg [511 : 0] board;

llabs labs(
	.working(KEY[0]),
	// input : change indicating startworking, can't be stopped
	.Clck(CLOCK_50),
	// input : the clock,
	.board(board),
	// input : the board status
	.gaming_status(gaming_status),
	// input : the status of gaming
	.pointer_loc_x(pointer_loc_x),
	.pointer_loc_y(pointer_loc_y),
	// inputs : the location of pointer, x, y coordinate
	.Reset(Reset),
	// inputs : the reset
	.VGA_CLK(VGA_CLK), // VGA_CLK;
	.VGA_HS(VGA_HS), // VGA_H_SYNC
	.VGA_VS(VGA_VS), // VGA_V_SYNC
	.VGA_BLANK_N(VGA_BLANK_N), // VGA_BLANK
	.VGA_SYNC_N(VGA_SYNC_N), //VGA SYNC
	.VGA_R(VGA_R), // VGA Red[9:0]
	.VGA_G(VGA_G), // VGA Green[9:0]
	.VGA_B(VGA_B) // VGA Blue[9:0]
);




    always@(*)
    begin
      if(KEY[1] == 1)
      begin
        board[`CO_TO_OFFSET(SW[3:0], SW[7:4]) +: 1] = 2'b01; 
      end
    end



endmodule
