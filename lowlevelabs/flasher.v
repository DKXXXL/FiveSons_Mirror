`include "header.v"

module screenFlash(
	Clck, 
	// input: The CLOCK
	in_cont_signal, 
	// input: The signal to start flashing, continuation
	read_addr, 
	// output : the address to read from
	read_data,
		     // input : the data got from the address
	Reset,
		     //input : Reset signal
	out_cont_signal,
		     // output: The signal that flashing has stop
	next_fin_signal,
	// input : The signal indicating next continuation is finished
	VGA_CLK, // VGA_CLK;
	VGA_HS, // VGA_H_SYNC
	VGA_VS, // VGA_V_SYNC
	VGA_BLANK_N, // VGA_BLANK
	VGA_SYNC_N, //VGA SYNC
	VGA_R, // VGA Red[9:0]
	VGA_G, // VGA Green[9:0]
	VGA_B // VGA Blue[9:0]
	);

  input Clck, in_cont_signal, Reset, next_fin_signal;
  input [`COLOR_SIZE - 1: 0] read_data;
  output reg out_cont_signal;
  output reg [`MEMORY_SIZE_BITS - 1 : 0] read_addr;

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

	
	reg [1:0] each_cycle;
	reg print_enable;
	localparam 	READ_DATA = 2'b00,
				SET_CO = 2'b01,
				START_PR = 2'b10,
				FINIS_PR = 2'b11;

	reg [`SCR_WIDTH_BITS - 1: 0] x_co;
	reg [`SCR_HEIGHT_BITS - 1 :0] y_co;
	
	
	

 vga_adapter VGA(
	.resetn(Reset),
	.clock(Clck),
	.colour(read_data),
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

	initial
	begin
	  out_cont_signal = 0;
	  read_addr = 0;
	  x_co = 0;
	  y_co = 0;
	  // color_type = 0;
	  each_cycle = READ_DATA;
	  print_enable = 0;
	  out_cont_signal = 0;
	end

  	always@(posedge Clck) 
  	begin
		if(Reset == 0)
		begin
			out_cont_signal = 0;
			x_co = 0;
			y_co = 0;
			each_cycle = READ_DATA;
		end
		else
		
		if(in_cont_signal == 1 && out_cont_signal == 0) 
		begin
			case(each_cycle)
			READ_DATA:
			begin
				read_addr = `COOR_TO_OFFSET(x_co, y_co);
				each_cycle = START_PR;
			end
			START_PR:
			begin
				print_enable = 1;
				each_cycle = FINIS_PR;
			end
			FINIS_PR:
			begin
				print_enable = 0;
				each_cycle = SET_CO;
			end
			SET_CO:	
			begin
				if(x_co == `SCR_WIDTH && y_co == `SCR_HEIGHT)
				begin
					x_co = 0;
					y_co = 0;
					out_cont_signal = 1;
				end
				else
				begin	
					if (x_co == `SCR_WIDTH)
					begin
						y_co = y_co + 1;
						x_co = 0;
					end
					else
						x_co = x_co + 1;
				end
				each_cycle = READ_DATA;
			end
			endcase
		end
		else
		if(next_fin_signal == 1)
			out_cont_signal = 0;
	end

	// always@(next_out_cont_signal)
	// begin
	// 	if(next_out_cont_signal == 1)
	// 		out_cont_signal = 0;
	// end




	
endmodule
   
   
	       
