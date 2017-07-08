/**
 * This module implements a 1-to-16 demultiplexer, which takes 2-bit input and a 4-bit select
 * signal, selecting one of sixteen 2-bit data-output-lines, and connecting it to the input.
 */
module Select1to16(in, select, out);
    input [1:0] in; // data input
    input [3:0] select; // 4-bit select signal
    //16 different 2-bit output line
    output reg [31:0] out;

    always @ (*)
    begin
        case (select[3:0])
            4'b0000: out[1:0] <= in[1:0]; //the 0th output line
            4'b0001: out[3:2] <= in[1:0]; //the 1th output line
            4'b0010: out[5:4] <= in[1:0]; //the 2th output line
            4'b0011: out[7:6] <= in[1:0]; //the 3th output line
            4'b0100: out[9:8] <= in[1:0]; //the 4th output line
            4'b0101: out[11:10] <= in[1:0]; //the 5th output line
            4'b0110: out[13:12] <= in[1:0]; //the 6th output line
            4'b0111: out[15:14] <= in[1:0]; //the 7th output line
            4'b1000: out[17:16] <= in[1:0]; //the 8th output line
            4'b1001: out[19:18] <= in[1:0]; //the 9th output line
            4'b1010: out[21:20] <= in[1:0]; //the 10th output line
            4'b1011: out[23:22] <= in[1:0]; //the 11th output line
            4'b1100: out[25:24] <= in[1:0]; //the 12th output line
            4'b1101: out[27:26] <= in[1:0]; //the 13th output line
            4'b1110: out[29:28] <= in[1:0]; //the 14th output line
            4'b1111: out[31:30] <= in[1:0]; //the 15th output line
            //no need default since having discussed all possibilities
       endcase
    end
    
endmodule
