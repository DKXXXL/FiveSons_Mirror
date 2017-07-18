module DataPath(control_set, resetn, put, turn_control, ledr, ledg, hex0, hex1, clock, right, down,
              // The ports below are for the VGA output.  Do not change.
	      vga_clk,      // VGA Clock
	      vga_hs,       // VGA H_SYNC
	      vga_vs,       // VGA V_SYNC
	      vga_blank_n,  // VGA BLANK
	      vga_sync_n,   // VGA SYNC
	      vga_r,        // VGA Red[9:0]
	      vga_g,	    //	VGA Green[9:0]
	      vga_b         //	VGA Blue[9:0]
);
    input resetn; //reset
    input put, right, down; //put, move right, move down signal
    input turn_control, control_set; //switch player triger
    input clock; //clock
    output [6:0] hex0, hex1; //HEX0: x coordinate (row), HEX1: y coordinate (column)
    output reg [7:0] ledg, ledr; //LEDR[0]: player0's turn, LEDG[7]: player1's turn; LEDR[7]: player0 win, LEDG[0]: player1 win

    // Declare your inputs and outputs here
    // Do not change the following outputs
    output vga_clk;   				// VGA Clock
    output vga_hs;				// VGA H_SYNC
    output vga_vs;				// VGA V_SYNC
    output vga_blank_n;				// VGA BLANK
    output vga_sync_n;				// VGA SYNC
    output [9:0] vga_r;   			// VGA Red[9:0]
    output [9:0] vga_g;	 			// VGA Green[9:0]
    output [9:0] vga_b;   			// VGA Blue[9:0]

    // coordinate of pointer
    wire [7:0] coordi;
    Coordi_Gener getCoodi(.right(right), .down(down), .control_set(control_set), .resetn(resetn), .out(coordi[7:0]));

    // Display coordinate to HEX
    Hexdisplay row_display(.out(hex1), .in(coordi[7:4]));
    Hexdisplay col_display(.out(hex0), .in(coordi[3:0]));

    // Get current chess color
    wire [1:0] color; 
    Color(.enable(turn_control), .resetn(resetn), .out(color));
    
    // memory and write_enable
    wire [511:0] memory;
    wire [1:0] current_state;
    wire write_enable;
    //according to the coordinate, get the current state of that point
    Memory_Read dataOut(.in(memory[511:0]), .select(coordi[7:0]), .out(current_state[1:0]));
    //according to the current state of that point, generate write_enable signal
    Enable_control able(.current_state(current_state[1:0]), .out(write_enable));
    //given write_enable signal and current chess color, try to put a chess to that point
    Memory_Write dataIn(.in(color[1:0]), .select(coordi[7:0]), .out(memory[511:0]), .clock(put), .reset(resetn), .write_enable(write_enable));

    //Check status of the whole board
    wire [1:0] check_ans;
    All_Check checkBoard(.memory(memory[511:0]), .ans(check_ans[1:0]));
    
    //according to the check answer, choose display pattern signal (1 means someone win, 0 means in process)
    reg dis_choice;
    always@(*)
    begin
        if(check_ans[1:0] != 2'b00) dis_choice = 1'b1;
        else dis_choice = 1'b0;
    end

    //Control light according to the display pattern signal
    always@(*)
    begin
        // If someone win, turn on the cooresponding "win" light 
        if(dis_choice) begin
            if(check_ans[1:0] == 2'b01) begin //player0 win
                ledr[7] = 1'b1;
                ledr[0] = 1'b0;
                ledg[0] = 1'b0;
                ledg[7] = 1'b0;
            end
            else begin  //player1 win
                ledr[7] = 1'b0;
                ledr[0] = 1'b0;
                ledg[0] = 1'b1;
                ledg[7] = 1'b0;
            end
        end
        // Else (in process), turn on the cooresponding "turn" light 
        else begin
            if(color[1:0] == 2'b01) begin //player0' turn
                ledr[7] = 1'b0;
                ledr[0] = 1'b1;
                ledg[0] = 1'b0;
                ledg[7] = 1'b0;
            end
            else begin  //player1's turn
                ledr[7] = 1'b0;
                ledr[0] = 1'b0;
                ledg[0] = 1'b0;
                ledg[7] = 1'b1;
            end
        end
    end

    llabs labs(
	.Clck(clock),
	// input : the clock,
	.board(memory),
	// input : the board status
	.gaming_status(color),
	// input : the status of gaming
	.pointer_loc_x(coordi[7:4]),
	.pointer_loc_y(coordi[3:0]),
	// inputs : the location of pointer, x, y coordinate
	.Reset(resetn),
	// inputs : the reset
	.VGA_CLK(vga_clk), // VGA_CLK;
	.VGA_HS(vga_hs), // VGA_H_SYNC
	.VGA_VS(vga_vs), // VGA_V_SYNC
	.VGA_BLANK_N(vga_blank_n), // VGA_BLANK
	.VGA_SYNC_N(vga_sync_n), //VGA SYNC
	.VGA_R(vga_r), // VGA Red[9:0]
	.VGA_G(vga_g), // VGA Green[9:0]
	.VGA_B(vga_b) // VGA Blue[9:0]
	
);

endmodule

