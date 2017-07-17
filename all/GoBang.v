/**
 * The module for GoBang Game 
 */
module GoBang(SW, KEY, LEDR, LEDG, HEX0, HEX1, CLOCK_50);
    input [12:0] SW; //7~0: x-y coordinate (row-column)
    input [3:0] KEY; //0: put; 1: reset; 2: move right; 3:move down
    input CLOCK_50; //clock
    output [6:0] HEX0, HEX1; //HEX0: x coordinate (row), HEX1: y coordinate (column)
    output [7:0] LEDR, LEDG; //LEDR[0]: player0's turn, LEDG[7]: player1's turn; LEDR[7]: player0 win, LEDG[0]: player1 win

    wire turn_control; // enable signal for player switch
    //Control
    control ct(.clock(CLOCK_50), .resetn(KEY[1]), .put(KEY[0]), .change_turn(turn_control));

    //Datapath
    DataPath board(.coordi(SW[7:0]), .resetn(KEY[1]), .put(KEY[0]),
	                .turn_control(turn_control), .ledr(LEDR[7:0]), .ledg(LEDG[7:0]),
						 .hex0(HEX0[6:0]), .hex1(HEX1[6:0]), .clock(CLOCK_50));

endmodule


