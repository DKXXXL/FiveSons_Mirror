`define SCR_HEIGHT 12544
`define SCR_WIDTH `SCR_HEIGHT

`define SCR_HEIGHT_BITS 7
`define SCR_WIDTH_BTIS `SCR_HEIGHT_BITS


`define MEM_ADDR_START 0

`define COLOR_SIZE 3


`define ADDR_SIZE 14


`define COOR_TO_OFFSET(x, y) (x + (y * `SCR_WIDTH))


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
	BGA_SYNC_N, //VGA SYNC
	VGA_R, // VGA Red[9:0]
	VGA_G, // VGA Green[9:0]
	VGA_B // VGA Blue[9:0]
	);

  input Clck;
  input in_cont_signal;
	reg transition_mode;
	reg [1:0] each_cycle;
	reg print_enable;
	localparam
		READ_DATA = 2'b00,
		SETCO = 2'b01,
		START_PR = 2'b10,
		FINIS_PR = 2'b11;

	reg [`SCR_WIDTH_BITS - 1: 0] x_co;
	reg [`SCR_HEIGHT_BITS - 1 :0] y_co;
	wire [`COLOR_SIZE - 1 : 0] color_type;
	
	assign color_type = read_data;

	vga_adapter VGA(
		.resetn(Reset),
		.clock(Clck),
		.colour(color_type),
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
	defparam VGA.BACKGROUNF_IMAGE = "black.mif";

	always@(Clck)
	begin
		if(Reset == 0)
		begin
			out_cont_signal = 0;
			x_co = 0;
			y_co = 0;
		end
	end

  	always@(Clck) 
  	begin
		if(Reset == 0)
		begin
			out_cont_signal = 0;
			x_co = 0;
			y_co = 0;
			each_cycle = READ_DATA;
		end
		else
		begin



		if(in_cont_signal == 1 && out_cont_signal == 0) 
		begin
			case(each_cycle)
			READ_DATA:
			begin
				read_addr = COOR_TO_OFFSET(x_co, y_co);
				each_cycle <= START_PR;
			end
			START_PR:
			begin
				print_enable = 1;
				each_cycle <= FINIS_PR;
			end
			FINIS_PR:
			begin
				print_enable = 0;
				each_cycle <= SET_CO;
			end
			SET_CO:	
			begin
				if(x_co == SCR_WIDTH && y_co == SCR_HEIGHT)
				begin
					out_cont_signal = 1;
				end
				else
				begin	
					if (x_co == SCR_WIDTH)
					begin
						y_co = y_co + 1;
						x_co = 0;
					end
					else
						x_co = x_co + 1;
				end
				each_cycle <= READ_DATA;
			end
		end
	  	end
	end

	always@(next_out_cont_signal)
	begin
		if(next_out_cont_signal == 1)
			out_cont_signal = 0;
	end




	
endmodule
   
   
	       
