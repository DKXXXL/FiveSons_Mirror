/**
 * This module takes 16 2-bit inputs (the information of 16 different points on the same row of
 * the game board) and a 4-bit select signal (the y-coordinate of a point). According to the
 * given y-coordinate, read the information for the point and forward it to output.
 */
module Y_Coordinate_Select_Read(in, select, out);
    input [31:0] in; // 16*2 input data
    input [3:0] select; // 4-bit select signal
    output [1:0] out; //output line

    //According to the select signal, put the right input data to the output line
    Select16to1 getDataFromPoint(.in(in), .select(select), .out(out));

endmodule
