/**
 * This module takes 2-bit input (the information of a point on game board) and a 8-bit select
 * signal (the xy coordinate of a point). According to the given xy coordinate, store the given
 * information into the corresponding PointInfor block.
 */
module Memory_Write(in, select, out, clock, reset);
    // input data stands for the new information of a point on game board
    input [1:0] in;
    // 8-bit select signal, the highest 4 bits are for x coordinate, the lowest 4 bits are for
    // y coordinate
    input [7:0] select;
    // clock and reset signal
    input clock, reset; 
    //256 2-bit different output line for every PointInfor block for each points on the game board
    output reg [511:0] out;
    //16 2-bit different input line for 16 different row on the board
    reg [31:0] row_in;

    //According to te row select signal, put the input data to the right input line for each row
    Select1to16(.in(in), .select(select[7:4]), .out(row_in));
 
    // According to the given y-coordinate, store the given information into the corresponding
    // PointInfor block for each row.

    //the row whose x-coordinate is 0
    Y_Coordinate_Select_Write rowin0(.in(row_in[1:0]), .select(select[3:0]), .out(out[31:0]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 1
    Y_Coordinate_Select_Write rowin1(.in(row_in[3:2]), .select(select[3:0]), .out(out[63:32]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 2
    Y_Coordinate_Select_Write rowin2(.in(row_in[5:4]), .select(select[3:0]), .out(out[95:64]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 3
    Y_Coordinate_Select_Write rowin3(.in(row_in[7:6]), .select(select[3:0]), .out(out[127:96]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 4
    Y_Coordinate_Select_Write rowin4(.in(row_in[9:8]), .select(select[3:0]), .out(out[159:128]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 5
    Y_Coordinate_Select_Write rowin5(.in(row_in[11:10]), .select(select[3:0]), .out(out[191:160]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 6
    Y_Coordinate_Select_Write rowin6(.in(row_in[13:12]), .select(select[3:0]), .out(out[223:192]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 7
    Y_Coordinate_Select_Write rowin7(.in(row_in[15:14]), .select(select[3:0]), .out(out[255:224]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 8
    Y_Coordinate_Select_Write rowin8(.in(row_in[17:16]), .select(select[3:0]), .out(out[287:256]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 9
    Y_Coordinate_Select_Write rowin9(.in(row_in[19:18]), .select(select[3:0]), .out(out[319:288]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 10
    Y_Coordinate_Select_Write rowin10(.in(row_in[21:20]), .select(select[3:0]), .out(out[351:320]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 11
    Y_Coordinate_Select_Write rowin11(.in(row_in[23:22]), .select(select[3:0]), .out(out[383:352]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 12
    Y_Coordinate_Select_Write rowin12(.in(row_in[25:24]), .select(select[3:0]), .out(out[415:384]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 13
    Y_Coordinate_Select_Write rowin13(.in(row_in[27:26]), .select(select[3:0]), .out(out[447:416]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 14
    Y_Coordinate_Select_Write rowin14(.in(row_in[29:28]), .select(select[3:0]), .out(out[479:448]), .clock(clock), .reset(reset));
    //the row whose x-coordinate is 15
    Y_Coordinate_Select_Write rowin15(.in(row_in[31:30]), .select(select[3:0]), .out(out[511:480]), .clock(clock), .reset(reset));

    
endmodule
