/**
 * This module takes 2-bit input (the information of a point on game board) and a 4-bit select
 * signal (the y-coordinate of a point). According to the given y-coordinate, store the given
 * information into the corresponding PointInfor block.
 */
module Y_Coordinate_Select_Write(in, select, out, clock, reset, write_enable);
    input [1:0] in; // input data
    input [3:0] select; // 4-bit select signal which stands for the y-coordinate of a point
    input clock, reset; // clock and reset signal
    input write_enable;
    //16 different 2-bit output line of 16 different PointInfor block in a row
    output [31:0] out;
    wire [31:0] data_out;
    //16 different 2-bit input line for 16 different PointInfor block in a row
    wire [31:0] point_in;
    wire [15:0] enable;

    //According to te select signal, put the input data to the right input line
    Select1to16 transDataToPoint(.in(in[1:0]), .select(select[3:0]), .out(point_in[31:0]));

    Enable_select enableEachPoint(.enable(write_enable), .select(select[3:0]), .out(enable[15:0]));
 
    //the PointInfor block whose y-coordinate is 0
    PointInfor point0(.d(point_in[1:0]), .clock(clock), .reset(reset), .write_enable(enable[0]), .q(data_out[1:0]));
    //the PointInfor block whose y-coordinate is 1
    PointInfor point1(.d(point_in[3:2]), .clock(clock), .reset(reset), .write_enable(enable[1]), .q(data_out[3:2]));
    //the PointInfor block whose y-coordinate is 2
    PointInfor point2(.d(point_in[5:4]), .clock(clock), .reset(reset), .write_enable(enable[2]), .q(data_out[5:4]));
    //the PointInfor block whose y-coordinate is 3
    PointInfor point3(.d(point_in[7:6]), .clock(clock), .reset(reset), .write_enable(enable[3]), .q(data_out[7:6]));
    //the PointInfor block whose y-coordinate is 4
    PointInfor point4(.d(point_in[9:8]), .clock(clock), .reset(reset), .write_enable(enable[4]), .q(data_out[9:8]));
    //the PointInfor block whose y-coordinate is 5
    PointInfor point5(.d(point_in[11:10]), .clock(clock), .reset(reset), .write_enable(enable[5]), .q(data_out[11:10]));
    //the PointInfor block whose y-coordinate is 6
    PointInfor point6(.d(point_in[13:12]), .clock(clock), .reset(reset), .write_enable(enable[6]), .q(data_out[13:12]));
    //the PointInfor block whose y-coordinate is 7
    PointInfor point7(.d(point_in[15:14]), .clock(clock), .reset(reset), .write_enable(enable[7]), .q(data_out[15:14]));
    //the PointInfor block whose y-coordinate is 8
    PointInfor point8(.d(point_in[17:16]), .clock(clock), .reset(reset), .write_enable(enable[8]), .q(data_out[17:16]));
    //the PointInfor block whose y-coordinate is 9
    PointInfor point9(.d(point_in[19:18]), .clock(clock), .reset(reset), .write_enable(enable[9]), .q(data_out[19:18]));
    //the PointInfor block whose y-coordinate is 10
    PointInfor point10(.d(point_in[21:20]), .clock(clock), .reset(reset), .write_enable(enable[10]), .q(data_out[21:20]));
    //the PointInfor block whose y-coordinate is 11
    PointInfor point11(.d(point_in[23:22]), .clock(clock), .reset(reset), .write_enable(enable[11]), .q(data_out[23:22]));
    //the PointInfor block whose y-coordinate is 12
    PointInfor point12(.d(point_in[25:24]), .clock(clock), .reset(reset), .write_enable(enable[12]), .q(data_out[25:24]));
    //the PointInfor block whose y-coordinate is 13
    PointInfor point13(.d(point_in[27:26]), .clock(clock), .reset(reset), .write_enable(enable[13]), .q(data_out[27:26]));
    //the PointInfor block whose y-coordinate is 14
    PointInfor point14(.d(point_in[29:28]), .clock(clock), .reset(reset), .write_enable(enable[14]), .q(data_out[29:28]));
    //the PointInfor block whose y-coordinate is 15
    PointInfor point15(.d(point_in[31:30]), .clock(clock), .reset(reset), .write_enable(enable[15]), .q(data_out[31:30]));

    //Connect to the output	 
    assign out[31:0] = data_out[31:0];

endmodule
