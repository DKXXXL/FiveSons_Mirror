/**
 * This module takes in the summarized check answers of 16 different rows/columns, if there is at
 * least one check pass (find 5 adjacent chesses with same color) return the color, else return 0.
 */
module Summarize16(check_ans, out);
    input [31:0] check_ans;
    output reg [1:0] out;

    always@(*)
    begin
        // If all row/column fails, return 0
        if((check_ans[1:0] == 2'b00) && (check_ans[3:2] == 2'b00)  && (check_ans[5:4] == 2'b00) && (check_ans[7:6] == 2'b00)
            && (check_ans[9:8] == 2'b00) && (check_ans[11:10] == 2'b00) && (check_ans[13:12] == 2'b00) && (check_ans[15:14] == 2'b00)
            && (check_ans[17:16] == 2'b00) && (check_ans[19:18] == 2'b00) && (check_ans[21:20] == 2'b00) && (check_ans[23:22] == 2'b00)
            && (check_ans[25:24] == 2'b00) && (check_ans[27:26] == 2'b00) && (check_ans[29:28] == 2'b00) && (check_ans[31:30] == 2'b00))
           out = 2'b00;
        // Else if some row/column gets 10, return 10
        else if((check_ans[1:0] == 2'b10) || (check_ans[3:2] == 2'b10)  || (check_ans[5:4] == 2'b10) || (check_ans[7:6] == 2'b10)
                || (check_ans[9:8] == 2'b10) || (check_ans[11:10] == 2'b10) || (check_ans[13:12] == 2'b10) || (check_ans[15:14] == 2'b10)
                || (check_ans[17:16] == 2'b10) || (check_ans[19:18] == 2'b10) || (check_ans[21:20] == 2'b10) || (check_ans[23:22] == 2'b10)
                || (check_ans[25:24] == 2'b10) || (check_ans[27:26] == 2'b10) || (check_ans[29:28] == 2'b10) || (check_ans[31:30] == 2'b10))
           out = 2'b10;
        // Else, return 01
        else out = 2'b01;
    end

endmodule
