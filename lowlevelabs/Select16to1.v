/**
 * This module implements a 16-to-1 multiplexer, which takes 16 different 2-bit input and a 4-bit
 * select signal, selecting one of sixteen 2-bit data input, and connecting it to the output.
 */
module Select16to1(in, select, out);
    input [31:0] in; // 16 different data input lines
    input [3:0] select; // 4-bit select signal
    output reg [1:0] out; // output line

    always @ (*)
    begin
        case (select[3:0])
            4'b0000: out[1:0] <= in[1:0]; //the 0th input line
            4'b0001: out[1:0] <= in[3:2]; //the 1th input line
            4'b0010: out[1:0] <= in[5:4]; //the 2th input line
            4'b0011: out[1:0] <= in[7:6]; //the 3th input line
            4'b0100: out[1:0] <= in[9:8]; //the 4th input line
            4'b0101: out[1:0] <= in[11:10]; //the 5th input line
            4'b0110: out[1:0] <= in[13:12]; //the 6th input line
            4'b0111: out[1:0] <= in[15:14]; //the 7th input line
            4'b1000: out[1:0] <= in[17:16]; //the 8th input line
            4'b1001: out[1:0] <= in[19:18]; //the 9th input line
            4'b1010: out[1:0] <= in[21:20]; //the 10th input line
            4'b1011: out[1:0] <= in[23:22]; //the 11th input line
            4'b1100: out[1:0] <= in[25:24]; //the 12th input line
            4'b1101: out[1:0] <= in[27:26]; //the 13th input line
            4'b1110: out[1:0] <= in[29:28]; //the 14th input line
            4'b1111: out[1:0] <= in[31:30]; //the 15th input line
            //no need default since having discussed all possibilities
       endcase
    end
    
endmodule
