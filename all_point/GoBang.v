/**
 * The module for GoBang Game 
 */
module GoBang(KEY, LEDR, LEDG, HEX0, HEX1, CLOCK_50,
              // The ports below are for the VGA output.  Do not change.
	      VGA_CLK,      // VGA Clock
	      VGA_HS,       // VGA H_SYNC
	      VGA_VS,       // VGA V_SYNC
	      VGA_BLANK_N,  // VGA BLANK
	      VGA_SYNC_N,   // VGA SYNC
	      VGA_R,        // VGA Red[9:0]
	      VGA_G,	    //	VGA Green[9:0]
	      VGA_B         //	VGA Blue[9:0]
);
    input [3:0] KEY; //0: put; 1: reset; 2: move right; 3:move down
    input CLOCK_50; //clock
    output [6:0] HEX0, HEX1; //HEX0: x coordinate (row), HEX1: y coordinate (column)
    output [7:0] LEDR, LEDG; //LEDR[0]: player0's turn, LEDG[7]: player1's turn; LEDR[7]: player0 win, LEDG[0]: player1 win

    // Declare your inputs and outputs here
    // Do not change the following outputs
    output VGA_CLK;   				// VGA Clock
    output VGA_HS;				// VGA H_SYNC
    output VGA_VS;				// VGA V_SYNC
    output VGA_BLANK_N;				// VGA BLANK
    output VGA_SYNC_N;				// VGA SYNC
    output [9:0] VGA_R;   			// VGA Red[9:0]
    output [9:0] VGA_G;	 			// VGA Green[9:0]
    output [9:0] VGA_B;   			// VGA Blue[9:0]


    wire turn_control; // switch for player change
    wire control_set; // pointer control signal
    wire change_able_read; // enable signal for player switch
    //Control
    control ct(.clock(CLOCK_50), .resetn(KEY[1]), .put(KEY[0]),
               .change_turn(turn_control), .change_able_read(change_able_read), .control_set(control_set));

    //Datapath
    DataPath board(.resetn(KEY[1]), .put(KEY[0]), .right(KEY[2]), .down(KEY[3]),
                   .turn_control(turn_control), .change_able_read(change_able_read), .control_set(control_set),
                   .ledr(LEDR[7:0]), .ledg(LEDG[7:0]),
                   .hex0(HEX0[6:0]), .hex1(HEX1[6:0]), .clock(CLOCK_50),
                   .vga_clk(VGA_CLK),         // VGA Clock
	           .vga_hs(VGA_HS),           // VGA H_SYNC
	           .vga_vs(VGA_VS),           // VGA V_SYNC
	           .vga_blank_n(VGA_BLANK_N), // VGA BLANK
	           .vga_sync_n(VGA_SYNC_N),   // VGA SYNC
	           .vga_r(VGA_R),             // VGA Red[9:0]
	           .vga_g(VGA_G),	      // VGA Green[9:0]
	           .vga_b(VGA_B)              // VGA Blue[9:0]
);

endmodule


