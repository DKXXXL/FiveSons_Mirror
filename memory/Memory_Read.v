/**
 * This module takes 256 2-bit input (the information of all points on game board) and a 8-bit
 * select signal (the xy coordinate of a point). According to the given xy coordinate, output
 * the corresponding information of that point.
 */
module Memory_Read(in, select, out);
    // output data
    output [1:0] out; 
    // 8-bit select signal, the highest 4 bits are for x coordinate, the lowest 4 bits are for
    // y coordinate
    input [7:0] select;
    //256 2-bit different input line for every point on the board
    input [511:0] in;
    //16 2-bit different output line for 16 different rows on the board
    wire [31:0] row_out;

    //According to the select signal for y coordinate, put the information of the points with
    //the given y coordinate to the right output line for each row
 
    //the row whose x-coordinate is 0
    Y_Coordinate_Select_Read rowout0(.in(in[31:0]), .select(select[3:0]), .out(row_out[1:0]));
    //the row whose x-coordinate is 1
    Y_Coordinate_Select_Read rowout1(.in(in[63:32]), .select(select[3:0]), .out(row_out[3:2]));
    //the row whose x-coordinate is 2
    Y_Coordinate_Select_Read rowout2(.in(in[95:64]), .select(select[3:0]), .out(row_out[5:4]));
    //the row whose x-coordinate is 3
    Y_Coordinate_Select_Read rowout3(.in(in[127:96]), .select(select[3:0]), .out(row_out[7:6]));
    //the row whose x-coordinate is 4
    Y_Coordinate_Select_Read rowout4(.in(in[159:128]), .select(select[3:0]), .out(row_out[9:8]));
    //the row whose x-coordinate is 5
    Y_Coordinate_Select_Read rowout5(.in(in[191:160]), .select(select[3:0]), .out(row_out[11:10]));
    //the row whose x-coordinate is 6
    Y_Coordinate_Select_Read rowout6(.in(in[223:192]), .select(select[3:0]), .out(row_out[13:12]));
    //the row whose x-coordinate is 7
    Y_Coordinate_Select_Read rowout7(.in(in[255:224]), .select(select[3:0]), .out(row_out[15:14]));
    //the row whose x-coordinate is 8
    Y_Coordinate_Select_Read rowout8(.in(in[287:256]), .select(select[3:0]), .out(row_out[17:16]));
    //the row whose x-coordinate is 9
    Y_Coordinate_Select_Read rowout9(.in(in[319:288]), .select(select[3:0]), .out(row_out[19:18]));
    //the row whose x-coordinate is 10
    Y_Coordinate_Select_Read rowout10(.in(in[351:320]), .select(select[3:0]), .out(row_out[21:20]));
    //the row whose x-coordinate is 11
    Y_Coordinate_Select_Read rowout11(.in(in[383:352]), .select(select[3:0]), .out(row_out[23:22]));
    //the row whose x-coordinate is 12
    Y_Coordinate_Select_Read rowout12(.in(in[415:384]), .select(select[3:0]), .out(row_out[25:24]));
    //the row whose x-coordinate is 13
    Y_Coordinate_Select_Read rowout13(.in(in[447:416]), .select(select[3:0]), .out(row_out[27:26]));
    //the row whose x-coordinate is 14
    Y_Coordinate_Select_Read rowout14(.in(in[479:448]), .select(select[3:0]), .out(row_out[29:28]));
    //the row whose x-coordinate is 15
    Y_Coordinate_Select_Read rowout15(.in(in[511:480]), .select(select[3:0]), .out(row_out[31:30]));

    //According to the select signal for x coordinate, connect the right output line for each row
    //to output data
    Select16to1 getDataFromRow(.in(row_out[31:0]), .select(select[7:4]), .out(out[1:0]));
    
endmodule
