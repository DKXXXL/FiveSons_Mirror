/**
 * This module implements a 1-to-16 demultiplexer, which takes 2-bit input and a 4-bit select
 * signal, selecting one of sixteen 2-bit data-output-lines, and connecting it to the input.
 */
module Select1to16(in, select, out);
    input [1:0] in; // data input
    input [3:0] select; // 4-bit select signal
    //16 different 2-bit output line
    output [31:0] out;
	 reg [31:0] reg_out;

    always @ (*)
    begin
        case (select[3:0])
            4'd0: reg_out[1:0] <= in[1:0]; //the 0th output line
            4'd1: reg_out[3:2] <= in[1:0]; //the 1th output line
            4'd2: reg_out[5:4] <= in[1:0]; //the 2th output line
            4'd3: reg_out[7:6] <= in[1:0]; //the 3th output line
            4'd4: reg_out[9:8] <= in[1:0]; //the 4th output line
            4'd5: reg_out[11:10] <= in[1:0]; //the 5th output line
            4'd6: reg_out[13:12] <= in[1:0]; //the 6th output line
            4'd7: reg_out[15:14] <= in[1:0]; //the 7th output line
            4'd8: reg_out[17:16] <= in[1:0]; //the 8th output line
            4'd9: reg_out[19:18] <= in[1:0]; //the 9th output line
            4'd10: reg_out[21:20] <= in[1:0]; //the 10th output line
            4'd11: reg_out[23:22] <= in[1:0]; //the 11th output line
            4'd12: reg_out[25:24] <= in[1:0]; //the 12th output line
            4'd13: reg_out[27:26] <= in[1:0]; //the 13th output line
            4'd14: reg_out[29:28] <= in[1:0]; //the 14th output line
            4'd15: reg_out[31:30] <= in[1:0]; //the 15th output line
            //no need default since having discussed all possibilities
       endcase
    end
	 
    assign out[31:0] = reg_out[31:0];
    
endmodule
