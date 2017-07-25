/**
 * This module is the DataPath for GoBang.
 */
module DataPath(coordi, resetn, put, turn_control, change_able_read, ledr, ledg, hex0, hex1, clock,
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
    input [7:0] coordi; //7~4: x coordinate (row); 3~0: y coordinate (column)
    input resetn; //reset for while game
    input put; //put signal
    input turn_control; // triger for change player
    input change_able_read;  // signal which allows to record whether can change player after this put
    input clock; //clock
    output [6:0] hex0, hex1; //HEX0: x coordinate (row), HEX1: y coordinate (column)
    //LEDR[0]: player0's turn, LEDG[7]: player1's turn; LEDR[7]: player0 win, LEDG[0]: player1 win
    output [7:0] ledg, ledr; 

    // VGA required information
    // Do not change the following outputs
    output vga_clk;   				// VGA Clock
    output vga_hs;				// VGA H_SYNC
    output vga_vs;				// VGA V_SYNC
    output vga_blank_n;				// VGA BLANK
    output vga_sync_n;				// VGA SYNC
    output [9:0] vga_r;   			// VGA Red[9:0]
    output [9:0] vga_g;	 			// VGA Green[9:0]
    output [9:0] vga_b;   			// VGA Blue[9:0]


    // Display coordinate to HEX
    Hexdisplay row_display(.out(hex1), .in(coordi[7:4]));
    Hexdisplay col_display(.out(hex0), .in(coordi[3:0]));
    
    
    // memory and write_enable
    wire [511:0] memory;
    wire [1:0] current_state;
    wire write_enable;

    //given write_enable signal and current chess color, try to put a chess to that point
    Memory_Write dataIn(.in(color[1:0]), .select(coordi[7:0]), .out(memory[511:0]), .clock(put), .reset(resetn), .write_enable(write_enable));
    //according to the coordinate, get the current state of that point
    Memory_Read dataOut(.in(memory[511:0]), .select(coordi[7:0]), .out(current_state[1:0]));
    //according to the current state of that point, generate write_enable signal
    Enable_control able(.current_state(current_state[1:0]), .out(write_enable));

    // Get current chess color
    wire [1:0] color;
    wire change_enable; // records the write_eable signal before put
    reg record;

    always@(*)
    begin
       // in CHOICE state, we want to record the write_enable signal
       if(change_able_read) record <= write_enable;
    end
    assign change_enable = record;
    // only when this put is valid (write_enable is high before put), we can change player
    Color getcolor(.turn(turn_control), .resetn(resetn), .out(color), .change_enable(change_enable));
    

    //Check status of the whole board (immediately)
    wire [1:0] check_ans;
    All_Check checkBoard(.memory(memory[511:0]), .ans(check_ans[1:0]));
    
    //according to the check answer, choose display pattern signal (1 means someone win, 0 means in process)
    reg dis_choice;
    always@(*)
    begin
        if(check_ans[1:0] != 2'b00) dis_choice = 1'b1;
        else dis_choice = 1'b0;
    end

    reg [7:0] lg, lr;
    //Control light according to the display pattern signal
    always@(*)
    begin
        // If someone win, turn on the cooresponding "win" light 
        if(dis_choice) begin
            if(check_ans[1:0] == 2'b01) begin //player0 win
                lr[7] = 1'b1;
                lr[0] = 1'b0;
                lg[0] = 1'b0;
                lg[7] = 1'b0;
            end
            else begin  //player1 win
                lr[7] = 1'b0;
                lr[0] = 1'b0;
                lg[0] = 1'b1;
                lg[7] = 1'b0;
            end
        end
        // Else (in process), turn on the cooresponding "turn" light 
        else begin
            if(color[1:0] == 2'b01) begin //player0' turn
                lr[7] = 1'b0;
                lr[0] = 1'b1;
                lg[0] = 1'b0;
                lg[7] = 1'b0;
            end
            else begin  //player1's turn
                lr[7] = 1'b0;
                lr[0] = 1'b0;
                lg[0] = 1'b0;
                lg[7] = 1'b1;
            end
        end
    end

    // connect to the VGA
    llabs labs(
	.Clck(clock),
	// input : the clock,
	.board(memory),
	// input : the board status
	.gaming_status(check_ans[1:0]),
	// input : the status of gaming
	.pointer_loc_x(coordi[3:0]),
	.pointer_loc_y(coordi[7:4]),
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
    assign ledr[7] = lr[7];
    assign ledr[0] = lr[0];
    assign ledg[7] = lg[7];
    assign ledg[0] = lg[0];
    // lights used for test
    assign ledr[5] = write_enable;
    //assign ledr[4] = change_able_read;
    //assign ledr[3] = change_enable;

endmodule

