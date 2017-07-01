

// Part 2 skeleton

`define STATE_SIZE 4
`define CMD_SIZE 5
`define COX_SIZE 8
`define COY_SIZE 7
`define RGB_SIZE 3

module lab6b
	(
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
	
	wire resetn;
	assign resetn = SW[17];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	wire [`STATE_SIZE : 0] present_state;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
		vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
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
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
    
    // Instansiate datapath
	// datapath d0(...);

    // Instansiate FSM control
    // control c0(...);
	wire [`CMD_SIZE:0] cmd; 
	FSM control(
		.clk(CLOCK_50),
		.START_LOAD(SW[16]),
		.GO(SW[15]),
		.RESET_N(resetn),
		.present_state(present_state));
	Datapath datapath(
		.clkk(CLOCK_50),
		.present_state(present_state),
		.SW(SW),
		.KEY(KEY),
		.XX(x),
		.YY(y),
		.PLOT(writeEn),
		.COLR(colour));
		
		
		

endmodule




module FSM(
	clk,
	START_LOAD,
	GO,
	RESET_N,
	present_state
);

	input START_LOAD,GO;
	input RESET_N;

	output reg[`STATE_SIZE : 0] present_state;
	reg[`STATE_SIZE : 0]  next_state;
	
	input clk;

	
	
	localparam INPUT_X = 5'd0, 
			   INPUT_Y = 5'd1,
			   INPUT_COLR = 5'd2,
			   DR17 = 5'd31,
			   DR1 = 5'd3,
			   DR2 = 5'd4,
			   DR3 = 5'd5,
			   DR4 = 5'd6,
			   DR5 = 5'd7,
			   DR6 = 5'd8,
			   DR7 = 5'd9,
			   DR8 = 5'd10,
			   DR9 = 5'd11,
			   DR10 = 5'd12,
			   DR11 = 5'd13,
			   DR12 = 5'd14,
			   DR13 = 5'd15,
			   DR14 = 5'd16,
			   DR15 = 5'd17,
			   DR16 = 5'd18,
				WAIT_X = 5'd19,
				WAIT_Y = 5'd20,
				WAIT_COLR = 5'd21;

	
	always@(*) begin
		case(present_state)
			WAIT_X : next_state = (START_LOAD == 1 ? INPUT_X : WAIT_X);
			INPUT_X : next_state = (START_LOAD == 1 ? INPUT_X : WAIT_Y);
			WAIT_Y : next_state = (START_LOAD == 1 ? INPUT_Y : WAIT_Y);
			INPUT_Y : next_state = (START_LOAD == 1 ? INPUT_Y : WAIT_COLR);
			WAIT_COLR : next_state = (GO == 1 ? INPUT_COLR : WAIT_COLR);
			INPUT_COLR : next_state = (GO == 0 ? DR1 : INPUT_COLR);
			DR1 : next_state = DR2;
			DR2 : next_state = DR3;
			DR3 : next_state = DR4;
			DR4 : next_state = DR5;
			DR5 : next_state = DR6;
			DR6 : next_state = DR7;
			DR7 : next_state = DR8;
			DR8 : next_state = DR9;
			DR9 : next_state = DR10;
			DR10 : next_state = DR11;
			DR11 : next_state = DR12;
			DR12 : next_state = DR13;
			DR13 : next_state = DR14;
			DR14 : next_state = DR15;
			DR15 : next_state = DR16;
			DR16 : next_state = DR17;
			DR17 : next_state = WAIT_X;
			default : next_state = WAIT_X;
		endcase
	end 
	
	always@(posedge clk) begin
		if(RESET_N == 0) 
			present_state <= WAIT_X;
		else
			present_state <= next_state;
		
	end
		
	
		
	

endmodule


module Datapath(
	clkk,
	present_state,
	SW,
	KEY,
	XX,
	YY,
	PLOT,
	COLR

);
input [9:0] SW;
input [3:0] KEY;
input [`STATE_SIZE : 0] present_state;
input clkk;
output reg [`COX_SIZE - 1: 0] XX;
output reg [`COY_SIZE - 1: 0] YY;
output reg [`RGB_SIZE - 1:0] COLR;
output reg PLOT;

	localparam INPUT_X = 5'd0, 
			   INPUT_Y = 5'd1,
			   INPUT_COLR = 5'd2,
			   DR17 = 5'd31,
			   DR1 = 5'd3,
			   DR2 = 5'd4,
			   DR3 = 5'd5,
			   DR4 = 5'd6,
			   DR5 = 5'd7,
			   DR6 = 5'd8,
			   DR7 = 5'd9,
			   DR8 = 5'd10,
			   DR9 = 5'd11,
			   DR10 = 5'd12,
			   DR11 = 5'd13,
			   DR12 = 5'd14,
			   DR13 = 5'd15,
			   DR14 = 5'd16,
			   DR15 = 5'd17,
			   DR16 = 5'd18,
				WAIT_X = 5'd19,
				WAIT_Y = 5'd20,
				WAIT_COLR = 5'd21;

	
	always@(posedge clkk) begin
		case(present_state) 
		WAIT_X : XX <= XX;
		INPUT_X : XX <= {1'b0,SW[6:0]};
		WAIT_Y : XX <= XX;
		INPUT_Y : YY <= SW[6:0];
		WAIT_COLR : YY <= YY;
		INPUT_COLR : COLR = SW[9:7];
		DR1 : PLOT = 1;
		DR2 : XX = XX + 1;
		DR3 : XX = XX + 1;
		DR4 : XX = XX + 1;
		DR5 : begin XX = XX - 3; YY = YY + 1; end
		DR6 : XX = XX + 1;
		DR7 : XX = XX + 1;
		DR8 : XX = XX + 1;
		DR9 : begin XX = XX - 3; YY = YY + 1; end
		DR10 : XX = XX + 1;
		DR11 : XX = XX + 1;
		DR12 : XX = XX + 1;
		DR13 : begin XX = XX - 3; YY = YY + 1; end
		DR14 : XX = XX + 1;
		DR15 : XX = XX + 1;
		DR16 : XX = XX + 1;
		DR17 : PLOT = 0;
		default : ;
		endcase
	end
	
endmodule
		

