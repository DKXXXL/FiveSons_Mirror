/**
 * This module takes in the check answers of 12 different cases in a row/column, if there is at
 * least one check pass (find 5 adjacent chesses with same color) return the color, else return 0.
 */
module Summarize12(check_ans, out);
    input [23:0] check_ans;
    output reg [1:0] out;

    always@(*)
    begin
        // If all check fails, return 0
        if((check_ans[1:0] == 2'b00) && (check_ans[3:2] == 2'b00)  && (check_ans[5:4] == 2'b00) && (check_ans[7:6] == 2'b00)
           && (check_ans[9:8] == 2'b00) && (check_ans[11:10] == 2'b00) && (check_ans[13:12] == 2'b00) && (check_ans[15:14] == 2'b00)
           && (check_ans[17:16] == 2'b00) && (check_ans[19:18] == 2'b00) && (check_ans[21:20] == 2'b00) && (check_ans[23:22] == 2'b00))
            out = 2'b00;
        // Else if some check show 01, return 01
        else if((check_ans[1:0] == 2'b01) || (check_ans[3:2] == 2'b01)  || (check_ans[5:4] == 2'b01) || (check_ans[7:6] == 2'b01)
            || (check_ans[9:8] == 2'b01) || (check_ans[11:10] == 2'b01) || (check_ans[13:12] == 2'b01) || (check_ans[15:14] == 2'b01)
            || (check_ans[17:16] == 2'b01) || (check_ans[19:18] == 2'b01) || (check_ans[21:20] == 2'b01) || (check_ans[23:22] == 2'b01))
           out = 2'b01;
        // Else return 10
        else 
           out = 2'b10;

    end

endmodule
