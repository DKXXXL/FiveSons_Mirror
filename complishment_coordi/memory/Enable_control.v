/**
 * This module give out a write_enable signal according to the current state of a point on the game board.
 */
module Enable_control(current_state, out);
    input [1:0] current_state; // the current state of a point
    output reg out; // write_enable signal
    
    always@(*)
    begin
        // If the point is not empty, set write_enable signal low
        if(current_state[1:0] != 2'b00) out <= 0;
        else out <= 1;
    end
endmodule
