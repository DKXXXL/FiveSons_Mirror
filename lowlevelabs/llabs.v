`include header.v

module llabs(
	working,
	// input : change indicating startworking, can't be stopped
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


	input Clck, Reset, working;
	input [`BOARD_SIZE - 1 : 0] board;
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
	ram1122x3 videoMem(
		.address(address_0),
		.clock(Clck),
		.data(color),
		.wren(print_enable),
		.q(mem_output)
		);
	
	wire DummyStart_painter, 
	painter_flasher, 
	flasher_DummyStart;

	wire [`MEMORY_SIZE_BITS - 1:0] address_0, address_1, address_2;
    wire [`COLOR_SIZE - 1 : 0] color;
	wire print_enable;
	wire [`COLOR_SIZE - 1: 0] mem_output;

	assign address_0 = address_1 | address_2;


	DummyStart ds(
	.working(working)
    .in_cont_signal(flasher_DummyStart),
	// input : The signal to start 
	.out_cont_signal(DummyStart_painter),
	// output: The signal for next continuation to start
	.next_out_cont_signal(painter_flasher),
	// input : indicating the next continuation is finished, going to the next after the next
    Clck,
);


	painter pt(
	.in_cont_signal(DummyStart_painter_0),
	// input : The signal to start 
	.out_cont_signal(painter_flasher),
	// output: The signal for next continuation to start
	.next_out_cont_signal(flasher_DummyStart),
	// input : indicating the next continuation is finished, going to the next after the next
	.board(board),
	// input : the huge number of wires indicating a board
	.winning_information(gaming_status),
	// input : the information about winning status
	.pointer_loc_x(pointer_loc_x),
	.pointer_loc_y(pointer_loc_x),
	// input : the information of pointer location
	.Clck(Clck),
	// input : the clock
	.Reset(Reset),
    // input : indicating the reset
	.address(address_1),
	// output : The output for the next memaddress to write in
	.color(color),
	// output : The color information which is going to be written to memory
	.print_enable(print_enable)
	// output : The output indicating starting to write information to the memory
	);

screenFlash sf(
	.Clck(Clck), 
	// input: The CLOCK
	.in_cont_signal(painter_flasher), 
	// input: The signal to start flashing, continuation
	.read_addr(address_2), 
	// output : the address to read from
	.read_data(mem_output),
		     // input : the data got from the address
	.Reset(Reset),
		     //input : Reset signal
	.out_cont_signal(flasher_DummyStart),
		     // output: The signal that flashing has stop
	.next_fin_signal(DummyStart_painter),
	// input : The signal indicating next continuation is finished
	.VGA_CLK(VGA_CLK), // VGA_CLK;
	.VGA_HS(VGA_HS), // VGA_H_SYNC
	.VGA_VS(VGA_VS), // VGA_V_SYNC
	.VGA_BLANK_N(VGA_BLANK_N), // VGA_BLANK
	.VGA_SYNC_N(VGA_SYNC_N), //VGA SYNC
	.VGA_R(VGA_R), // VGA Red[9:0]
	.VGA_G(VGA_G), // VGA Green[9:0]
	.VGA_B(VGA_B) // VGA Blue[9:0]
	)


endmodule

module DummyStart(
	working,
	// input : indicating working
    in_cont_signal,
	// input : The signal to start 
	out_cont_signal,
	// output: The signal for next continuation to start
	next_out_cont_signal,
	// input : indicating the next continuation is finished, going to the next after the next
    Clck,
);

    always@(posedge Clck)
    begin
      if(in_cont_signal == 1)
        out_cont_signal = 1;
      else
        if(next_out_cont_signal == 1)
            out_cont_signal = 0;
    
    end

	always@(working)
	begin
	  if(working == 1)
	  	out_cont_signal = 1;
	end

endmodule