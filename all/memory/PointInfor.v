/**
 * This module is a module which use two D-flip-flops to record the state of a point on the game
 * board. 2'b00 means empty, 2'b01 means white, 2'b10 means black. 
 */
module PointInfor(d, clock, reset, write_enable, q);
    input [1:0] d; // data input, write_enable signal
    input clock, reset, write_enable; // clock and active-low asynchronous reset signal
    output [1:0] q; // data output of the two flip flop

    //Instantiate the flip flop for the higher bit of the information 
    D_Flip_Flop first_bit(.d(d[1]), .clock(clock), .write_enable(write_enable), .reset(reset), .q(q[1]));
    //Instantiate the flip flop for the lower bit of the information 
    D_Flip_Flop second_bit(.d(d[0]), .clock(clock), .write_enable(write_enable), .reset(reset), .q(q[0]));
    
    
endmodule
