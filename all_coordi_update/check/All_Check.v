/**
 * This module check whether there are five adjacent chesses with same color in a row or in a
 * column. If not, give out 0, else, give out the color of that chess
 */
module All_Check(memory, ans);
    input [511:0] memory; //256 2-bit inputs stands for all chesses on the board
    output reg [1:0] ans; //2-bit output; 0: no one win; 1: player 1 wins; 2: player 2 wins

    wire [383:0] row_ans, col_ans;//ans for each check
    wire [31:0] row_sum, col_sum;//ans for each row/column
    
    // parameters that denotes the memory of the first point in each row
    localparam  ROW_0 = 9'd0, ROW_1 = 9'd32, ROW_2 = 9'd64, ROW_3 = 9'd96, ROW_4 = 9'd128, 
                ROW_5 = 9'd160, ROW_6 = 9'd192, ROW_7 = 9'd224, ROW_8 = 9'd256, ROW_9  = 9'd288,
                ROW_10 = 9'd320, ROW_11 = 9'd352, ROW_12 = 9'd384, ROW_13 = 9'd416,
                ROW_14 = 9'd448, ROW_15   = 9'd480;
    // parameters that denotes the memory of the first point in each colum
    localparam  COL_0 = 9'd0, COL_1 = 9'd2, COL_2 = 9'd4, COL_3 = 9'd6, COL_4 = 9'd8, 
                COL_5 = 9'd10, COL_6 = 9'd12, COL_7 = 9'd14, COL_8 = 9'd16, COL_9  = 9'd18,
                COL_10 = 9'd20, COL_11 = 9'd22, COL_12 = 9'd24, COL_13 = 9'd26,
                COL_14 = 9'd28, COL_15   = 9'd30;

    //check row 0 (12 cases to check)
    Checker row0_1(.a(memory[ROW_0+9'd1:ROW_0+9'd0]), .b(memory[ROW_0+9'd3:ROW_0+9'd2]), .c(memory[ROW_0+9'd5:ROW_0+9'd4]),
                   .d(memory[ROW_0+9'd7:ROW_0+9'd6]), .e(memory[ROW_0+9'd9:ROW_0+9'd8]), .ans(row_ans[1:0]));
    Checker row0_2(.a(memory[ROW_0+9'd11:ROW_0+9'd10]), .b(memory[ROW_0+9'd3:ROW_0+9'd2]), .c(memory[ROW_0+9'd5:ROW_0+9'd4]),
                   .d(memory[ROW_0+9'd7:ROW_0+9'd6]), .e(memory[ROW_0+9'd9:ROW_0+9'd8]), .ans(row_ans[3:2]));
    Checker row0_3(.a(memory[ROW_0+9'd11:ROW_0+9'd10]), .b(memory[ROW_0+9'd13:ROW_0+9'd12]), .c(memory[ROW_0+9'd5:ROW_0+9'd4]),
                   .d(memory[ROW_0+9'd7:ROW_0+9'd6]), .e(memory[ROW_0+9'd9:ROW_0+9'd8]), .ans(row_ans[5:4]));
    Checker row0_4(.a(memory[ROW_0+9'd11:ROW_0+9'd10]), .b(memory[ROW_0+9'd13:ROW_0+9'd12]), .c(memory[ROW_0+9'd15:ROW_0+9'd14]),
                   .d(memory[ROW_0+9'd7:ROW_0+9'd6]), .e(memory[ROW_0+9'd9:ROW_0+9'd8]), .ans(row_ans[7:6]));
    Checker row0_5(.a(memory[ROW_0+9'd11:ROW_0+9'd10]), .b(memory[ROW_0+9'd13:ROW_0+9'd12]), .c(memory[ROW_0+9'd15:ROW_0+9'd14]),
                   .d(memory[ROW_0+9'd17:ROW_0+9'd16]), .e(memory[ROW_0+9'd9:ROW_0+9'd8]), .ans(row_ans[9:8]));
    Checker row0_6(.a(memory[ROW_0+9'd11:ROW_0+9'd10]), .b(memory[ROW_0+9'd13:ROW_0+9'd12]), .c(memory[ROW_0+9'd15:ROW_0+9'd14]),
                   .d(memory[ROW_0+9'd17:ROW_0+9'd16]), .e(memory[ROW_0+9'd19:ROW_0+9'd18]), .ans(row_ans[11:10]));
    Checker row0_7(.a(memory[ROW_0+9'd21:ROW_0+9'd20]), .b(memory[ROW_0+9'd13:ROW_0+9'd12]), .c(memory[ROW_0+9'd15:ROW_0+9'd14]),
                   .d(memory[ROW_0+9'd17:ROW_0+9'd16]), .e(memory[ROW_0+9'd19:ROW_0+9'd18]), .ans(row_ans[13:12]));
    Checker row0_8(.a(memory[ROW_0+9'd21:ROW_0+9'd20]), .b(memory[ROW_0+9'd23:ROW_0+9'd22]), .c(memory[ROW_0+9'd15:ROW_0+9'd14]),
                   .d(memory[ROW_0+9'd17:ROW_0+9'd16]), .e(memory[ROW_0+9'd19:ROW_0+9'd18]), .ans(row_ans[15:14]));
    Checker row0_9(.a(memory[ROW_0+9'd21:ROW_0+9'd20]), .b(memory[ROW_0+9'd23:ROW_0+9'd22]), .c(memory[ROW_0+9'd25:ROW_0+9'd24]),
                   .d(memory[ROW_0+9'd17:ROW_0+9'd16]), .e(memory[ROW_0+9'd19:ROW_0+9'd18]), .ans(row_ans[17:16]));
    Checker row0_10(.a(memory[ROW_0+9'd21:ROW_0+9'd20]), .b(memory[ROW_0+9'd23:ROW_0+9'd22]), .c(memory[ROW_0+9'd25:ROW_0+9'd24]),
                   .d(memory[ROW_0+9'd27:ROW_0+9'd26]), .e(memory[ROW_0+9'd19:ROW_0+9'd18]), .ans(row_ans[19:18]));
    Checker row0_11(.a(memory[ROW_0+9'd21:ROW_0+9'd20]), .b(memory[ROW_0+9'd23:ROW_0+9'd22]), .c(memory[ROW_0+9'd25:ROW_0+9'd24]),
                   .d(memory[ROW_0+9'd27:ROW_0+9'd26]), .e(memory[ROW_0+9'd29:ROW_0+9'd28]), .ans(row_ans[21:20]));
    Checker row0_12(.a(memory[ROW_0+9'd31:ROW_0+9'd30]), .b(memory[ROW_0+9'd23:ROW_0+9'd22]), .c(memory[ROW_0+9'd25:ROW_0+9'd24]),
                   .d(memory[ROW_0+9'd27:ROW_0+9'd26]), .e(memory[ROW_0+9'd29:ROW_0+9'd28]), .ans(row_ans[23:22]));
    //Summarize the check answer in row 0
    Summarize12 row0_sum(.check_ans(row_ans[23:0]), .out(row_sum[1:0]));


    //check row 1 (12 cases to check)
    Checker row1_1(.a(memory[ROW_1+9'd1:ROW_1+9'd0]), .b(memory[ROW_1+9'd3:ROW_1+9'd2]), .c(memory[ROW_1+9'd5:ROW_1+9'd4]),
                   .d(memory[ROW_1+9'd7:ROW_1+9'd6]), .e(memory[ROW_1+9'd9:ROW_1+9'd8]), .ans(row_ans[25:24]));
    Checker row1_2(.a(memory[ROW_1+9'd11:ROW_1+9'd10]), .b(memory[ROW_1+9'd3:ROW_1+9'd2]), .c(memory[ROW_1+9'd5:ROW_1+9'd4]),
                   .d(memory[ROW_1+9'd7:ROW_1+9'd6]), .e(memory[ROW_1+9'd9:ROW_1+9'd8]), .ans(row_ans[27:26]));
    Checker row1_3(.a(memory[ROW_1+9'd11:ROW_1+9'd10]), .b(memory[ROW_1+9'd13:ROW_1+9'd12]), .c(memory[ROW_1+9'd5:ROW_1+9'd4]),
                   .d(memory[ROW_1+9'd7:ROW_1+9'd6]), .e(memory[ROW_1+9'd9:ROW_1+9'd8]), .ans(row_ans[29:28]));
    Checker row1_4(.a(memory[ROW_1+9'd11:ROW_1+9'd10]), .b(memory[ROW_1+9'd13:ROW_1+9'd12]), .c(memory[ROW_1+9'd15:ROW_1+9'd14]),
                   .d(memory[ROW_1+9'd7:ROW_1+9'd6]), .e(memory[ROW_1+9'd9:ROW_1+9'd8]), .ans(row_ans[31:30]));
    Checker row1_5(.a(memory[ROW_1+9'd11:ROW_1+9'd10]), .b(memory[ROW_1+9'd13:ROW_1+9'd12]), .c(memory[ROW_1+9'd15:ROW_1+9'd14]),
                   .d(memory[ROW_1+9'd17:ROW_1+9'd16]), .e(memory[ROW_1+9'd9:ROW_1+9'd8]), .ans(row_ans[33:32]));
    Checker row1_6(.a(memory[ROW_1+9'd11:ROW_1+9'd10]), .b(memory[ROW_1+9'd13:ROW_1+9'd12]), .c(memory[ROW_1+9'd15:ROW_1+9'd14]),
                   .d(memory[ROW_1+9'd17:ROW_1+9'd16]), .e(memory[ROW_1+9'd19:ROW_1+9'd18]), .ans(row_ans[35:34]));
    Checker row1_7(.a(memory[ROW_1+9'd21:ROW_1+9'd20]), .b(memory[ROW_1+9'd13:ROW_1+9'd12]), .c(memory[ROW_1+9'd15:ROW_1+9'd14]),
                   .d(memory[ROW_1+9'd17:ROW_1+9'd16]), .e(memory[ROW_1+9'd19:ROW_1+9'd18]), .ans(row_ans[37:36]));
    Checker row1_8(.a(memory[ROW_1+9'd21:ROW_1+9'd20]), .b(memory[ROW_1+9'd23:ROW_1+9'd22]), .c(memory[ROW_1+9'd15:ROW_1+9'd14]),
                   .d(memory[ROW_1+9'd17:ROW_1+9'd16]), .e(memory[ROW_1+9'd19:ROW_1+9'd18]), .ans(row_ans[39:38]));
    Checker row1_9(.a(memory[ROW_1+9'd21:ROW_1+9'd20]), .b(memory[ROW_1+9'd23:ROW_1+9'd22]), .c(memory[ROW_1+9'd25:ROW_1+9'd24]),
                   .d(memory[ROW_1+9'd17:ROW_1+9'd16]), .e(memory[ROW_1+9'd19:ROW_1+9'd18]), .ans(row_ans[41:40]));
    Checker row1_10(.a(memory[ROW_1+9'd21:ROW_1+9'd20]), .b(memory[ROW_1+9'd23:ROW_1+9'd22]), .c(memory[ROW_1+9'd25:ROW_1+9'd24]),
                   .d(memory[ROW_1+9'd27:ROW_1+9'd26]), .e(memory[ROW_1+9'd19:ROW_1+9'd18]), .ans(row_ans[43:42]));
    Checker row1_11(.a(memory[ROW_1+9'd21:ROW_1+9'd20]), .b(memory[ROW_1+9'd23:ROW_1+9'd22]), .c(memory[ROW_1+9'd25:ROW_1+9'd24]),
                   .d(memory[ROW_1+9'd27:ROW_1+9'd26]), .e(memory[ROW_1+9'd29:ROW_1+9'd28]), .ans(row_ans[45:44]));
    Checker row1_12(.a(memory[ROW_1+9'd31:ROW_1+9'd30]), .b(memory[ROW_1+9'd23:ROW_1+9'd22]), .c(memory[ROW_1+9'd25:ROW_1+9'd24]),
                   .d(memory[ROW_1+9'd27:ROW_1+9'd26]), .e(memory[ROW_1+9'd29:ROW_1+9'd28]), .ans(row_ans[47:46]));
    //Summarize the check answer in row 1
    Summarize12 row1_sum(.check_ans(row_ans[47:24]), .out(row_sum[3:2]));


    //check row 2 (12 cases to check)
    Checker row2_1(.a(memory[ROW_2+9'd1:ROW_2+9'd0]), .b(memory[ROW_2+9'd3:ROW_2+9'd2]), .c(memory[ROW_2+9'd5:ROW_2+9'd4]),
                   .d(memory[ROW_2+9'd7:ROW_2+9'd6]), .e(memory[ROW_2+9'd9:ROW_2+9'd8]), .ans(row_ans[49:48]));
    Checker row2_2(.a(memory[ROW_2+9'd11:ROW_2+9'd10]), .b(memory[ROW_2+9'd3:ROW_2+9'd2]), .c(memory[ROW_2+9'd5:ROW_2+9'd4]),
                   .d(memory[ROW_2+9'd7:ROW_2+9'd6]), .e(memory[ROW_2+9'd9:ROW_2+9'd8]), .ans(row_ans[51:50]));
    Checker row2_3(.a(memory[ROW_2+9'd11:ROW_2+9'd10]), .b(memory[ROW_2+9'd13:ROW_2+9'd12]), .c(memory[ROW_2+9'd5:ROW_2+9'd4]),
                   .d(memory[ROW_2+9'd7:ROW_2+9'd6]), .e(memory[ROW_2+9'd9:ROW_2+9'd8]), .ans(row_ans[53:52]));
    Checker row2_4(.a(memory[ROW_2+9'd11:ROW_2+9'd10]), .b(memory[ROW_2+9'd13:ROW_2+9'd12]), .c(memory[ROW_2+9'd15:ROW_2+9'd14]),
                   .d(memory[ROW_2+9'd7:ROW_2+9'd6]), .e(memory[ROW_2+9'd9:ROW_2+9'd8]), .ans(row_ans[55:54]));
    Checker row2_5(.a(memory[ROW_2+9'd11:ROW_2+9'd10]), .b(memory[ROW_2+9'd13:ROW_2+9'd12]), .c(memory[ROW_2+9'd15:ROW_2+9'd14]),
                   .d(memory[ROW_2+9'd17:ROW_2+9'd16]), .e(memory[ROW_2+9'd9:ROW_2+9'd8]), .ans(row_ans[57:56]));
    Checker row2_6(.a(memory[ROW_2+9'd11:ROW_2+9'd10]), .b(memory[ROW_2+9'd13:ROW_2+9'd12]), .c(memory[ROW_2+9'd15:ROW_2+9'd14]),
                   .d(memory[ROW_2+9'd17:ROW_2+9'd16]), .e(memory[ROW_2+9'd19:ROW_2+9'd18]), .ans(row_ans[59:58]));
    Checker row2_7(.a(memory[ROW_2+9'd21:ROW_2+9'd20]), .b(memory[ROW_2+9'd13:ROW_2+9'd12]), .c(memory[ROW_2+9'd15:ROW_2+9'd14]),
                   .d(memory[ROW_2+9'd17:ROW_2+9'd16]), .e(memory[ROW_2+9'd19:ROW_2+9'd18]), .ans(row_ans[61:60]));
    Checker row2_8(.a(memory[ROW_2+9'd21:ROW_2+9'd20]), .b(memory[ROW_2+9'd23:ROW_2+9'd22]), .c(memory[ROW_2+9'd15:ROW_2+9'd14]),
                   .d(memory[ROW_2+9'd17:ROW_2+9'd16]), .e(memory[ROW_2+9'd19:ROW_2+9'd18]), .ans(row_ans[63:62]));
    Checker row2_9(.a(memory[ROW_2+9'd21:ROW_2+9'd20]), .b(memory[ROW_2+9'd23:ROW_2+9'd22]), .c(memory[ROW_2+9'd25:ROW_2+9'd24]),
                   .d(memory[ROW_2+9'd17:ROW_2+9'd16]), .e(memory[ROW_2+9'd19:ROW_2+9'd18]), .ans(row_ans[65:64]));
    Checker row2_10(.a(memory[ROW_2+9'd21:ROW_2+9'd20]), .b(memory[ROW_2+9'd23:ROW_2+9'd22]), .c(memory[ROW_2+9'd25:ROW_2+9'd24]),
                   .d(memory[ROW_2+9'd27:ROW_2+9'd26]), .e(memory[ROW_2+9'd19:ROW_2+9'd18]), .ans(row_ans[67:66]));
    Checker row2_11(.a(memory[ROW_2+9'd21:ROW_2+9'd20]), .b(memory[ROW_2+9'd23:ROW_2+9'd22]), .c(memory[ROW_2+9'd25:ROW_2+9'd24]),
                   .d(memory[ROW_2+9'd27:ROW_2+9'd26]), .e(memory[ROW_2+9'd29:ROW_2+9'd28]), .ans(row_ans[69:68]));
    Checker row2_12(.a(memory[ROW_2+9'd31:ROW_2+9'd30]), .b(memory[ROW_2+9'd23:ROW_2+9'd22]), .c(memory[ROW_2+9'd25:ROW_2+9'd24]),
                   .d(memory[ROW_2+9'd27:ROW_2+9'd26]), .e(memory[ROW_2+9'd29:ROW_2+9'd28]), .ans(row_ans[71:70]));
    //Summarize the check answer in row 2
    Summarize12 row2_sum(.check_ans(row_ans[71:48]), .out(row_sum[5:4]));


    //row 3(12 possible to check)
    Checker row3_1(.a(memory[ROW_3+9'd1:ROW_3+9'd0]), .b(memory[ROW_3+9'd3:ROW_3+9'd2]), .c(memory[ROW_3+9'd5:ROW_3+9'd4]),
                   .d(memory[ROW_3+9'd7:ROW_3+9'd6]), .e(memory[ROW_3+9'd9:ROW_3+9'd8]), .ans(row_ans[73:72]));
    Checker row3_2(.a(memory[ROW_3+9'd11:ROW_3+9'd10]), .b(memory[ROW_3+9'd3:ROW_3+9'd2]), .c(memory[ROW_3+9'd5:ROW_3+9'd4]),
                   .d(memory[ROW_3+9'd7:ROW_3+9'd6]), .e(memory[ROW_3+9'd9:ROW_3+9'd8]), .ans(row_ans[75:74]));
    Checker row3_3(.a(memory[ROW_3+9'd11:ROW_3+9'd10]), .b(memory[ROW_3+9'd13:ROW_3+9'd12]), .c(memory[ROW_3+9'd5:ROW_3+9'd4]),
                   .d(memory[ROW_3+9'd7:ROW_3+9'd6]), .e(memory[ROW_3+9'd9:ROW_3+9'd8]), .ans(row_ans[77:76]));
    Checker row3_4(.a(memory[ROW_3+9'd11:ROW_3+9'd10]), .b(memory[ROW_3+9'd13:ROW_3+9'd12]), .c(memory[ROW_3+9'd15:ROW_3+9'd14]),
                   .d(memory[ROW_3+9'd7:ROW_3+9'd6]), .e(memory[ROW_3+9'd9:ROW_3+9'd8]), .ans(row_ans[79:78]));
    Checker row3_5(.a(memory[ROW_3+9'd11:ROW_3+9'd10]), .b(memory[ROW_3+9'd13:ROW_3+9'd12]), .c(memory[ROW_3+9'd15:ROW_3+9'd14]),
                   .d(memory[ROW_3+9'd17:ROW_3+9'd16]), .e(memory[ROW_3+9'd9:ROW_3+9'd8]), .ans(row_ans[81:80]));
    Checker row3_6(.a(memory[ROW_3+9'd11:ROW_3+9'd10]), .b(memory[ROW_3+9'd13:ROW_3+9'd12]), .c(memory[ROW_3+9'd15:ROW_3+9'd14]),
                   .d(memory[ROW_3+9'd17:ROW_3+9'd16]), .e(memory[ROW_3+9'd19:ROW_3+9'd18]), .ans(row_ans[83:82]));
    Checker row3_7(.a(memory[ROW_3+9'd21:ROW_3+9'd20]), .b(memory[ROW_3+9'd13:ROW_3+9'd12]), .c(memory[ROW_3+9'd15:ROW_3+9'd14]),
                   .d(memory[ROW_3+9'd17:ROW_3+9'd16]), .e(memory[ROW_3+9'd19:ROW_3+9'd18]), .ans(row_ans[85:84]));
    Checker row3_8(.a(memory[ROW_3+9'd21:ROW_3+9'd20]), .b(memory[ROW_3+9'd23:ROW_3+9'd22]), .c(memory[ROW_3+9'd15:ROW_3+9'd14]),
                   .d(memory[ROW_3+9'd17:ROW_3+9'd16]), .e(memory[ROW_3+9'd19:ROW_3+9'd18]), .ans(row_ans[87:86]));
    Checker row3_9(.a(memory[ROW_3+9'd21:ROW_3+9'd20]), .b(memory[ROW_3+9'd23:ROW_3+9'd22]), .c(memory[ROW_3+9'd25:ROW_3+9'd24]),
                   .d(memory[ROW_3+9'd17:ROW_3+9'd16]), .e(memory[ROW_3+9'd19:ROW_3+9'd18]), .ans(row_ans[89:88]));
    Checker row3_10(.a(memory[ROW_3+9'd21:ROW_3+9'd20]), .b(memory[ROW_3+9'd23:ROW_3+9'd22]), .c(memory[ROW_3+9'd25:ROW_3+9'd24]),
                   .d(memory[ROW_3+9'd27:ROW_3+9'd26]), .e(memory[ROW_3+9'd19:ROW_3+9'd18]), .ans(row_ans[91:90]));
    Checker row3_11(.a(memory[ROW_3+9'd21:ROW_3+9'd20]), .b(memory[ROW_3+9'd23:ROW_3+9'd22]), .c(memory[ROW_3+9'd25:ROW_3+9'd24]),
                   .d(memory[ROW_3+9'd27:ROW_3+9'd26]), .e(memory[ROW_3+9'd29:ROW_3+9'd28]), .ans(row_ans[93:92]));
    Checker row3_12(.a(memory[ROW_3+9'd31:ROW_3+9'd30]), .b(memory[ROW_3+9'd23:ROW_3+9'd22]), .c(memory[ROW_3+9'd25:ROW_3+9'd24]),
                   .d(memory[ROW_3+9'd27:ROW_3+9'd26]), .e(memory[ROW_3+9'd29:ROW_3+9'd28]), .ans(row_ans[95:94]));
    Summarize12 row3_sum(.check_ans(row_ans[95:72]), .out(row_sum[7:6]));

    //row 4(12 possible to check)
    Checker row4_1(.a(memory[ROW_4+9'd1:ROW_4+9'd0]), .b(memory[ROW_4+9'd3:ROW_4+9'd2]), .c(memory[ROW_4+9'd5:ROW_4+9'd4]),
                   .d(memory[ROW_4+9'd7:ROW_4+9'd6]), .e(memory[ROW_4+9'd9:ROW_4+9'd8]), .ans(row_ans[97:96]));
    Checker row4_2(.a(memory[ROW_4+9'd11:ROW_4+9'd10]), .b(memory[ROW_4+9'd3:ROW_4+9'd2]), .c(memory[ROW_4+9'd5:ROW_4+9'd4]),
                   .d(memory[ROW_4+9'd7:ROW_4+9'd6]), .e(memory[ROW_4+9'd9:ROW_4+9'd8]), .ans(row_ans[99:98]));
    Checker row4_3(.a(memory[ROW_4+9'd11:ROW_4+9'd10]), .b(memory[ROW_4+9'd13:ROW_4+9'd12]), .c(memory[ROW_4+9'd5:ROW_4+9'd4]),
                   .d(memory[ROW_4+9'd7:ROW_4+9'd6]), .e(memory[ROW_4+9'd9:ROW_4+9'd8]), .ans(row_ans[101:100]));
    Checker row4_4(.a(memory[ROW_4+9'd11:ROW_4+9'd10]), .b(memory[ROW_4+9'd13:ROW_4+9'd12]), .c(memory[ROW_4+9'd15:ROW_4+9'd14]),
                   .d(memory[ROW_4+9'd7:ROW_4+9'd6]), .e(memory[ROW_4+9'd9:ROW_4+9'd8]), .ans(row_ans[103:102]));
    Checker row4_5(.a(memory[ROW_4+9'd11:ROW_4+9'd10]), .b(memory[ROW_4+9'd13:ROW_4+9'd12]), .c(memory[ROW_4+9'd15:ROW_4+9'd14]),
                   .d(memory[ROW_4+9'd17:ROW_4+9'd16]), .e(memory[ROW_4+9'd9:ROW_4+9'd8]), .ans(row_ans[105:104]));
    Checker row4_6(.a(memory[ROW_4+9'd11:ROW_4+9'd10]), .b(memory[ROW_4+9'd13:ROW_4+9'd12]), .c(memory[ROW_4+9'd15:ROW_4+9'd14]),
                   .d(memory[ROW_4+9'd17:ROW_4+9'd16]), .e(memory[ROW_4+9'd19:ROW_4+9'd18]), .ans(row_ans[107:106]));
    Checker row4_7(.a(memory[ROW_4+9'd21:ROW_4+9'd20]), .b(memory[ROW_4+9'd13:ROW_4+9'd12]), .c(memory[ROW_4+9'd15:ROW_4+9'd14]),
                   .d(memory[ROW_4+9'd17:ROW_4+9'd16]), .e(memory[ROW_4+9'd19:ROW_4+9'd18]), .ans(row_ans[109:108]));
    Checker row4_8(.a(memory[ROW_4+9'd21:ROW_4+9'd20]), .b(memory[ROW_4+9'd23:ROW_4+9'd22]), .c(memory[ROW_4+9'd15:ROW_4+9'd14]),
                   .d(memory[ROW_4+9'd17:ROW_4+9'd16]), .e(memory[ROW_4+9'd19:ROW_4+9'd18]), .ans(row_ans[111:110]));
    Checker row4_9(.a(memory[ROW_4+9'd21:ROW_4+9'd20]), .b(memory[ROW_4+9'd23:ROW_4+9'd22]), .c(memory[ROW_4+9'd25:ROW_4+9'd24]),
                   .d(memory[ROW_4+9'd17:ROW_4+9'd16]), .e(memory[ROW_4+9'd19:ROW_4+9'd18]), .ans(row_ans[113:112]));
    Checker row4_10(.a(memory[ROW_4+9'd21:ROW_4+9'd20]), .b(memory[ROW_4+9'd23:ROW_4+9'd22]), .c(memory[ROW_4+9'd25:ROW_4+9'd24]),
                   .d(memory[ROW_4+9'd27:ROW_4+9'd26]), .e(memory[ROW_4+9'd19:ROW_4+9'd18]), .ans(row_ans[115:114]));
    Checker row4_11(.a(memory[ROW_4+9'd21:ROW_4+9'd20]), .b(memory[ROW_4+9'd23:ROW_4+9'd22]), .c(memory[ROW_4+9'd25:ROW_4+9'd24]),
                   .d(memory[ROW_4+9'd27:ROW_4+9'd26]), .e(memory[ROW_4+9'd29:ROW_4+9'd28]), .ans(row_ans[117:116]));
    Checker row4_12(.a(memory[ROW_4+9'd31:ROW_4+9'd30]), .b(memory[ROW_4+9'd23:ROW_4+9'd22]), .c(memory[ROW_4+9'd25:ROW_4+9'd24]),
                   .d(memory[ROW_4+9'd27:ROW_4+9'd26]), .e(memory[ROW_4+9'd29:ROW_4+9'd28]), .ans(row_ans[119:118]));
    Summarize12 row4_sum(.check_ans(row_ans[119:96]), .out(row_sum[9:8]));

    //row 5(12 possible to check)
    Checker row5_1(.a(memory[ROW_5+9'd1:ROW_5+9'd0]), .b(memory[ROW_5+9'd3:ROW_5+9'd2]), .c(memory[ROW_5+9'd5:ROW_5+9'd4]),
                   .d(memory[ROW_5+9'd7:ROW_5+9'd6]), .e(memory[ROW_5+9'd9:ROW_5+9'd8]), .ans(row_ans[121:120]));
    Checker row5_2(.a(memory[ROW_5+9'd11:ROW_5+9'd10]), .b(memory[ROW_5+9'd3:ROW_5+9'd2]), .c(memory[ROW_5+9'd5:ROW_5+9'd4]),
                   .d(memory[ROW_5+9'd7:ROW_5+9'd6]), .e(memory[ROW_5+9'd9:ROW_5+9'd8]), .ans(row_ans[123:122]));
    Checker row5_3(.a(memory[ROW_5+9'd11:ROW_5+9'd10]), .b(memory[ROW_5+9'd13:ROW_5+9'd12]), .c(memory[ROW_5+9'd5:ROW_5+9'd4]),
                   .d(memory[ROW_5+9'd7:ROW_5+9'd6]), .e(memory[ROW_5+9'd9:ROW_5+9'd8]), .ans(row_ans[125:124]));
    Checker row5_4(.a(memory[ROW_5+9'd11:ROW_5+9'd10]), .b(memory[ROW_5+9'd13:ROW_5+9'd12]), .c(memory[ROW_5+9'd15:ROW_5+9'd14]),
                   .d(memory[ROW_5+9'd7:ROW_5+9'd6]), .e(memory[ROW_5+9'd9:ROW_5+9'd8]), .ans(row_ans[127:126]));
    Checker row5_5(.a(memory[ROW_5+9'd11:ROW_5+9'd10]), .b(memory[ROW_5+9'd13:ROW_5+9'd12]), .c(memory[ROW_5+9'd15:ROW_5+9'd14]),
                   .d(memory[ROW_5+9'd17:ROW_5+9'd16]), .e(memory[ROW_5+9'd9:ROW_5+9'd8]), .ans(row_ans[129:128]));
    Checker row5_6(.a(memory[ROW_5+9'd11:ROW_5+9'd10]), .b(memory[ROW_5+9'd13:ROW_5+9'd12]), .c(memory[ROW_5+9'd15:ROW_5+9'd14]),
                   .d(memory[ROW_5+9'd17:ROW_5+9'd16]), .e(memory[ROW_5+9'd19:ROW_5+9'd18]), .ans(row_ans[131:130]));
    Checker row5_7(.a(memory[ROW_5+9'd21:ROW_5+9'd20]), .b(memory[ROW_5+9'd13:ROW_5+9'd12]), .c(memory[ROW_5+9'd15:ROW_5+9'd14]),
                   .d(memory[ROW_5+9'd17:ROW_5+9'd16]), .e(memory[ROW_5+9'd19:ROW_5+9'd18]), .ans(row_ans[133:132]));
    Checker row5_8(.a(memory[ROW_5+9'd21:ROW_5+9'd20]), .b(memory[ROW_5+9'd23:ROW_5+9'd22]), .c(memory[ROW_5+9'd15:ROW_5+9'd14]),
                   .d(memory[ROW_5+9'd17:ROW_5+9'd16]), .e(memory[ROW_5+9'd19:ROW_5+9'd18]), .ans(row_ans[135:134]));
    Checker row5_9(.a(memory[ROW_5+9'd21:ROW_5+9'd20]), .b(memory[ROW_5+9'd23:ROW_5+9'd22]), .c(memory[ROW_5+9'd25:ROW_5+9'd24]),
                   .d(memory[ROW_5+9'd17:ROW_5+9'd16]), .e(memory[ROW_5+9'd19:ROW_5+9'd18]), .ans(row_ans[137:136]));
    Checker row5_10(.a(memory[ROW_5+9'd21:ROW_5+9'd20]), .b(memory[ROW_5+9'd23:ROW_5+9'd22]), .c(memory[ROW_5+9'd25:ROW_5+9'd24]),
                   .d(memory[ROW_5+9'd27:ROW_5+9'd26]), .e(memory[ROW_5+9'd19:ROW_5+9'd18]), .ans(row_ans[139:138]));
    Checker row5_11(.a(memory[ROW_5+9'd21:ROW_5+9'd20]), .b(memory[ROW_5+9'd23:ROW_5+9'd22]), .c(memory[ROW_5+9'd25:ROW_5+9'd24]),
                   .d(memory[ROW_5+9'd27:ROW_5+9'd26]), .e(memory[ROW_5+9'd29:ROW_5+9'd28]), .ans(row_ans[141:140]));
    Checker row5_12(.a(memory[ROW_5+9'd31:ROW_5+9'd30]), .b(memory[ROW_5+9'd23:ROW_5+9'd22]), .c(memory[ROW_5+9'd25:ROW_5+9'd24]),
                   .d(memory[ROW_5+9'd27:ROW_5+9'd26]), .e(memory[ROW_5+9'd29:ROW_5+9'd28]), .ans(row_ans[143:142]));
    Summarize12 row5_sum(.check_ans(row_ans[143:120]), .out(row_sum[11:10]));

    //row 6(12 possible to check)
    Checker row6_1(.a(memory[ROW_6+9'd1:ROW_6+9'd0]), .b(memory[ROW_6+9'd3:ROW_6+9'd2]), .c(memory[ROW_6+9'd5:ROW_6+9'd4]),
                   .d(memory[ROW_6+9'd7:ROW_6+9'd6]), .e(memory[ROW_6+9'd9:ROW_6+9'd8]), .ans(row_ans[145:144]));
    Checker row6_2(.a(memory[ROW_6+9'd11:ROW_6+9'd10]), .b(memory[ROW_6+9'd3:ROW_6+9'd2]), .c(memory[ROW_6+9'd5:ROW_6+9'd4]),
                   .d(memory[ROW_6+9'd7:ROW_6+9'd6]), .e(memory[ROW_6+9'd9:ROW_6+9'd8]), .ans(row_ans[147:146]));
    Checker row6_3(.a(memory[ROW_6+9'd11:ROW_6+9'd10]), .b(memory[ROW_6+9'd13:ROW_6+9'd12]), .c(memory[ROW_6+9'd5:ROW_6+9'd4]),
                   .d(memory[ROW_6+9'd7:ROW_6+9'd6]), .e(memory[ROW_6+9'd9:ROW_6+9'd8]), .ans(row_ans[149:148]));
    Checker row6_4(.a(memory[ROW_6+9'd11:ROW_6+9'd10]), .b(memory[ROW_6+9'd13:ROW_6+9'd12]), .c(memory[ROW_6+9'd15:ROW_6+9'd14]),
                   .d(memory[ROW_6+9'd7:ROW_6+9'd6]), .e(memory[ROW_6+9'd9:ROW_6+9'd8]), .ans(row_ans[151:150]));
    Checker row6_5(.a(memory[ROW_6+9'd11:ROW_6+9'd10]), .b(memory[ROW_6+9'd13:ROW_6+9'd12]), .c(memory[ROW_6+9'd15:ROW_6+9'd14]),
                   .d(memory[ROW_6+9'd17:ROW_6+9'd16]), .e(memory[ROW_6+9'd9:ROW_6+9'd8]), .ans(row_ans[153:152]));
    Checker row6_6(.a(memory[ROW_6+9'd11:ROW_6+9'd10]), .b(memory[ROW_6+9'd13:ROW_6+9'd12]), .c(memory[ROW_6+9'd15:ROW_6+9'd14]),
                   .d(memory[ROW_6+9'd17:ROW_6+9'd16]), .e(memory[ROW_6+9'd19:ROW_6+9'd18]), .ans(row_ans[155:154]));
    Checker row6_7(.a(memory[ROW_6+9'd21:ROW_6+9'd20]), .b(memory[ROW_6+9'd13:ROW_6+9'd12]), .c(memory[ROW_6+9'd15:ROW_6+9'd14]),
                   .d(memory[ROW_6+9'd17:ROW_6+9'd16]), .e(memory[ROW_6+9'd19:ROW_6+9'd18]), .ans(row_ans[157:156]));
    Checker row6_8(.a(memory[ROW_6+9'd21:ROW_6+9'd20]), .b(memory[ROW_6+9'd23:ROW_6+9'd22]), .c(memory[ROW_6+9'd15:ROW_6+9'd14]),
                   .d(memory[ROW_6+9'd17:ROW_6+9'd16]), .e(memory[ROW_6+9'd19:ROW_6+9'd18]), .ans(row_ans[159:158]));
    Checker row6_9(.a(memory[ROW_6+9'd21:ROW_6+9'd20]), .b(memory[ROW_6+9'd23:ROW_6+9'd22]), .c(memory[ROW_6+9'd25:ROW_6+9'd24]),
                   .d(memory[ROW_6+9'd17:ROW_6+9'd16]), .e(memory[ROW_6+9'd19:ROW_6+9'd18]), .ans(row_ans[161:160]));
    Checker row6_10(.a(memory[ROW_6+9'd21:ROW_6+9'd20]), .b(memory[ROW_6+9'd23:ROW_6+9'd22]), .c(memory[ROW_6+9'd25:ROW_6+9'd24]),
                   .d(memory[ROW_6+9'd27:ROW_6+9'd26]), .e(memory[ROW_6+9'd19:ROW_6+9'd18]), .ans(row_ans[163:162]));
    Checker row6_11(.a(memory[ROW_6+9'd21:ROW_6+9'd20]), .b(memory[ROW_6+9'd23:ROW_6+9'd22]), .c(memory[ROW_6+9'd25:ROW_6+9'd24]),
                   .d(memory[ROW_6+9'd27:ROW_6+9'd26]), .e(memory[ROW_6+9'd29:ROW_6+9'd28]), .ans(row_ans[165:164]));
    Checker row6_12(.a(memory[ROW_6+9'd31:ROW_6+9'd30]), .b(memory[ROW_6+9'd23:ROW_6+9'd22]), .c(memory[ROW_6+9'd25:ROW_6+9'd24]),
                   .d(memory[ROW_6+9'd27:ROW_6+9'd26]), .e(memory[ROW_6+9'd29:ROW_6+9'd28]), .ans(row_ans[167:166]));
    Summarize12 row6_sum(.check_ans(row_ans[167:144]), .out(row_sum[13:12]));

    //row 7(12 possible to check)
    Checker row7_1(.a(memory[ROW_7+9'd1:ROW_7+9'd0]), .b(memory[ROW_7+9'd3:ROW_7+9'd2]), .c(memory[ROW_7+9'd5:ROW_7+9'd4]),
                   .d(memory[ROW_7+9'd7:ROW_7+9'd6]), .e(memory[ROW_7+9'd9:ROW_7+9'd8]), .ans(row_ans[169:168]));
    Checker row7_2(.a(memory[ROW_7+9'd11:ROW_7+9'd10]), .b(memory[ROW_7+9'd3:ROW_7+9'd2]), .c(memory[ROW_7+9'd5:ROW_7+9'd4]),
                   .d(memory[ROW_7+9'd7:ROW_7+9'd6]), .e(memory[ROW_7+9'd9:ROW_7+9'd8]), .ans(row_ans[171:170]));
    Checker row7_3(.a(memory[ROW_7+9'd11:ROW_7+9'd10]), .b(memory[ROW_7+9'd13:ROW_7+9'd12]), .c(memory[ROW_7+9'd5:ROW_7+9'd4]),
                   .d(memory[ROW_7+9'd7:ROW_7+9'd6]), .e(memory[ROW_7+9'd9:ROW_7+9'd8]), .ans(row_ans[173:172]));
    Checker row7_4(.a(memory[ROW_7+9'd11:ROW_7+9'd10]), .b(memory[ROW_7+9'd13:ROW_7+9'd12]), .c(memory[ROW_7+9'd15:ROW_7+9'd14]),
                   .d(memory[ROW_7+9'd7:ROW_7+9'd6]), .e(memory[ROW_7+9'd9:ROW_7+9'd8]), .ans(row_ans[175:174]));
    Checker row7_5(.a(memory[ROW_7+9'd11:ROW_7+9'd10]), .b(memory[ROW_7+9'd13:ROW_7+9'd12]), .c(memory[ROW_7+9'd15:ROW_7+9'd14]),
                   .d(memory[ROW_7+9'd17:ROW_7+9'd16]), .e(memory[ROW_7+9'd9:ROW_7+9'd8]), .ans(row_ans[177:176]));
    Checker row7_6(.a(memory[ROW_7+9'd11:ROW_7+9'd10]), .b(memory[ROW_7+9'd13:ROW_7+9'd12]), .c(memory[ROW_7+9'd15:ROW_7+9'd14]),
                   .d(memory[ROW_7+9'd17:ROW_7+9'd16]), .e(memory[ROW_7+9'd19:ROW_7+9'd18]), .ans(row_ans[179:178]));
    Checker row7_7(.a(memory[ROW_7+9'd21:ROW_7+9'd20]), .b(memory[ROW_7+9'd13:ROW_7+9'd12]), .c(memory[ROW_7+9'd15:ROW_7+9'd14]),
                   .d(memory[ROW_7+9'd17:ROW_7+9'd16]), .e(memory[ROW_7+9'd19:ROW_7+9'd18]), .ans(row_ans[181:180]));
    Checker row7_8(.a(memory[ROW_7+9'd21:ROW_7+9'd20]), .b(memory[ROW_7+9'd23:ROW_7+9'd22]), .c(memory[ROW_7+9'd15:ROW_7+9'd14]),
                   .d(memory[ROW_7+9'd17:ROW_7+9'd16]), .e(memory[ROW_7+9'd19:ROW_7+9'd18]), .ans(row_ans[183:182]));
    Checker row7_9(.a(memory[ROW_7+9'd21:ROW_7+9'd20]), .b(memory[ROW_7+9'd23:ROW_7+9'd22]), .c(memory[ROW_7+9'd25:ROW_7+9'd24]),
                   .d(memory[ROW_7+9'd17:ROW_7+9'd16]), .e(memory[ROW_7+9'd19:ROW_7+9'd18]), .ans(row_ans[185:184]));
    Checker row7_10(.a(memory[ROW_7+9'd21:ROW_7+9'd20]), .b(memory[ROW_7+9'd23:ROW_7+9'd22]), .c(memory[ROW_7+9'd25:ROW_7+9'd24]),
                   .d(memory[ROW_7+9'd27:ROW_7+9'd26]), .e(memory[ROW_7+9'd19:ROW_7+9'd18]), .ans(row_ans[187:186]));
    Checker row7_11(.a(memory[ROW_7+9'd21:ROW_7+9'd20]), .b(memory[ROW_7+9'd23:ROW_7+9'd22]), .c(memory[ROW_7+9'd25:ROW_7+9'd24]),
                   .d(memory[ROW_7+9'd27:ROW_7+9'd26]), .e(memory[ROW_7+9'd29:ROW_7+9'd28]), .ans(row_ans[189:188]));
    Checker row7_12(.a(memory[ROW_7+9'd31:ROW_7+9'd30]), .b(memory[ROW_7+9'd23:ROW_7+9'd22]), .c(memory[ROW_7+9'd25:ROW_7+9'd24]),
                   .d(memory[ROW_7+9'd27:ROW_7+9'd26]), .e(memory[ROW_7+9'd29:ROW_7+9'd28]), .ans(row_ans[191:190]));
    Summarize12 row7_sum(.check_ans(row_ans[191:168]), .out(row_sum[15:14]));

    //row 8(12 possible to check)
    Checker row8_1(.a(memory[ROW_8+9'd1:ROW_8+9'd0]), .b(memory[ROW_8+9'd3:ROW_8+9'd2]), .c(memory[ROW_8+9'd5:ROW_8+9'd4]),
                   .d(memory[ROW_8+9'd7:ROW_8+9'd6]), .e(memory[ROW_8+9'd9:ROW_8+9'd8]), .ans(row_ans[193:192]));
    Checker row8_2(.a(memory[ROW_8+9'd11:ROW_8+9'd10]), .b(memory[ROW_8+9'd3:ROW_8+9'd2]), .c(memory[ROW_8+9'd5:ROW_8+9'd4]),
                   .d(memory[ROW_8+9'd7:ROW_8+9'd6]), .e(memory[ROW_8+9'd9:ROW_8+9'd8]), .ans(row_ans[195:194]));
    Checker row8_3(.a(memory[ROW_8+9'd11:ROW_8+9'd10]), .b(memory[ROW_8+9'd13:ROW_8+9'd12]), .c(memory[ROW_8+9'd5:ROW_8+9'd4]),
                   .d(memory[ROW_8+9'd7:ROW_8+9'd6]), .e(memory[ROW_8+9'd9:ROW_8+9'd8]), .ans(row_ans[197:196]));
    Checker row8_4(.a(memory[ROW_8+9'd11:ROW_8+9'd10]), .b(memory[ROW_8+9'd13:ROW_8+9'd12]), .c(memory[ROW_8+9'd15:ROW_8+9'd14]),
                   .d(memory[ROW_8+9'd7:ROW_8+9'd6]), .e(memory[ROW_8+9'd9:ROW_8+9'd8]), .ans(row_ans[199:198]));
    Checker row8_5(.a(memory[ROW_8+9'd11:ROW_8+9'd10]), .b(memory[ROW_8+9'd13:ROW_8+9'd12]), .c(memory[ROW_8+9'd15:ROW_8+9'd14]),
                   .d(memory[ROW_8+9'd17:ROW_8+9'd16]), .e(memory[ROW_8+9'd9:ROW_8+9'd8]), .ans(row_ans[201:200]));
    Checker row8_6(.a(memory[ROW_8+9'd11:ROW_8+9'd10]), .b(memory[ROW_8+9'd13:ROW_8+9'd12]), .c(memory[ROW_8+9'd15:ROW_8+9'd14]),
                   .d(memory[ROW_8+9'd17:ROW_8+9'd16]), .e(memory[ROW_8+9'd19:ROW_8+9'd18]), .ans(row_ans[203:202]));
    Checker row8_7(.a(memory[ROW_8+9'd21:ROW_8+9'd20]), .b(memory[ROW_8+9'd13:ROW_8+9'd12]), .c(memory[ROW_8+9'd15:ROW_8+9'd14]),
                   .d(memory[ROW_8+9'd17:ROW_8+9'd16]), .e(memory[ROW_8+9'd19:ROW_8+9'd18]), .ans(row_ans[205:204]));
    Checker row8_8(.a(memory[ROW_8+9'd21:ROW_8+9'd20]), .b(memory[ROW_8+9'd23:ROW_8+9'd22]), .c(memory[ROW_8+9'd15:ROW_8+9'd14]),
                   .d(memory[ROW_8+9'd17:ROW_8+9'd16]), .e(memory[ROW_8+9'd19:ROW_8+9'd18]), .ans(row_ans[207:206]));
    Checker row8_9(.a(memory[ROW_8+9'd21:ROW_8+9'd20]), .b(memory[ROW_8+9'd23:ROW_8+9'd22]), .c(memory[ROW_8+9'd25:ROW_8+9'd24]),
                   .d(memory[ROW_8+9'd17:ROW_8+9'd16]), .e(memory[ROW_8+9'd19:ROW_8+9'd18]), .ans(row_ans[209:208]));
    Checker row8_10(.a(memory[ROW_8+9'd21:ROW_8+9'd20]), .b(memory[ROW_8+9'd23:ROW_8+9'd22]), .c(memory[ROW_8+9'd25:ROW_8+9'd24]),
                   .d(memory[ROW_8+9'd27:ROW_8+9'd26]), .e(memory[ROW_8+9'd19:ROW_8+9'd18]), .ans(row_ans[211:210]));
    Checker row8_11(.a(memory[ROW_8+9'd21:ROW_8+9'd20]), .b(memory[ROW_8+9'd23:ROW_8+9'd22]), .c(memory[ROW_8+9'd25:ROW_8+9'd24]),
                   .d(memory[ROW_8+9'd27:ROW_8+9'd26]), .e(memory[ROW_8+9'd29:ROW_8+9'd28]), .ans(row_ans[213:212]));
    Checker row8_12(.a(memory[ROW_8+9'd31:ROW_8+9'd30]), .b(memory[ROW_8+9'd23:ROW_8+9'd22]), .c(memory[ROW_8+9'd25:ROW_8+9'd24]),
                   .d(memory[ROW_8+9'd27:ROW_8+9'd26]), .e(memory[ROW_8+9'd29:ROW_8+9'd28]), .ans(row_ans[215:214]));
    Summarize12 row8_sum(.check_ans(row_ans[215:192]), .out(row_sum[17:16]));

    //row 9(12 possible to check)
    Checker row9_1(.a(memory[ROW_9+9'd1:ROW_9+9'd0]), .b(memory[ROW_9+9'd3:ROW_9+9'd2]), .c(memory[ROW_9+9'd5:ROW_9+9'd4]),
                   .d(memory[ROW_9+9'd7:ROW_9+9'd6]), .e(memory[ROW_9+9'd9:ROW_9+9'd8]), .ans(row_ans[217:216]));
    Checker row9_2(.a(memory[ROW_9+9'd11:ROW_9+9'd10]), .b(memory[ROW_9+9'd3:ROW_9+9'd2]), .c(memory[ROW_9+9'd5:ROW_9+9'd4]),
                   .d(memory[ROW_9+9'd7:ROW_9+9'd6]), .e(memory[ROW_9+9'd9:ROW_9+9'd8]), .ans(row_ans[219:218]));
    Checker row9_3(.a(memory[ROW_9+9'd11:ROW_9+9'd10]), .b(memory[ROW_9+9'd13:ROW_9+9'd12]), .c(memory[ROW_9+9'd5:ROW_9+9'd4]),
                   .d(memory[ROW_9+9'd7:ROW_9+9'd6]), .e(memory[ROW_9+9'd9:ROW_9+9'd8]), .ans(row_ans[221:220]));
    Checker row9_4(.a(memory[ROW_9+9'd11:ROW_9+9'd10]), .b(memory[ROW_9+9'd13:ROW_9+9'd12]), .c(memory[ROW_9+9'd15:ROW_9+9'd14]),
                   .d(memory[ROW_9+9'd7:ROW_9+9'd6]), .e(memory[ROW_9+9'd9:ROW_9+9'd8]), .ans(row_ans[223:222]));
    Checker row9_5(.a(memory[ROW_9+9'd11:ROW_9+9'd10]), .b(memory[ROW_9+9'd13:ROW_9+9'd12]), .c(memory[ROW_9+9'd15:ROW_9+9'd14]),
                   .d(memory[ROW_9+9'd17:ROW_9+9'd16]), .e(memory[ROW_9+9'd9:ROW_9+9'd8]), .ans(row_ans[225:224]));
    Checker row9_6(.a(memory[ROW_9+9'd11:ROW_9+9'd10]), .b(memory[ROW_9+9'd13:ROW_9+9'd12]), .c(memory[ROW_9+9'd15:ROW_9+9'd14]),
                   .d(memory[ROW_9+9'd17:ROW_9+9'd16]), .e(memory[ROW_9+9'd19:ROW_9+9'd18]), .ans(row_ans[227:226]));
    Checker row9_7(.a(memory[ROW_9+9'd21:ROW_9+9'd20]), .b(memory[ROW_9+9'd13:ROW_9+9'd12]), .c(memory[ROW_9+9'd15:ROW_9+9'd14]),
                   .d(memory[ROW_9+9'd17:ROW_9+9'd16]), .e(memory[ROW_9+9'd19:ROW_9+9'd18]), .ans(row_ans[229:228]));
    Checker row9_8(.a(memory[ROW_9+9'd21:ROW_9+9'd20]), .b(memory[ROW_9+9'd23:ROW_9+9'd22]), .c(memory[ROW_9+9'd15:ROW_9+9'd14]),
                   .d(memory[ROW_9+9'd17:ROW_9+9'd16]), .e(memory[ROW_9+9'd19:ROW_9+9'd18]), .ans(row_ans[231:230]));
    Checker row9_9(.a(memory[ROW_9+9'd21:ROW_9+9'd20]), .b(memory[ROW_9+9'd23:ROW_9+9'd22]), .c(memory[ROW_9+9'd25:ROW_9+9'd24]),
                   .d(memory[ROW_9+9'd17:ROW_9+9'd16]), .e(memory[ROW_9+9'd19:ROW_9+9'd18]), .ans(row_ans[233:232]));
    Checker row9_10(.a(memory[ROW_9+9'd21:ROW_9+9'd20]), .b(memory[ROW_9+9'd23:ROW_9+9'd22]), .c(memory[ROW_9+9'd25:ROW_9+9'd24]),
                   .d(memory[ROW_9+9'd27:ROW_9+9'd26]), .e(memory[ROW_9+9'd19:ROW_9+9'd18]), .ans(row_ans[235:234]));
    Checker row9_11(.a(memory[ROW_9+9'd21:ROW_9+9'd20]), .b(memory[ROW_9+9'd23:ROW_9+9'd22]), .c(memory[ROW_9+9'd25:ROW_9+9'd24]),
                   .d(memory[ROW_9+9'd27:ROW_9+9'd26]), .e(memory[ROW_9+9'd29:ROW_9+9'd28]), .ans(row_ans[237:236]));
    Checker row9_12(.a(memory[ROW_9+9'd31:ROW_9+9'd30]), .b(memory[ROW_9+9'd23:ROW_9+9'd22]), .c(memory[ROW_9+9'd25:ROW_9+9'd24]),
                   .d(memory[ROW_9+9'd27:ROW_9+9'd26]), .e(memory[ROW_9+9'd29:ROW_9+9'd28]), .ans(row_ans[239:238]));
    Summarize12 row9_sum(.check_ans(row_ans[239:216]), .out(row_sum[19:18]));

    //row 10(12 possible to check)
    Checker row10_1(.a(memory[ROW_10+9'd1:ROW_10+9'd0]), .b(memory[ROW_10+9'd3:ROW_10+9'd2]), .c(memory[ROW_10+9'd5:ROW_10+9'd4]),
                   .d(memory[ROW_10+9'd7:ROW_10+9'd6]), .e(memory[ROW_10+9'd9:ROW_10+9'd8]), .ans(row_ans[241:240]));
    Checker row10_2(.a(memory[ROW_10+9'd11:ROW_10+9'd10]), .b(memory[ROW_10+9'd3:ROW_10+9'd2]), .c(memory[ROW_10+9'd5:ROW_10+9'd4]),
                   .d(memory[ROW_10+9'd7:ROW_10+9'd6]), .e(memory[ROW_10+9'd9:ROW_10+9'd8]), .ans(row_ans[243:242]));
    Checker row10_3(.a(memory[ROW_10+9'd11:ROW_10+9'd10]), .b(memory[ROW_10+9'd13:ROW_10+9'd12]), .c(memory[ROW_10+9'd5:ROW_10+9'd4]),
                   .d(memory[ROW_10+9'd7:ROW_10+9'd6]), .e(memory[ROW_10+9'd9:ROW_10+9'd8]), .ans(row_ans[245:244]));
    Checker row10_4(.a(memory[ROW_10+9'd11:ROW_10+9'd10]), .b(memory[ROW_10+9'd13:ROW_10+9'd12]), .c(memory[ROW_10+9'd15:ROW_10+9'd14]),
                   .d(memory[ROW_10+9'd7:ROW_10+9'd6]), .e(memory[ROW_10+9'd9:ROW_10+9'd8]), .ans(row_ans[247:246]));
    Checker row10_5(.a(memory[ROW_10+9'd11:ROW_10+9'd10]), .b(memory[ROW_10+9'd13:ROW_10+9'd12]), .c(memory[ROW_10+9'd15:ROW_10+9'd14]),
                   .d(memory[ROW_10+9'd17:ROW_10+9'd16]), .e(memory[ROW_10+9'd9:ROW_10+9'd8]), .ans(row_ans[249:248]));
    Checker row10_6(.a(memory[ROW_10+9'd11:ROW_10+9'd10]), .b(memory[ROW_10+9'd13:ROW_10+9'd12]), .c(memory[ROW_10+9'd15:ROW_10+9'd14]),
                   .d(memory[ROW_10+9'd17:ROW_10+9'd16]), .e(memory[ROW_10+9'd19:ROW_10+9'd18]), .ans(row_ans[251:250]));
    Checker row10_7(.a(memory[ROW_10+9'd21:ROW_10+9'd20]), .b(memory[ROW_10+9'd13:ROW_10+9'd12]), .c(memory[ROW_10+9'd15:ROW_10+9'd14]),
                   .d(memory[ROW_10+9'd17:ROW_10+9'd16]), .e(memory[ROW_10+9'd19:ROW_10+9'd18]), .ans(row_ans[253:252]));
    Checker row10_8(.a(memory[ROW_10+9'd21:ROW_10+9'd20]), .b(memory[ROW_10+9'd23:ROW_10+9'd22]), .c(memory[ROW_10+9'd15:ROW_10+9'd14]),
                   .d(memory[ROW_10+9'd17:ROW_10+9'd16]), .e(memory[ROW_10+9'd19:ROW_10+9'd18]), .ans(row_ans[255:254]));
    Checker row10_9(.a(memory[ROW_10+9'd21:ROW_10+9'd20]), .b(memory[ROW_10+9'd23:ROW_10+9'd22]), .c(memory[ROW_10+9'd25:ROW_10+9'd24]),
                   .d(memory[ROW_10+9'd17:ROW_10+9'd16]), .e(memory[ROW_10+9'd19:ROW_10+9'd18]), .ans(row_ans[257:256]));
    Checker row10_10(.a(memory[ROW_10+9'd21:ROW_10+9'd20]), .b(memory[ROW_10+9'd23:ROW_10+9'd22]), .c(memory[ROW_10+9'd25:ROW_10+9'd24]),
                   .d(memory[ROW_10+9'd27:ROW_10+9'd26]), .e(memory[ROW_10+9'd19:ROW_10+9'd18]), .ans(row_ans[259:258]));
    Checker row10_11(.a(memory[ROW_10+9'd21:ROW_10+9'd20]), .b(memory[ROW_10+9'd23:ROW_10+9'd22]), .c(memory[ROW_10+9'd25:ROW_10+9'd24]),
                   .d(memory[ROW_10+9'd27:ROW_10+9'd26]), .e(memory[ROW_10+9'd29:ROW_10+9'd28]), .ans(row_ans[261:260]));
    Checker row10_12(.a(memory[ROW_10+9'd31:ROW_10+9'd30]), .b(memory[ROW_10+9'd23:ROW_10+9'd22]), .c(memory[ROW_10+9'd25:ROW_10+9'd24]),
                   .d(memory[ROW_10+9'd27:ROW_10+9'd26]), .e(memory[ROW_10+9'd29:ROW_10+9'd28]), .ans(row_ans[263:262]));
    Summarize12 row10_sum(.check_ans(row_ans[263:240]), .out(row_sum[21:20]));

    //row 11(12 possible to check)
    Checker row11_1(.a(memory[ROW_11+9'd1:ROW_11+9'd0]), .b(memory[ROW_11+9'd3:ROW_11+9'd2]), .c(memory[ROW_11+9'd5:ROW_11+9'd4]),
                   .d(memory[ROW_11+9'd7:ROW_11+9'd6]), .e(memory[ROW_11+9'd9:ROW_11+9'd8]), .ans(row_ans[265:264]));
    Checker row11_2(.a(memory[ROW_11+9'd11:ROW_11+9'd10]), .b(memory[ROW_11+9'd3:ROW_11+9'd2]), .c(memory[ROW_11+9'd5:ROW_11+9'd4]),
                   .d(memory[ROW_11+9'd7:ROW_11+9'd6]), .e(memory[ROW_11+9'd9:ROW_11+9'd8]), .ans(row_ans[267:266]));
    Checker row11_3(.a(memory[ROW_11+9'd11:ROW_11+9'd10]), .b(memory[ROW_11+9'd13:ROW_11+9'd12]), .c(memory[ROW_11+9'd5:ROW_11+9'd4]),
                   .d(memory[ROW_11+9'd7:ROW_11+9'd6]), .e(memory[ROW_11+9'd9:ROW_11+9'd8]), .ans(row_ans[269:268]));
    Checker row11_4(.a(memory[ROW_11+9'd11:ROW_11+9'd10]), .b(memory[ROW_11+9'd13:ROW_11+9'd12]), .c(memory[ROW_11+9'd15:ROW_11+9'd14]),
                   .d(memory[ROW_11+9'd7:ROW_11+9'd6]), .e(memory[ROW_11+9'd9:ROW_11+9'd8]), .ans(row_ans[271:270]));
    Checker row11_5(.a(memory[ROW_11+9'd11:ROW_11+9'd10]), .b(memory[ROW_11+9'd13:ROW_11+9'd12]), .c(memory[ROW_11+9'd15:ROW_11+9'd14]),
                   .d(memory[ROW_11+9'd17:ROW_11+9'd16]), .e(memory[ROW_11+9'd9:ROW_11+9'd8]), .ans(row_ans[273:272]));
    Checker row11_6(.a(memory[ROW_11+9'd11:ROW_11+9'd10]), .b(memory[ROW_11+9'd13:ROW_11+9'd12]), .c(memory[ROW_11+9'd15:ROW_11+9'd14]),
                   .d(memory[ROW_11+9'd17:ROW_11+9'd16]), .e(memory[ROW_11+9'd19:ROW_11+9'd18]), .ans(row_ans[275:274]));
    Checker row11_7(.a(memory[ROW_11+9'd21:ROW_11+9'd20]), .b(memory[ROW_11+9'd13:ROW_11+9'd12]), .c(memory[ROW_11+9'd15:ROW_11+9'd14]),
                   .d(memory[ROW_11+9'd17:ROW_11+9'd16]), .e(memory[ROW_11+9'd19:ROW_11+9'd18]), .ans(row_ans[277:276]));
    Checker row11_8(.a(memory[ROW_11+9'd21:ROW_11+9'd20]), .b(memory[ROW_11+9'd23:ROW_11+9'd22]), .c(memory[ROW_11+9'd15:ROW_11+9'd14]),
                   .d(memory[ROW_11+9'd17:ROW_11+9'd16]), .e(memory[ROW_11+9'd19:ROW_11+9'd18]), .ans(row_ans[279:278]));
    Checker row11_9(.a(memory[ROW_11+9'd21:ROW_11+9'd20]), .b(memory[ROW_11+9'd23:ROW_11+9'd22]), .c(memory[ROW_11+9'd25:ROW_11+9'd24]),
                   .d(memory[ROW_11+9'd17:ROW_11+9'd16]), .e(memory[ROW_11+9'd19:ROW_11+9'd18]), .ans(row_ans[281:280]));
    Checker row11_10(.a(memory[ROW_11+9'd21:ROW_11+9'd20]), .b(memory[ROW_11+9'd23:ROW_11+9'd22]), .c(memory[ROW_11+9'd25:ROW_11+9'd24]),
                   .d(memory[ROW_11+9'd27:ROW_11+9'd26]), .e(memory[ROW_11+9'd19:ROW_11+9'd18]), .ans(row_ans[283:282]));
    Checker row11_11(.a(memory[ROW_11+9'd21:ROW_11+9'd20]), .b(memory[ROW_11+9'd23:ROW_11+9'd22]), .c(memory[ROW_11+9'd25:ROW_11+9'd24]),
                   .d(memory[ROW_11+9'd27:ROW_11+9'd26]), .e(memory[ROW_11+9'd29:ROW_11+9'd28]), .ans(row_ans[285:284]));
    Checker row11_12(.a(memory[ROW_11+9'd31:ROW_11+9'd30]), .b(memory[ROW_11+9'd23:ROW_11+9'd22]), .c(memory[ROW_11+9'd25:ROW_11+9'd24]),
                   .d(memory[ROW_11+9'd27:ROW_11+9'd26]), .e(memory[ROW_11+9'd29:ROW_11+9'd28]), .ans(row_ans[287:286]));
    Summarize12 row11_sum(.check_ans(row_ans[287:264]), .out(row_sum[23:22]));

    //row 12(12 possible to check)
    Checker row12_1(.a(memory[ROW_12+9'd1:ROW_12+9'd0]), .b(memory[ROW_12+9'd3:ROW_12+9'd2]), .c(memory[ROW_12+9'd5:ROW_12+9'd4]),
                   .d(memory[ROW_12+9'd7:ROW_12+9'd6]), .e(memory[ROW_12+9'd9:ROW_12+9'd8]), .ans(row_ans[289:288]));
    Checker row12_2(.a(memory[ROW_12+9'd11:ROW_12+9'd10]), .b(memory[ROW_12+9'd3:ROW_12+9'd2]), .c(memory[ROW_12+9'd5:ROW_12+9'd4]),
                   .d(memory[ROW_12+9'd7:ROW_12+9'd6]), .e(memory[ROW_12+9'd9:ROW_12+9'd8]), .ans(row_ans[291:290]));
    Checker row12_3(.a(memory[ROW_12+9'd11:ROW_12+9'd10]), .b(memory[ROW_12+9'd13:ROW_12+9'd12]), .c(memory[ROW_12+9'd5:ROW_12+9'd4]),
                   .d(memory[ROW_12+9'd7:ROW_12+9'd6]), .e(memory[ROW_12+9'd9:ROW_12+9'd8]), .ans(row_ans[293:292]));
    Checker row12_4(.a(memory[ROW_12+9'd11:ROW_12+9'd10]), .b(memory[ROW_12+9'd13:ROW_12+9'd12]), .c(memory[ROW_12+9'd15:ROW_12+9'd14]),
                   .d(memory[ROW_12+9'd7:ROW_12+9'd6]), .e(memory[ROW_12+9'd9:ROW_12+9'd8]), .ans(row_ans[295:294]));
    Checker row12_5(.a(memory[ROW_12+9'd11:ROW_12+9'd10]), .b(memory[ROW_12+9'd13:ROW_12+9'd12]), .c(memory[ROW_12+9'd15:ROW_12+9'd14]),
                   .d(memory[ROW_12+9'd17:ROW_12+9'd16]), .e(memory[ROW_12+9'd9:ROW_12+9'd8]), .ans(row_ans[297:296]));
    Checker row12_6(.a(memory[ROW_12+9'd11:ROW_12+9'd10]), .b(memory[ROW_12+9'd13:ROW_12+9'd12]), .c(memory[ROW_12+9'd15:ROW_12+9'd14]),
                   .d(memory[ROW_12+9'd17:ROW_12+9'd16]), .e(memory[ROW_12+9'd19:ROW_12+9'd18]), .ans(row_ans[299:298]));
    Checker row12_7(.a(memory[ROW_12+9'd21:ROW_12+9'd20]), .b(memory[ROW_12+9'd13:ROW_12+9'd12]), .c(memory[ROW_12+9'd15:ROW_12+9'd14]),
                   .d(memory[ROW_12+9'd17:ROW_12+9'd16]), .e(memory[ROW_12+9'd19:ROW_12+9'd18]), .ans(row_ans[301:300]));
    Checker row12_8(.a(memory[ROW_12+9'd21:ROW_12+9'd20]), .b(memory[ROW_12+9'd23:ROW_12+9'd22]), .c(memory[ROW_12+9'd15:ROW_12+9'd14]),
                   .d(memory[ROW_12+9'd17:ROW_12+9'd16]), .e(memory[ROW_12+9'd19:ROW_12+9'd18]), .ans(row_ans[303:302]));
    Checker row12_9(.a(memory[ROW_12+9'd21:ROW_12+9'd20]), .b(memory[ROW_12+9'd23:ROW_12+9'd22]), .c(memory[ROW_12+9'd25:ROW_12+9'd24]),
                   .d(memory[ROW_12+9'd17:ROW_12+9'd16]), .e(memory[ROW_12+9'd19:ROW_12+9'd18]), .ans(row_ans[305:304]));
    Checker row12_10(.a(memory[ROW_12+9'd21:ROW_12+9'd20]), .b(memory[ROW_12+9'd23:ROW_12+9'd22]), .c(memory[ROW_12+9'd25:ROW_12+9'd24]),
                   .d(memory[ROW_12+9'd27:ROW_12+9'd26]), .e(memory[ROW_12+9'd19:ROW_12+9'd18]), .ans(row_ans[307:306]));
    Checker row12_11(.a(memory[ROW_12+9'd21:ROW_12+9'd20]), .b(memory[ROW_12+9'd23:ROW_12+9'd22]), .c(memory[ROW_12+9'd25:ROW_12+9'd24]),
                   .d(memory[ROW_12+9'd27:ROW_12+9'd26]), .e(memory[ROW_12+9'd29:ROW_12+9'd28]), .ans(row_ans[309:308]));
    Checker row12_12(.a(memory[ROW_12+9'd31:ROW_12+9'd30]), .b(memory[ROW_12+9'd23:ROW_12+9'd22]), .c(memory[ROW_12+9'd25:ROW_12+9'd24]),
                   .d(memory[ROW_12+9'd27:ROW_12+9'd26]), .e(memory[ROW_12+9'd29:ROW_12+9'd28]), .ans(row_ans[311:310]));
    Summarize12 row12_sum(.check_ans(row_ans[311:288]), .out(row_sum[25:24]));

    //row 13(12 possible to check)
    Checker row13_1(.a(memory[ROW_13+9'd1:ROW_13+9'd0]), .b(memory[ROW_13+9'd3:ROW_13+9'd2]), .c(memory[ROW_13+9'd5:ROW_13+9'd4]),
                   .d(memory[ROW_13+9'd7:ROW_13+9'd6]), .e(memory[ROW_13+9'd9:ROW_13+9'd8]), .ans(row_ans[313:312]));
    Checker row13_2(.a(memory[ROW_13+9'd11:ROW_13+9'd10]), .b(memory[ROW_13+9'd3:ROW_13+9'd2]), .c(memory[ROW_13+9'd5:ROW_13+9'd4]),
                   .d(memory[ROW_13+9'd7:ROW_13+9'd6]), .e(memory[ROW_13+9'd9:ROW_13+9'd8]), .ans(row_ans[315:314]));
    Checker row13_3(.a(memory[ROW_13+9'd11:ROW_13+9'd10]), .b(memory[ROW_13+9'd13:ROW_13+9'd12]), .c(memory[ROW_13+9'd5:ROW_13+9'd4]),
                   .d(memory[ROW_13+9'd7:ROW_13+9'd6]), .e(memory[ROW_13+9'd9:ROW_13+9'd8]), .ans(row_ans[317:316]));
    Checker row13_4(.a(memory[ROW_13+9'd11:ROW_13+9'd10]), .b(memory[ROW_13+9'd13:ROW_13+9'd12]), .c(memory[ROW_13+9'd15:ROW_13+9'd14]),
                   .d(memory[ROW_13+9'd7:ROW_13+9'd6]), .e(memory[ROW_13+9'd9:ROW_13+9'd8]), .ans(row_ans[319:318]));
    Checker row13_5(.a(memory[ROW_13+9'd11:ROW_13+9'd10]), .b(memory[ROW_13+9'd13:ROW_13+9'd12]), .c(memory[ROW_13+9'd15:ROW_13+9'd14]),
                   .d(memory[ROW_13+9'd17:ROW_13+9'd16]), .e(memory[ROW_13+9'd9:ROW_13+9'd8]), .ans(row_ans[321:320]));
    Checker row13_6(.a(memory[ROW_13+9'd11:ROW_13+9'd10]), .b(memory[ROW_13+9'd13:ROW_13+9'd12]), .c(memory[ROW_13+9'd15:ROW_13+9'd14]),
                   .d(memory[ROW_13+9'd17:ROW_13+9'd16]), .e(memory[ROW_13+9'd19:ROW_13+9'd18]), .ans(row_ans[323:322]));
    Checker row13_7(.a(memory[ROW_13+9'd21:ROW_13+9'd20]), .b(memory[ROW_13+9'd13:ROW_13+9'd12]), .c(memory[ROW_13+9'd15:ROW_13+9'd14]),
                   .d(memory[ROW_13+9'd17:ROW_13+9'd16]), .e(memory[ROW_13+9'd19:ROW_13+9'd18]), .ans(row_ans[325:324]));
    Checker row13_8(.a(memory[ROW_13+9'd21:ROW_13+9'd20]), .b(memory[ROW_13+9'd23:ROW_13+9'd22]), .c(memory[ROW_13+9'd15:ROW_13+9'd14]),
                   .d(memory[ROW_13+9'd17:ROW_13+9'd16]), .e(memory[ROW_13+9'd19:ROW_13+9'd18]), .ans(row_ans[327:326]));
    Checker row13_9(.a(memory[ROW_13+9'd21:ROW_13+9'd20]), .b(memory[ROW_13+9'd23:ROW_13+9'd22]), .c(memory[ROW_13+9'd25:ROW_13+9'd24]),
                   .d(memory[ROW_13+9'd17:ROW_13+9'd16]), .e(memory[ROW_13+9'd19:ROW_13+9'd18]), .ans(row_ans[329:328]));
    Checker row13_10(.a(memory[ROW_13+9'd21:ROW_13+9'd20]), .b(memory[ROW_13+9'd23:ROW_13+9'd22]), .c(memory[ROW_13+9'd25:ROW_13+9'd24]),
                   .d(memory[ROW_13+9'd27:ROW_13+9'd26]), .e(memory[ROW_13+9'd19:ROW_13+9'd18]), .ans(row_ans[331:330]));
    Checker row13_11(.a(memory[ROW_13+9'd21:ROW_13+9'd20]), .b(memory[ROW_13+9'd23:ROW_13+9'd22]), .c(memory[ROW_13+9'd25:ROW_13+9'd24]),
                   .d(memory[ROW_13+9'd27:ROW_13+9'd26]), .e(memory[ROW_13+9'd29:ROW_13+9'd28]), .ans(row_ans[333:332]));
    Checker row13_12(.a(memory[ROW_13+9'd31:ROW_13+9'd30]), .b(memory[ROW_13+9'd23:ROW_13+9'd22]), .c(memory[ROW_13+9'd25:ROW_13+9'd24]),
                   .d(memory[ROW_13+9'd27:ROW_13+9'd26]), .e(memory[ROW_13+9'd29:ROW_13+9'd28]), .ans(row_ans[335:334]));
    Summarize12 row13_sum(.check_ans(row_ans[335:312]), .out(row_sum[27:26]));

    //row 14(12 possible to check)
    Checker row14_1(.a(memory[ROW_14+9'd1:ROW_14+9'd0]), .b(memory[ROW_14+9'd3:ROW_14+9'd2]), .c(memory[ROW_14+9'd5:ROW_14+9'd4]),
                   .d(memory[ROW_14+9'd7:ROW_14+9'd6]), .e(memory[ROW_14+9'd9:ROW_14+9'd8]), .ans(row_ans[337:336]));
    Checker row14_2(.a(memory[ROW_14+9'd11:ROW_14+9'd10]), .b(memory[ROW_14+9'd3:ROW_14+9'd2]), .c(memory[ROW_14+9'd5:ROW_14+9'd4]),
                   .d(memory[ROW_14+9'd7:ROW_14+9'd6]), .e(memory[ROW_14+9'd9:ROW_14+9'd8]), .ans(row_ans[339:338]));
    Checker row14_3(.a(memory[ROW_14+9'd11:ROW_14+9'd10]), .b(memory[ROW_14+9'd13:ROW_14+9'd12]), .c(memory[ROW_14+9'd5:ROW_14+9'd4]),
                   .d(memory[ROW_14+9'd7:ROW_14+9'd6]), .e(memory[ROW_14+9'd9:ROW_14+9'd8]), .ans(row_ans[341:340]));
    Checker row14_4(.a(memory[ROW_14+9'd11:ROW_14+9'd10]), .b(memory[ROW_14+9'd13:ROW_14+9'd12]), .c(memory[ROW_14+9'd15:ROW_14+9'd14]),
                   .d(memory[ROW_14+9'd7:ROW_14+9'd6]), .e(memory[ROW_14+9'd9:ROW_14+9'd8]), .ans(row_ans[343:342]));
    Checker row14_5(.a(memory[ROW_14+9'd11:ROW_14+9'd10]), .b(memory[ROW_14+9'd13:ROW_14+9'd12]), .c(memory[ROW_14+9'd15:ROW_14+9'd14]),
                   .d(memory[ROW_14+9'd17:ROW_14+9'd16]), .e(memory[ROW_14+9'd9:ROW_14+9'd8]), .ans(row_ans[345:344]));
    Checker row14_6(.a(memory[ROW_14+9'd11:ROW_14+9'd10]), .b(memory[ROW_14+9'd13:ROW_14+9'd12]), .c(memory[ROW_14+9'd15:ROW_14+9'd14]),
                   .d(memory[ROW_14+9'd17:ROW_14+9'd16]), .e(memory[ROW_14+9'd19:ROW_14+9'd18]), .ans(row_ans[347:346]));
    Checker row14_7(.a(memory[ROW_14+9'd21:ROW_14+9'd20]), .b(memory[ROW_14+9'd13:ROW_14+9'd12]), .c(memory[ROW_14+9'd15:ROW_14+9'd14]),
                   .d(memory[ROW_14+9'd17:ROW_14+9'd16]), .e(memory[ROW_14+9'd19:ROW_14+9'd18]), .ans(row_ans[349:348]));
    Checker row14_8(.a(memory[ROW_14+9'd21:ROW_14+9'd20]), .b(memory[ROW_14+9'd23:ROW_14+9'd22]), .c(memory[ROW_14+9'd15:ROW_14+9'd14]),
                   .d(memory[ROW_14+9'd17:ROW_14+9'd16]), .e(memory[ROW_14+9'd19:ROW_14+9'd18]), .ans(row_ans[351:350]));
    Checker row14_9(.a(memory[ROW_14+9'd21:ROW_14+9'd20]), .b(memory[ROW_14+9'd23:ROW_14+9'd22]), .c(memory[ROW_14+9'd25:ROW_14+9'd24]),
                   .d(memory[ROW_14+9'd17:ROW_14+9'd16]), .e(memory[ROW_14+9'd19:ROW_14+9'd18]), .ans(row_ans[353:352]));
    Checker row14_10(.a(memory[ROW_14+9'd21:ROW_14+9'd20]), .b(memory[ROW_14+9'd23:ROW_14+9'd22]), .c(memory[ROW_14+9'd25:ROW_14+9'd24]),
                   .d(memory[ROW_14+9'd27:ROW_14+9'd26]), .e(memory[ROW_14+9'd19:ROW_14+9'd18]), .ans(row_ans[355:354]));
    Checker row14_11(.a(memory[ROW_14+9'd21:ROW_14+9'd20]), .b(memory[ROW_14+9'd23:ROW_14+9'd22]), .c(memory[ROW_14+9'd25:ROW_14+9'd24]),
                   .d(memory[ROW_14+9'd27:ROW_14+9'd26]), .e(memory[ROW_14+9'd29:ROW_14+9'd28]), .ans(row_ans[357:356]));
    Checker row14_12(.a(memory[ROW_14+9'd31:ROW_14+9'd30]), .b(memory[ROW_14+9'd23:ROW_14+9'd22]), .c(memory[ROW_14+9'd25:ROW_14+9'd24]),
                   .d(memory[ROW_14+9'd27:ROW_14+9'd26]), .e(memory[ROW_14+9'd29:ROW_14+9'd28]), .ans(row_ans[359:358]));
    Summarize12 row14_sum(.check_ans(row_ans[359:336]), .out(row_sum[29:28]));

    //row 15(12 possible to check)
    Checker row15_1(.a(memory[ROW_15+9'd1:ROW_15+9'd0]), .b(memory[ROW_15+9'd3:ROW_15+9'd2]), .c(memory[ROW_15+9'd5:ROW_15+9'd4]),
                   .d(memory[ROW_15+9'd7:ROW_15+9'd6]), .e(memory[ROW_15+9'd9:ROW_15+9'd8]), .ans(row_ans[361:360]));
    Checker row15_2(.a(memory[ROW_15+9'd11:ROW_15+9'd10]), .b(memory[ROW_15+9'd3:ROW_15+9'd2]), .c(memory[ROW_15+9'd5:ROW_15+9'd4]),
                   .d(memory[ROW_15+9'd7:ROW_15+9'd6]), .e(memory[ROW_15+9'd9:ROW_15+9'd8]), .ans(row_ans[363:362]));
    Checker row15_3(.a(memory[ROW_15+9'd11:ROW_15+9'd10]), .b(memory[ROW_15+9'd13:ROW_15+9'd12]), .c(memory[ROW_15+9'd5:ROW_15+9'd4]),
                   .d(memory[ROW_15+9'd7:ROW_15+9'd6]), .e(memory[ROW_15+9'd9:ROW_15+9'd8]), .ans(row_ans[365:364]));
    Checker row15_4(.a(memory[ROW_15+9'd11:ROW_15+9'd10]), .b(memory[ROW_15+9'd13:ROW_15+9'd12]), .c(memory[ROW_15+9'd15:ROW_15+9'd14]),
                   .d(memory[ROW_15+9'd7:ROW_15+9'd6]), .e(memory[ROW_15+9'd9:ROW_15+9'd8]), .ans(row_ans[367:366]));
    Checker row15_5(.a(memory[ROW_15+9'd11:ROW_15+9'd10]), .b(memory[ROW_15+9'd13:ROW_15+9'd12]), .c(memory[ROW_15+9'd15:ROW_15+9'd14]),
                   .d(memory[ROW_15+9'd17:ROW_15+9'd16]), .e(memory[ROW_15+9'd9:ROW_15+9'd8]), .ans(row_ans[369:368]));
    Checker row15_6(.a(memory[ROW_15+9'd11:ROW_15+9'd10]), .b(memory[ROW_15+9'd13:ROW_15+9'd12]), .c(memory[ROW_15+9'd15:ROW_15+9'd14]),
                   .d(memory[ROW_15+9'd17:ROW_15+9'd16]), .e(memory[ROW_15+9'd19:ROW_15+9'd18]), .ans(row_ans[371:370]));
    Checker row15_7(.a(memory[ROW_15+9'd21:ROW_15+9'd20]), .b(memory[ROW_15+9'd13:ROW_15+9'd12]), .c(memory[ROW_15+9'd15:ROW_15+9'd14]),
                   .d(memory[ROW_15+9'd17:ROW_15+9'd16]), .e(memory[ROW_15+9'd19:ROW_15+9'd18]), .ans(row_ans[373:372]));
    Checker row15_8(.a(memory[ROW_15+9'd21:ROW_15+9'd20]), .b(memory[ROW_15+9'd23:ROW_15+9'd22]), .c(memory[ROW_15+9'd15:ROW_15+9'd14]),
                   .d(memory[ROW_15+9'd17:ROW_15+9'd16]), .e(memory[ROW_15+9'd19:ROW_15+9'd18]), .ans(row_ans[375:374]));
    Checker row15_9(.a(memory[ROW_15+9'd21:ROW_15+9'd20]), .b(memory[ROW_15+9'd23:ROW_15+9'd22]), .c(memory[ROW_15+9'd25:ROW_15+9'd24]),
                   .d(memory[ROW_15+9'd17:ROW_15+9'd16]), .e(memory[ROW_15+9'd19:ROW_15+9'd18]), .ans(row_ans[377:376]));
    Checker row15_10(.a(memory[ROW_15+9'd21:ROW_15+9'd20]), .b(memory[ROW_15+9'd23:ROW_15+9'd22]), .c(memory[ROW_15+9'd25:ROW_15+9'd24]),
                   .d(memory[ROW_15+9'd27:ROW_15+9'd26]), .e(memory[ROW_15+9'd19:ROW_15+9'd18]), .ans(row_ans[379:378]));
    Checker row15_11(.a(memory[ROW_15+9'd21:ROW_15+9'd20]), .b(memory[ROW_15+9'd23:ROW_15+9'd22]), .c(memory[ROW_15+9'd25:ROW_15+9'd24]),
                   .d(memory[ROW_15+9'd27:ROW_15+9'd26]), .e(memory[ROW_15+9'd29:ROW_15+9'd28]), .ans(row_ans[381:380]));
    Checker row15_12(.a(memory[ROW_15+9'd31:ROW_15+9'd30]), .b(memory[ROW_15+9'd23:ROW_15+9'd22]), .c(memory[ROW_15+9'd25:ROW_15+9'd24]),
                   .d(memory[ROW_15+9'd27:ROW_15+9'd26]), .e(memory[ROW_15+9'd29:ROW_15+9'd28]), .ans(row_ans[383:382]));
    Summarize12 row15_sum(.check_ans(row_ans[383:360]), .out(row_sum[31:30]));

//--------------------column checkers------------------------
    // Column 0 (12 possible to check)
    Checker col0_1(.a(memory[COL_0+9'd1:COL_0+9'd0]), .b(memory[COL_0+9'd33:COL_0+9'd32]), .c(memory[COL_0+9'd65:COL_0+9'd64]),
                   .d(memory[COL_0+9'd97:COL_0+9'd96]), .e(memory[COL_0+9'd129:COL_0+9'd128]), .ans(col_ans[1:0]));
    Checker col0_2(.a(memory[COL_0+9'd161:COL_0+9'd160]), .b(memory[COL_0+9'd33:COL_0+9'd32]), .c(memory[COL_0+9'd65:COL_0+9'd64]),
                   .d(memory[COL_0+9'd97:COL_0+9'd96]), .e(memory[COL_0+9'd129:COL_0+9'd128]), .ans(col_ans[3:2]));
    Checker col0_3(.a(memory[COL_0+9'd161:COL_0+9'd160]), .b(memory[COL_0+9'd193:COL_0+9'd192]), .c(memory[COL_0+9'd65:COL_0+9'd64]),
                   .d(memory[COL_0+9'd97:COL_0+9'd96]), .e(memory[COL_0+9'd129:COL_0+9'd128]), .ans(col_ans[5:4]));
    Checker col0_4(.a(memory[COL_0+9'd161:COL_0+9'd160]), .b(memory[COL_0+9'd193:COL_0+9'd192]), .c(memory[COL_0+9'd225:COL_0+9'd224]),
                   .d(memory[COL_0+9'd97:COL_0+9'd96]), .e(memory[COL_0+9'd129:COL_0+9'd128]), .ans(col_ans[7:6]));
    Checker col0_5(.a(memory[COL_0+9'd161:COL_0+9'd160]), .b(memory[COL_0+9'd193:COL_0+9'd192]), .c(memory[COL_0+9'd225:COL_0+9'd224]),
                   .d(memory[COL_0+9'd257:COL_0+9'd256]), .e(memory[COL_0+9'd129:COL_0+9'd128]), .ans(col_ans[9:8]));
    Checker col0_6(.a(memory[COL_0+9'd161:COL_0+9'd160]), .b(memory[COL_0+9'd193:COL_0+9'd192]), .c(memory[COL_0+9'd225:COL_0+9'd224]),
                   .d(memory[COL_0+9'd257:COL_0+9'd256]), .e(memory[COL_0+9'd289:COL_0+9'd288]), .ans(col_ans[11:10]));
    Checker col0_7(.a(memory[COL_0+9'd321:COL_0+9'd320]), .b(memory[COL_0+9'd193:COL_0+9'd192]), .c(memory[COL_0+9'd225:COL_0+9'd224]),
                   .d(memory[COL_0+9'd257:COL_0+9'd256]), .e(memory[COL_0+9'd289:COL_0+9'd288]), .ans(col_ans[13:12]));
    Checker col0_8(.a(memory[COL_0+9'd321:COL_0+9'd320]), .b(memory[COL_0+9'd353:COL_0+9'd352]), .c(memory[COL_0+9'd225:COL_0+9'd224]),
                   .d(memory[COL_0+9'd257:COL_0+9'd256]), .e(memory[COL_0+9'd289:COL_0+9'd288]), .ans(col_ans[15:14]));
    Checker col0_9(.a(memory[COL_0+9'd321:COL_0+9'd320]), .b(memory[COL_0+9'd353:COL_0+9'd352]), .c(memory[COL_0+9'd385:COL_0+9'd384]),
                   .d(memory[COL_0+9'd257:COL_0+9'd256]), .e(memory[COL_0+9'd289:COL_0+9'd288]), .ans(col_ans[17:16]));
    Checker col0_10(.a(memory[COL_0+9'd321:COL_0+9'd320]), .b(memory[COL_0+9'd353:COL_0+9'd352]), .c(memory[COL_0+9'd385:COL_0+9'd384]),
                   .d(memory[COL_0+9'd417:COL_0+9'd416]), .e(memory[COL_0+9'd289:COL_0+9'd288]), .ans(col_ans[19:18]));
    Checker col0_11(.a(memory[COL_0+9'd321:COL_0+9'd320]), .b(memory[COL_0+9'd353:COL_0+9'd352]), .c(memory[COL_0+9'd385:COL_0+9'd384]),
                   .d(memory[COL_0+9'd417:COL_0+9'd416]), .e(memory[COL_0+9'd449:COL_0+9'd448]), .ans(col_ans[21:20]));
    Checker col0_12(.a(memory[COL_0+9'd481:COL_0+9'd480]), .b(memory[COL_0+9'd353:COL_0+9'd352]), .c(memory[COL_0+9'd385:COL_0+9'd384]),
                   .d(memory[COL_0+9'd417:COL_0+9'd416]), .e(memory[COL_0+9'd449:COL_0+9'd448]), .ans(col_ans[23:22]));
    Summarize12 col0_sum(.check_ans(col_ans[23:0]), .out(col_sum[1:0]));

    // Column 1 (12 possible to check)
    Checker col1_1(.a(memory[COL_1+9'd1:COL_1+9'd0]), .b(memory[COL_1+9'd33:COL_1+9'd32]), .c(memory[COL_1+9'd65:COL_1+9'd64]),
                   .d(memory[COL_1+9'd97:COL_1+9'd96]), .e(memory[COL_1+9'd129:COL_1+9'd128]), .ans(col_ans[25:24]));
    Checker col1_2(.a(memory[COL_1+9'd161:COL_1+9'd160]), .b(memory[COL_1+9'd33:COL_1+9'd32]), .c(memory[COL_1+9'd65:COL_1+9'd64]),
                   .d(memory[COL_1+9'd97:COL_1+9'd96]), .e(memory[COL_1+9'd129:COL_1+9'd128]), .ans(col_ans[27:26]));
    Checker col1_3(.a(memory[COL_1+9'd161:COL_1+9'd160]), .b(memory[COL_1+9'd193:COL_1+9'd192]), .c(memory[COL_1+9'd65:COL_1+9'd64]),
                   .d(memory[COL_1+9'd97:COL_1+9'd96]), .e(memory[COL_1+9'd129:COL_1+9'd128]), .ans(col_ans[29:28]));
    Checker col1_4(.a(memory[COL_1+9'd161:COL_1+9'd160]), .b(memory[COL_1+9'd193:COL_1+9'd192]), .c(memory[COL_1+9'd225:COL_1+9'd224]),
                   .d(memory[COL_1+9'd97:COL_1+9'd96]), .e(memory[COL_1+9'd129:COL_1+9'd128]), .ans(col_ans[31:30]));
    Checker col1_5(.a(memory[COL_1+9'd161:COL_1+9'd160]), .b(memory[COL_1+9'd193:COL_1+9'd192]), .c(memory[COL_1+9'd225:COL_1+9'd224]),
                   .d(memory[COL_1+9'd257:COL_1+9'd256]), .e(memory[COL_1+9'd129:COL_1+9'd128]), .ans(col_ans[33:32]));
    Checker col1_6(.a(memory[COL_1+9'd161:COL_1+9'd160]), .b(memory[COL_1+9'd193:COL_1+9'd192]), .c(memory[COL_1+9'd225:COL_1+9'd224]),
                   .d(memory[COL_1+9'd257:COL_1+9'd256]), .e(memory[COL_1+9'd289:COL_1+9'd288]), .ans(col_ans[35:34]));
    Checker col1_7(.a(memory[COL_1+9'd321:COL_1+9'd320]), .b(memory[COL_1+9'd193:COL_1+9'd192]), .c(memory[COL_1+9'd225:COL_1+9'd224]),
                   .d(memory[COL_1+9'd257:COL_1+9'd256]), .e(memory[COL_1+9'd289:COL_1+9'd288]), .ans(col_ans[37:36]));
    Checker col1_8(.a(memory[COL_1+9'd321:COL_1+9'd320]), .b(memory[COL_1+9'd353:COL_1+9'd352]), .c(memory[COL_1+9'd225:COL_1+9'd224]),
                   .d(memory[COL_1+9'd257:COL_1+9'd256]), .e(memory[COL_1+9'd289:COL_1+9'd288]), .ans(col_ans[39:38]));
    Checker col1_9(.a(memory[COL_1+9'd321:COL_1+9'd320]), .b(memory[COL_1+9'd353:COL_1+9'd352]), .c(memory[COL_1+9'd385:COL_1+9'd384]),
                   .d(memory[COL_1+9'd257:COL_1+9'd256]), .e(memory[COL_1+9'd289:COL_1+9'd288]), .ans(col_ans[41:40]));
    Checker col1_10(.a(memory[COL_1+9'd321:COL_1+9'd320]), .b(memory[COL_1+9'd353:COL_1+9'd352]), .c(memory[COL_1+9'd385:COL_1+9'd384]),
                   .d(memory[COL_1+9'd417:COL_1+9'd416]), .e(memory[COL_1+9'd289:COL_1+9'd288]), .ans(col_ans[43:42]));
    Checker col1_11(.a(memory[COL_1+9'd321:COL_1+9'd320]), .b(memory[COL_1+9'd353:COL_1+9'd352]), .c(memory[COL_1+9'd385:COL_1+9'd384]),
                   .d(memory[COL_1+9'd417:COL_1+9'd416]), .e(memory[COL_1+9'd449:COL_1+9'd448]), .ans(col_ans[45:44]));
    Checker col1_12(.a(memory[COL_1+9'd481:COL_1+9'd480]), .b(memory[COL_1+9'd353:COL_1+9'd352]), .c(memory[COL_1+9'd385:COL_1+9'd384]),
                   .d(memory[COL_1+9'd417:COL_1+9'd416]), .e(memory[COL_1+9'd449:COL_1+9'd448]), .ans(col_ans[47:46]));
    Summarize12 col1_sum(.check_ans(col_ans[47:24]), .out(col_sum[3:2]));

    // Column 2 (12 possible to check)
    Checker col2_1(.a(memory[COL_2+9'd1:COL_2+9'd0]), .b(memory[COL_2+9'd33:COL_2+9'd32]), .c(memory[COL_2+9'd65:COL_2+9'd64]),
                   .d(memory[COL_2+9'd97:COL_2+9'd96]), .e(memory[COL_2+9'd129:COL_2+9'd128]), .ans(col_ans[49:48]));
    Checker col2_2(.a(memory[COL_2+9'd161:COL_2+9'd160]), .b(memory[COL_2+9'd33:COL_2+9'd32]), .c(memory[COL_2+9'd65:COL_2+9'd64]),
                   .d(memory[COL_2+9'd97:COL_2+9'd96]), .e(memory[COL_2+9'd129:COL_2+9'd128]), .ans(col_ans[51:50]));
    Checker col2_3(.a(memory[COL_2+9'd161:COL_2+9'd160]), .b(memory[COL_2+9'd193:COL_2+9'd192]), .c(memory[COL_2+9'd65:COL_2+9'd64]),
                   .d(memory[COL_2+9'd97:COL_2+9'd96]), .e(memory[COL_2+9'd129:COL_2+9'd128]), .ans(col_ans[53:52]));
    Checker col2_4(.a(memory[COL_2+9'd161:COL_2+9'd160]), .b(memory[COL_2+9'd193:COL_2+9'd192]), .c(memory[COL_2+9'd225:COL_2+9'd224]),
                   .d(memory[COL_2+9'd97:COL_2+9'd96]), .e(memory[COL_2+9'd129:COL_2+9'd128]), .ans(col_ans[55:54]));
    Checker col2_5(.a(memory[COL_2+9'd161:COL_2+9'd160]), .b(memory[COL_2+9'd193:COL_2+9'd192]), .c(memory[COL_2+9'd225:COL_2+9'd224]),
                   .d(memory[COL_2+9'd257:COL_2+9'd256]), .e(memory[COL_2+9'd129:COL_2+9'd128]), .ans(col_ans[57:56]));
    Checker col2_6(.a(memory[COL_2+9'd161:COL_2+9'd160]), .b(memory[COL_2+9'd193:COL_2+9'd192]), .c(memory[COL_2+9'd225:COL_2+9'd224]),
                   .d(memory[COL_2+9'd257:COL_2+9'd256]), .e(memory[COL_2+9'd289:COL_2+9'd288]), .ans(col_ans[59:58]));
    Checker col2_7(.a(memory[COL_2+9'd321:COL_2+9'd320]), .b(memory[COL_2+9'd193:COL_2+9'd192]), .c(memory[COL_2+9'd225:COL_2+9'd224]),
                   .d(memory[COL_2+9'd257:COL_2+9'd256]), .e(memory[COL_2+9'd289:COL_2+9'd288]), .ans(col_ans[61:60]));
    Checker col2_8(.a(memory[COL_2+9'd321:COL_2+9'd320]), .b(memory[COL_2+9'd353:COL_2+9'd352]), .c(memory[COL_2+9'd225:COL_2+9'd224]),
                   .d(memory[COL_2+9'd257:COL_2+9'd256]), .e(memory[COL_2+9'd289:COL_2+9'd288]), .ans(col_ans[63:62]));
    Checker col2_9(.a(memory[COL_2+9'd321:COL_2+9'd320]), .b(memory[COL_2+9'd353:COL_2+9'd352]), .c(memory[COL_2+9'd385:COL_2+9'd384]),
                   .d(memory[COL_2+9'd257:COL_2+9'd256]), .e(memory[COL_2+9'd289:COL_2+9'd288]), .ans(col_ans[65:64]));
    Checker col2_10(.a(memory[COL_2+9'd321:COL_2+9'd320]), .b(memory[COL_2+9'd353:COL_2+9'd352]), .c(memory[COL_2+9'd385:COL_2+9'd384]),
                   .d(memory[COL_2+9'd417:COL_2+9'd416]), .e(memory[COL_2+9'd289:COL_2+9'd288]), .ans(col_ans[67:66]));
    Checker col2_11(.a(memory[COL_2+9'd321:COL_2+9'd320]), .b(memory[COL_2+9'd353:COL_2+9'd352]), .c(memory[COL_2+9'd385:COL_2+9'd384]),
                   .d(memory[COL_2+9'd417:COL_2+9'd416]), .e(memory[COL_2+9'd449:COL_2+9'd448]), .ans(col_ans[69:68]));
    Checker col2_12(.a(memory[COL_2+9'd481:COL_2+9'd480]), .b(memory[COL_2+9'd353:COL_2+9'd352]), .c(memory[COL_2+9'd385:COL_2+9'd384]),
                   .d(memory[COL_2+9'd417:COL_2+9'd416]), .e(memory[COL_2+9'd449:COL_2+9'd448]), .ans(col_ans[71:70]));
    Summarize12 col2_sum(.check_ans(col_ans[71:48]), .out(col_sum[5:4]));

    // Column 3 (12 possible to check)
    Checker col3_1(.a(memory[COL_3+9'd1:COL_3+9'd0]), .b(memory[COL_3+9'd33:COL_3+9'd32]), .c(memory[COL_3+9'd65:COL_3+9'd64]),
                   .d(memory[COL_3+9'd97:COL_3+9'd96]), .e(memory[COL_3+9'd129:COL_3+9'd128]), .ans(col_ans[73:72]));
    Checker col3_2(.a(memory[COL_3+9'd161:COL_3+9'd160]), .b(memory[COL_3+9'd33:COL_3+9'd32]), .c(memory[COL_3+9'd65:COL_3+9'd64]),
                   .d(memory[COL_3+9'd97:COL_3+9'd96]), .e(memory[COL_3+9'd129:COL_3+9'd128]), .ans(col_ans[75:74]));
    Checker col3_3(.a(memory[COL_3+9'd161:COL_3+9'd160]), .b(memory[COL_3+9'd193:COL_3+9'd192]), .c(memory[COL_3+9'd65:COL_3+9'd64]),
                   .d(memory[COL_3+9'd97:COL_3+9'd96]), .e(memory[COL_3+9'd129:COL_3+9'd128]), .ans(col_ans[77:76]));
    Checker col3_4(.a(memory[COL_3+9'd161:COL_3+9'd160]), .b(memory[COL_3+9'd193:COL_3+9'd192]), .c(memory[COL_3+9'd225:COL_3+9'd224]),
                   .d(memory[COL_3+9'd97:COL_3+9'd96]), .e(memory[COL_3+9'd129:COL_3+9'd128]), .ans(col_ans[79:78]));
    Checker col3_5(.a(memory[COL_3+9'd161:COL_3+9'd160]), .b(memory[COL_3+9'd193:COL_3+9'd192]), .c(memory[COL_3+9'd225:COL_3+9'd224]),
                   .d(memory[COL_3+9'd257:COL_3+9'd256]), .e(memory[COL_3+9'd129:COL_3+9'd128]), .ans(col_ans[81:80]));
    Checker col3_6(.a(memory[COL_3+9'd161:COL_3+9'd160]), .b(memory[COL_3+9'd193:COL_3+9'd192]), .c(memory[COL_3+9'd225:COL_3+9'd224]),
                   .d(memory[COL_3+9'd257:COL_3+9'd256]), .e(memory[COL_3+9'd289:COL_3+9'd288]), .ans(col_ans[83:82]));
    Checker col3_7(.a(memory[COL_3+9'd321:COL_3+9'd320]), .b(memory[COL_3+9'd193:COL_3+9'd192]), .c(memory[COL_3+9'd225:COL_3+9'd224]),
                   .d(memory[COL_3+9'd257:COL_3+9'd256]), .e(memory[COL_3+9'd289:COL_3+9'd288]), .ans(col_ans[85:84]));
    Checker col3_8(.a(memory[COL_3+9'd321:COL_3+9'd320]), .b(memory[COL_3+9'd353:COL_3+9'd352]), .c(memory[COL_3+9'd225:COL_3+9'd224]),
                   .d(memory[COL_3+9'd257:COL_3+9'd256]), .e(memory[COL_3+9'd289:COL_3+9'd288]), .ans(col_ans[87:86]));
    Checker col3_9(.a(memory[COL_3+9'd321:COL_3+9'd320]), .b(memory[COL_3+9'd353:COL_3+9'd352]), .c(memory[COL_3+9'd385:COL_3+9'd384]),
                   .d(memory[COL_3+9'd257:COL_3+9'd256]), .e(memory[COL_3+9'd289:COL_3+9'd288]), .ans(col_ans[89:88]));
    Checker col3_10(.a(memory[COL_3+9'd321:COL_3+9'd320]), .b(memory[COL_3+9'd353:COL_3+9'd352]), .c(memory[COL_3+9'd385:COL_3+9'd384]),
                   .d(memory[COL_3+9'd417:COL_3+9'd416]), .e(memory[COL_3+9'd289:COL_3+9'd288]), .ans(col_ans[91:90]));
    Checker col3_11(.a(memory[COL_3+9'd321:COL_3+9'd320]), .b(memory[COL_3+9'd353:COL_3+9'd352]), .c(memory[COL_3+9'd385:COL_3+9'd384]),
                   .d(memory[COL_3+9'd417:COL_3+9'd416]), .e(memory[COL_3+9'd449:COL_3+9'd448]), .ans(col_ans[93:92]));
    Checker col3_12(.a(memory[COL_3+9'd481:COL_3+9'd480]), .b(memory[COL_3+9'd353:COL_3+9'd352]), .c(memory[COL_3+9'd385:COL_3+9'd384]),
                   .d(memory[COL_3+9'd417:COL_3+9'd416]), .e(memory[COL_3+9'd449:COL_3+9'd448]), .ans(col_ans[95:94]));
    Summarize12 col3_sum(.check_ans(col_ans[95:72]), .out(col_sum[7:6]));

    // Column 4 (12 possible to check)
    Checker col4_1(.a(memory[COL_4+9'd1:COL_4+9'd0]), .b(memory[COL_4+9'd33:COL_4+9'd32]), .c(memory[COL_4+9'd65:COL_4+9'd64]),
                   .d(memory[COL_4+9'd97:COL_4+9'd96]), .e(memory[COL_4+9'd129:COL_4+9'd128]), .ans(col_ans[97:96]));
    Checker col4_2(.a(memory[COL_4+9'd161:COL_4+9'd160]), .b(memory[COL_4+9'd33:COL_4+9'd32]), .c(memory[COL_4+9'd65:COL_4+9'd64]),
                   .d(memory[COL_4+9'd97:COL_4+9'd96]), .e(memory[COL_4+9'd129:COL_4+9'd128]), .ans(col_ans[99:98]));
    Checker col4_3(.a(memory[COL_4+9'd161:COL_4+9'd160]), .b(memory[COL_4+9'd193:COL_4+9'd192]), .c(memory[COL_4+9'd65:COL_4+9'd64]),
                   .d(memory[COL_4+9'd97:COL_4+9'd96]), .e(memory[COL_4+9'd129:COL_4+9'd128]), .ans(col_ans[101:100]));
    Checker col4_4(.a(memory[COL_4+9'd161:COL_4+9'd160]), .b(memory[COL_4+9'd193:COL_4+9'd192]), .c(memory[COL_4+9'd225:COL_4+9'd224]),
                   .d(memory[COL_4+9'd97:COL_4+9'd96]), .e(memory[COL_4+9'd129:COL_4+9'd128]), .ans(col_ans[103:102]));
    Checker col4_5(.a(memory[COL_4+9'd161:COL_4+9'd160]), .b(memory[COL_4+9'd193:COL_4+9'd192]), .c(memory[COL_4+9'd225:COL_4+9'd224]),
                   .d(memory[COL_4+9'd257:COL_4+9'd256]), .e(memory[COL_4+9'd129:COL_4+9'd128]), .ans(col_ans[105:104]));
    Checker col4_6(.a(memory[COL_4+9'd161:COL_4+9'd160]), .b(memory[COL_4+9'd193:COL_4+9'd192]), .c(memory[COL_4+9'd225:COL_4+9'd224]),
                   .d(memory[COL_4+9'd257:COL_4+9'd256]), .e(memory[COL_4+9'd289:COL_4+9'd288]), .ans(col_ans[107:106]));
    Checker col4_7(.a(memory[COL_4+9'd321:COL_4+9'd320]), .b(memory[COL_4+9'd193:COL_4+9'd192]), .c(memory[COL_4+9'd225:COL_4+9'd224]),
                   .d(memory[COL_4+9'd257:COL_4+9'd256]), .e(memory[COL_4+9'd289:COL_4+9'd288]), .ans(col_ans[109:108]));
    Checker col4_8(.a(memory[COL_4+9'd321:COL_4+9'd320]), .b(memory[COL_4+9'd353:COL_4+9'd352]), .c(memory[COL_4+9'd225:COL_4+9'd224]),
                   .d(memory[COL_4+9'd257:COL_4+9'd256]), .e(memory[COL_4+9'd289:COL_4+9'd288]), .ans(col_ans[111:110]));
    Checker col4_9(.a(memory[COL_4+9'd321:COL_4+9'd320]), .b(memory[COL_4+9'd353:COL_4+9'd352]), .c(memory[COL_4+9'd385:COL_4+9'd384]),
                   .d(memory[COL_4+9'd257:COL_4+9'd256]), .e(memory[COL_4+9'd289:COL_4+9'd288]), .ans(col_ans[113:112]));
    Checker col4_10(.a(memory[COL_4+9'd321:COL_4+9'd320]), .b(memory[COL_4+9'd353:COL_4+9'd352]), .c(memory[COL_4+9'd385:COL_4+9'd384]),
                   .d(memory[COL_4+9'd417:COL_4+9'd416]), .e(memory[COL_4+9'd289:COL_4+9'd288]), .ans(col_ans[115:114]));
    Checker col4_11(.a(memory[COL_4+9'd321:COL_4+9'd320]), .b(memory[COL_4+9'd353:COL_4+9'd352]), .c(memory[COL_4+9'd385:COL_4+9'd384]),
                   .d(memory[COL_4+9'd417:COL_4+9'd416]), .e(memory[COL_4+9'd449:COL_4+9'd448]), .ans(col_ans[117:116]));
    Checker col4_12(.a(memory[COL_4+9'd481:COL_4+9'd480]), .b(memory[COL_4+9'd353:COL_4+9'd352]), .c(memory[COL_4+9'd385:COL_4+9'd384]),
                   .d(memory[COL_4+9'd417:COL_4+9'd416]), .e(memory[COL_4+9'd449:COL_4+9'd448]), .ans(col_ans[119:118]));
    Summarize12 col4_sum(.check_ans(col_ans[119:96]), .out(col_sum[9:8]));

    // Column 5 (12 possible to check)
    Checker col5_1(.a(memory[COL_5+9'd1:COL_5+9'd0]), .b(memory[COL_5+9'd33:COL_5+9'd32]), .c(memory[COL_5+9'd65:COL_5+9'd64]),
                   .d(memory[COL_5+9'd97:COL_5+9'd96]), .e(memory[COL_5+9'd129:COL_5+9'd128]), .ans(col_ans[121:120]));
    Checker col5_2(.a(memory[COL_5+9'd161:COL_5+9'd160]), .b(memory[COL_5+9'd33:COL_5+9'd32]), .c(memory[COL_5+9'd65:COL_5+9'd64]),
                   .d(memory[COL_5+9'd97:COL_5+9'd96]), .e(memory[COL_5+9'd129:COL_5+9'd128]), .ans(col_ans[123:122]));
    Checker col5_3(.a(memory[COL_5+9'd161:COL_5+9'd160]), .b(memory[COL_5+9'd193:COL_5+9'd192]), .c(memory[COL_5+9'd65:COL_5+9'd64]),
                   .d(memory[COL_5+9'd97:COL_5+9'd96]), .e(memory[COL_5+9'd129:COL_5+9'd128]), .ans(col_ans[125:124]));
    Checker col5_4(.a(memory[COL_5+9'd161:COL_5+9'd160]), .b(memory[COL_5+9'd193:COL_5+9'd192]), .c(memory[COL_5+9'd225:COL_5+9'd224]),
                   .d(memory[COL_5+9'd97:COL_5+9'd96]), .e(memory[COL_5+9'd129:COL_5+9'd128]), .ans(col_ans[127:126]));
    Checker col5_5(.a(memory[COL_5+9'd161:COL_5+9'd160]), .b(memory[COL_5+9'd193:COL_5+9'd192]), .c(memory[COL_5+9'd225:COL_5+9'd224]),
                   .d(memory[COL_5+9'd257:COL_5+9'd256]), .e(memory[COL_5+9'd129:COL_5+9'd128]), .ans(col_ans[129:128]));
    Checker col5_6(.a(memory[COL_5+9'd161:COL_5+9'd160]), .b(memory[COL_5+9'd193:COL_5+9'd192]), .c(memory[COL_5+9'd225:COL_5+9'd224]),
                   .d(memory[COL_5+9'd257:COL_5+9'd256]), .e(memory[COL_5+9'd289:COL_5+9'd288]), .ans(col_ans[131:130]));
    Checker col5_7(.a(memory[COL_5+9'd321:COL_5+9'd320]), .b(memory[COL_5+9'd193:COL_5+9'd192]), .c(memory[COL_5+9'd225:COL_5+9'd224]),
                   .d(memory[COL_5+9'd257:COL_5+9'd256]), .e(memory[COL_5+9'd289:COL_5+9'd288]), .ans(col_ans[133:132]));
    Checker col5_8(.a(memory[COL_5+9'd321:COL_5+9'd320]), .b(memory[COL_5+9'd353:COL_5+9'd352]), .c(memory[COL_5+9'd225:COL_5+9'd224]),
                   .d(memory[COL_5+9'd257:COL_5+9'd256]), .e(memory[COL_5+9'd289:COL_5+9'd288]), .ans(col_ans[135:134]));
    Checker col5_9(.a(memory[COL_5+9'd321:COL_5+9'd320]), .b(memory[COL_5+9'd353:COL_5+9'd352]), .c(memory[COL_5+9'd385:COL_5+9'd384]),
                   .d(memory[COL_5+9'd257:COL_5+9'd256]), .e(memory[COL_5+9'd289:COL_5+9'd288]), .ans(col_ans[137:136]));
    Checker col5_10(.a(memory[COL_5+9'd321:COL_5+9'd320]), .b(memory[COL_5+9'd353:COL_5+9'd352]), .c(memory[COL_5+9'd385:COL_5+9'd384]),
                   .d(memory[COL_5+9'd417:COL_5+9'd416]), .e(memory[COL_5+9'd289:COL_5+9'd288]), .ans(col_ans[139:138]));
    Checker col5_11(.a(memory[COL_5+9'd321:COL_5+9'd320]), .b(memory[COL_5+9'd353:COL_5+9'd352]), .c(memory[COL_5+9'd385:COL_5+9'd384]),
                   .d(memory[COL_5+9'd417:COL_5+9'd416]), .e(memory[COL_5+9'd449:COL_5+9'd448]), .ans(col_ans[141:140]));
    Checker col5_12(.a(memory[COL_5+9'd481:COL_5+9'd480]), .b(memory[COL_5+9'd353:COL_5+9'd352]), .c(memory[COL_5+9'd385:COL_5+9'd384]),
                   .d(memory[COL_5+9'd417:COL_5+9'd416]), .e(memory[COL_5+9'd449:COL_5+9'd448]), .ans(col_ans[143:142]));
    Summarize12 col5_sum(.check_ans(col_ans[143:120]), .out(col_sum[11:10]));

    // Column 6 (12 possible to check)
    Checker col6_1(.a(memory[COL_6+9'd1:COL_6+9'd0]), .b(memory[COL_6+9'd33:COL_6+9'd32]), .c(memory[COL_6+9'd65:COL_6+9'd64]),
                   .d(memory[COL_6+9'd97:COL_6+9'd96]), .e(memory[COL_6+9'd129:COL_6+9'd128]), .ans(col_ans[145:144]));
    Checker col6_2(.a(memory[COL_6+9'd161:COL_6+9'd160]), .b(memory[COL_6+9'd33:COL_6+9'd32]), .c(memory[COL_6+9'd65:COL_6+9'd64]),
                   .d(memory[COL_6+9'd97:COL_6+9'd96]), .e(memory[COL_6+9'd129:COL_6+9'd128]), .ans(col_ans[147:146]));
    Checker col6_3(.a(memory[COL_6+9'd161:COL_6+9'd160]), .b(memory[COL_6+9'd193:COL_6+9'd192]), .c(memory[COL_6+9'd65:COL_6+9'd64]),
                   .d(memory[COL_6+9'd97:COL_6+9'd96]), .e(memory[COL_6+9'd129:COL_6+9'd128]), .ans(col_ans[149:148]));
    Checker col6_4(.a(memory[COL_6+9'd161:COL_6+9'd160]), .b(memory[COL_6+9'd193:COL_6+9'd192]), .c(memory[COL_6+9'd225:COL_6+9'd224]),
                   .d(memory[COL_6+9'd97:COL_6+9'd96]), .e(memory[COL_6+9'd129:COL_6+9'd128]), .ans(col_ans[151:150]));
    Checker col6_5(.a(memory[COL_6+9'd161:COL_6+9'd160]), .b(memory[COL_6+9'd193:COL_6+9'd192]), .c(memory[COL_6+9'd225:COL_6+9'd224]),
                   .d(memory[COL_6+9'd257:COL_6+9'd256]), .e(memory[COL_6+9'd129:COL_6+9'd128]), .ans(col_ans[153:152]));
    Checker col6_6(.a(memory[COL_6+9'd161:COL_6+9'd160]), .b(memory[COL_6+9'd193:COL_6+9'd192]), .c(memory[COL_6+9'd225:COL_6+9'd224]),
                   .d(memory[COL_6+9'd257:COL_6+9'd256]), .e(memory[COL_6+9'd289:COL_6+9'd288]), .ans(col_ans[155:154]));
    Checker col6_7(.a(memory[COL_6+9'd321:COL_6+9'd320]), .b(memory[COL_6+9'd193:COL_6+9'd192]), .c(memory[COL_6+9'd225:COL_6+9'd224]),
                   .d(memory[COL_6+9'd257:COL_6+9'd256]), .e(memory[COL_6+9'd289:COL_6+9'd288]), .ans(col_ans[157:156]));
    Checker col6_8(.a(memory[COL_6+9'd321:COL_6+9'd320]), .b(memory[COL_6+9'd353:COL_6+9'd352]), .c(memory[COL_6+9'd225:COL_6+9'd224]),
                   .d(memory[COL_6+9'd257:COL_6+9'd256]), .e(memory[COL_6+9'd289:COL_6+9'd288]), .ans(col_ans[159:158]));
    Checker col6_9(.a(memory[COL_6+9'd321:COL_6+9'd320]), .b(memory[COL_6+9'd353:COL_6+9'd352]), .c(memory[COL_6+9'd385:COL_6+9'd384]),
                   .d(memory[COL_6+9'd257:COL_6+9'd256]), .e(memory[COL_6+9'd289:COL_6+9'd288]), .ans(col_ans[161:160]));
    Checker col6_10(.a(memory[COL_6+9'd321:COL_6+9'd320]), .b(memory[COL_6+9'd353:COL_6+9'd352]), .c(memory[COL_6+9'd385:COL_6+9'd384]),
                   .d(memory[COL_6+9'd417:COL_6+9'd416]), .e(memory[COL_6+9'd289:COL_6+9'd288]), .ans(col_ans[163:162]));
    Checker col6_11(.a(memory[COL_6+9'd321:COL_6+9'd320]), .b(memory[COL_6+9'd353:COL_6+9'd352]), .c(memory[COL_6+9'd385:COL_6+9'd384]),
                   .d(memory[COL_6+9'd417:COL_6+9'd416]), .e(memory[COL_6+9'd449:COL_6+9'd448]), .ans(col_ans[165:164]));
    Checker col6_12(.a(memory[COL_6+9'd481:COL_6+9'd480]), .b(memory[COL_6+9'd353:COL_6+9'd352]), .c(memory[COL_6+9'd385:COL_6+9'd384]),
                   .d(memory[COL_6+9'd417:COL_6+9'd416]), .e(memory[COL_6+9'd449:COL_6+9'd448]), .ans(col_ans[167:166]));
    Summarize12 col6_sum(.check_ans(col_ans[167:144]), .out(col_sum[13:12]));

    // Column 7 (12 possible to check)
    Checker col7_1(.a(memory[COL_7+9'd1:COL_7+9'd0]), .b(memory[COL_7+9'd33:COL_7+9'd32]), .c(memory[COL_7+9'd65:COL_7+9'd64]),
                   .d(memory[COL_7+9'd97:COL_7+9'd96]), .e(memory[COL_7+9'd129:COL_7+9'd128]), .ans(col_ans[169:168]));
    Checker col7_2(.a(memory[COL_7+9'd161:COL_7+9'd160]), .b(memory[COL_7+9'd33:COL_7+9'd32]), .c(memory[COL_7+9'd65:COL_7+9'd64]),
                   .d(memory[COL_7+9'd97:COL_7+9'd96]), .e(memory[COL_7+9'd129:COL_7+9'd128]), .ans(col_ans[171:170]));
    Checker col7_3(.a(memory[COL_7+9'd161:COL_7+9'd160]), .b(memory[COL_7+9'd193:COL_7+9'd192]), .c(memory[COL_7+9'd65:COL_7+9'd64]),
                   .d(memory[COL_7+9'd97:COL_7+9'd96]), .e(memory[COL_7+9'd129:COL_7+9'd128]), .ans(col_ans[173:172]));
    Checker col7_4(.a(memory[COL_7+9'd161:COL_7+9'd160]), .b(memory[COL_7+9'd193:COL_7+9'd192]), .c(memory[COL_7+9'd225:COL_7+9'd224]),
                   .d(memory[COL_7+9'd97:COL_7+9'd96]), .e(memory[COL_7+9'd129:COL_7+9'd128]), .ans(col_ans[175:174]));
    Checker col7_5(.a(memory[COL_7+9'd161:COL_7+9'd160]), .b(memory[COL_7+9'd193:COL_7+9'd192]), .c(memory[COL_7+9'd225:COL_7+9'd224]),
                   .d(memory[COL_7+9'd257:COL_7+9'd256]), .e(memory[COL_7+9'd129:COL_7+9'd128]), .ans(col_ans[177:176]));
    Checker col7_6(.a(memory[COL_7+9'd161:COL_7+9'd160]), .b(memory[COL_7+9'd193:COL_7+9'd192]), .c(memory[COL_7+9'd225:COL_7+9'd224]),
                   .d(memory[COL_7+9'd257:COL_7+9'd256]), .e(memory[COL_7+9'd289:COL_7+9'd288]), .ans(col_ans[179:178]));
    Checker col7_7(.a(memory[COL_7+9'd321:COL_7+9'd320]), .b(memory[COL_7+9'd193:COL_7+9'd192]), .c(memory[COL_7+9'd225:COL_7+9'd224]),
                   .d(memory[COL_7+9'd257:COL_7+9'd256]), .e(memory[COL_7+9'd289:COL_7+9'd288]), .ans(col_ans[181:180]));
    Checker col7_8(.a(memory[COL_7+9'd321:COL_7+9'd320]), .b(memory[COL_7+9'd353:COL_7+9'd352]), .c(memory[COL_7+9'd225:COL_7+9'd224]),
                   .d(memory[COL_7+9'd257:COL_7+9'd256]), .e(memory[COL_7+9'd289:COL_7+9'd288]), .ans(col_ans[183:182]));
    Checker col7_9(.a(memory[COL_7+9'd321:COL_7+9'd320]), .b(memory[COL_7+9'd353:COL_7+9'd352]), .c(memory[COL_7+9'd385:COL_7+9'd384]),
                   .d(memory[COL_7+9'd257:COL_7+9'd256]), .e(memory[COL_7+9'd289:COL_7+9'd288]), .ans(col_ans[185:184]));
    Checker col7_10(.a(memory[COL_7+9'd321:COL_7+9'd320]), .b(memory[COL_7+9'd353:COL_7+9'd352]), .c(memory[COL_7+9'd385:COL_7+9'd384]),
                   .d(memory[COL_7+9'd417:COL_7+9'd416]), .e(memory[COL_7+9'd289:COL_7+9'd288]), .ans(col_ans[187:186]));
    Checker col7_11(.a(memory[COL_7+9'd321:COL_7+9'd320]), .b(memory[COL_7+9'd353:COL_7+9'd352]), .c(memory[COL_7+9'd385:COL_7+9'd384]),
                   .d(memory[COL_7+9'd417:COL_7+9'd416]), .e(memory[COL_7+9'd449:COL_7+9'd448]), .ans(col_ans[189:188]));
    Checker col7_12(.a(memory[COL_7+9'd481:COL_7+9'd480]), .b(memory[COL_7+9'd353:COL_7+9'd352]), .c(memory[COL_7+9'd385:COL_7+9'd384]),
                   .d(memory[COL_7+9'd417:COL_7+9'd416]), .e(memory[COL_7+9'd449:COL_7+9'd448]), .ans(col_ans[191:190]));
    Summarize12 col7_sum(.check_ans(col_ans[191:168]), .out(col_sum[15:14]));

    // Column 8 (12 possible to check)
    Checker col8_1(.a(memory[COL_8+9'd1:COL_8+9'd0]), .b(memory[COL_8+9'd33:COL_8+9'd32]), .c(memory[COL_8+9'd65:COL_8+9'd64]),
                   .d(memory[COL_8+9'd97:COL_8+9'd96]), .e(memory[COL_8+9'd129:COL_8+9'd128]), .ans(col_ans[193:192]));
    Checker col8_2(.a(memory[COL_8+9'd161:COL_8+9'd160]), .b(memory[COL_8+9'd33:COL_8+9'd32]), .c(memory[COL_8+9'd65:COL_8+9'd64]),
                   .d(memory[COL_8+9'd97:COL_8+9'd96]), .e(memory[COL_8+9'd129:COL_8+9'd128]), .ans(col_ans[195:194]));
    Checker col8_3(.a(memory[COL_8+9'd161:COL_8+9'd160]), .b(memory[COL_8+9'd193:COL_8+9'd192]), .c(memory[COL_8+9'd65:COL_8+9'd64]),
                   .d(memory[COL_8+9'd97:COL_8+9'd96]), .e(memory[COL_8+9'd129:COL_8+9'd128]), .ans(col_ans[197:196]));
    Checker col8_4(.a(memory[COL_8+9'd161:COL_8+9'd160]), .b(memory[COL_8+9'd193:COL_8+9'd192]), .c(memory[COL_8+9'd225:COL_8+9'd224]),
                   .d(memory[COL_8+9'd97:COL_8+9'd96]), .e(memory[COL_8+9'd129:COL_8+9'd128]), .ans(col_ans[199:198]));
    Checker col8_5(.a(memory[COL_8+9'd161:COL_8+9'd160]), .b(memory[COL_8+9'd193:COL_8+9'd192]), .c(memory[COL_8+9'd225:COL_8+9'd224]),
                   .d(memory[COL_8+9'd257:COL_8+9'd256]), .e(memory[COL_8+9'd129:COL_8+9'd128]), .ans(col_ans[201:200]));
    Checker col8_6(.a(memory[COL_8+9'd161:COL_8+9'd160]), .b(memory[COL_8+9'd193:COL_8+9'd192]), .c(memory[COL_8+9'd225:COL_8+9'd224]),
                   .d(memory[COL_8+9'd257:COL_8+9'd256]), .e(memory[COL_8+9'd289:COL_8+9'd288]), .ans(col_ans[203:202]));
    Checker col8_7(.a(memory[COL_8+9'd321:COL_8+9'd320]), .b(memory[COL_8+9'd193:COL_8+9'd192]), .c(memory[COL_8+9'd225:COL_8+9'd224]),
                   .d(memory[COL_8+9'd257:COL_8+9'd256]), .e(memory[COL_8+9'd289:COL_8+9'd288]), .ans(col_ans[205:204]));
    Checker col8_8(.a(memory[COL_8+9'd321:COL_8+9'd320]), .b(memory[COL_8+9'd353:COL_8+9'd352]), .c(memory[COL_8+9'd225:COL_8+9'd224]),
                   .d(memory[COL_8+9'd257:COL_8+9'd256]), .e(memory[COL_8+9'd289:COL_8+9'd288]), .ans(col_ans[207:206]));
    Checker col8_9(.a(memory[COL_8+9'd321:COL_8+9'd320]), .b(memory[COL_8+9'd353:COL_8+9'd352]), .c(memory[COL_8+9'd385:COL_8+9'd384]),
                   .d(memory[COL_8+9'd257:COL_8+9'd256]), .e(memory[COL_8+9'd289:COL_8+9'd288]), .ans(col_ans[209:208]));
    Checker col8_10(.a(memory[COL_8+9'd321:COL_8+9'd320]), .b(memory[COL_8+9'd353:COL_8+9'd352]), .c(memory[COL_8+9'd385:COL_8+9'd384]),
                   .d(memory[COL_8+9'd417:COL_8+9'd416]), .e(memory[COL_8+9'd289:COL_8+9'd288]), .ans(col_ans[211:210]));
    Checker col8_11(.a(memory[COL_8+9'd321:COL_8+9'd320]), .b(memory[COL_8+9'd353:COL_8+9'd352]), .c(memory[COL_8+9'd385:COL_8+9'd384]),
                   .d(memory[COL_8+9'd417:COL_8+9'd416]), .e(memory[COL_8+9'd449:COL_8+9'd448]), .ans(col_ans[213:212]));
    Checker col8_12(.a(memory[COL_8+9'd481:COL_8+9'd480]), .b(memory[COL_8+9'd353:COL_8+9'd352]), .c(memory[COL_8+9'd385:COL_8+9'd384]),
                   .d(memory[COL_8+9'd417:COL_8+9'd416]), .e(memory[COL_8+9'd449:COL_8+9'd448]), .ans(col_ans[215:214]));
    Summarize12 col8_sum(.check_ans(col_ans[215:192]), .out(col_sum[17:16]));

    // Column 9 (12 possible to check)
    Checker col9_1(.a(memory[COL_9+9'd1:COL_9+9'd0]), .b(memory[COL_9+9'd33:COL_9+9'd32]), .c(memory[COL_9+9'd65:COL_9+9'd64]),
                   .d(memory[COL_9+9'd97:COL_9+9'd96]), .e(memory[COL_9+9'd129:COL_9+9'd128]), .ans(col_ans[217:216]));
    Checker col9_2(.a(memory[COL_9+9'd161:COL_9+9'd160]), .b(memory[COL_9+9'd33:COL_9+9'd32]), .c(memory[COL_9+9'd65:COL_9+9'd64]),
                   .d(memory[COL_9+9'd97:COL_9+9'd96]), .e(memory[COL_9+9'd129:COL_9+9'd128]), .ans(col_ans[219:218]));
    Checker col9_3(.a(memory[COL_9+9'd161:COL_9+9'd160]), .b(memory[COL_9+9'd193:COL_9+9'd192]), .c(memory[COL_9+9'd65:COL_9+9'd64]),
                   .d(memory[COL_9+9'd97:COL_9+9'd96]), .e(memory[COL_9+9'd129:COL_9+9'd128]), .ans(col_ans[221:220]));
    Checker col9_4(.a(memory[COL_9+9'd161:COL_9+9'd160]), .b(memory[COL_9+9'd193:COL_9+9'd192]), .c(memory[COL_9+9'd225:COL_9+9'd224]),
                   .d(memory[COL_9+9'd97:COL_9+9'd96]), .e(memory[COL_9+9'd129:COL_9+9'd128]), .ans(col_ans[223:222]));
    Checker col9_5(.a(memory[COL_9+9'd161:COL_9+9'd160]), .b(memory[COL_9+9'd193:COL_9+9'd192]), .c(memory[COL_9+9'd225:COL_9+9'd224]),
                   .d(memory[COL_9+9'd257:COL_9+9'd256]), .e(memory[COL_9+9'd129:COL_9+9'd128]), .ans(col_ans[225:224]));
    Checker col9_6(.a(memory[COL_9+9'd161:COL_9+9'd160]), .b(memory[COL_9+9'd193:COL_9+9'd192]), .c(memory[COL_9+9'd225:COL_9+9'd224]),
                   .d(memory[COL_9+9'd257:COL_9+9'd256]), .e(memory[COL_9+9'd289:COL_9+9'd288]), .ans(col_ans[227:226]));
    Checker col9_7(.a(memory[COL_9+9'd321:COL_9+9'd320]), .b(memory[COL_9+9'd193:COL_9+9'd192]), .c(memory[COL_9+9'd225:COL_9+9'd224]),
                   .d(memory[COL_9+9'd257:COL_9+9'd256]), .e(memory[COL_9+9'd289:COL_9+9'd288]), .ans(col_ans[229:228]));
    Checker col9_8(.a(memory[COL_9+9'd321:COL_9+9'd320]), .b(memory[COL_9+9'd353:COL_9+9'd352]), .c(memory[COL_9+9'd225:COL_9+9'd224]),
                   .d(memory[COL_9+9'd257:COL_9+9'd256]), .e(memory[COL_9+9'd289:COL_9+9'd288]), .ans(col_ans[231:230]));
    Checker col9_9(.a(memory[COL_9+9'd321:COL_9+9'd320]), .b(memory[COL_9+9'd353:COL_9+9'd352]), .c(memory[COL_9+9'd385:COL_9+9'd384]),
                   .d(memory[COL_9+9'd257:COL_9+9'd256]), .e(memory[COL_9+9'd289:COL_9+9'd288]), .ans(col_ans[233:232]));
    Checker col9_10(.a(memory[COL_9+9'd321:COL_9+9'd320]), .b(memory[COL_9+9'd353:COL_9+9'd352]), .c(memory[COL_9+9'd385:COL_9+9'd384]),
                   .d(memory[COL_9+9'd417:COL_9+9'd416]), .e(memory[COL_9+9'd289:COL_9+9'd288]), .ans(col_ans[235:234]));
    Checker col9_11(.a(memory[COL_9+9'd321:COL_9+9'd320]), .b(memory[COL_9+9'd353:COL_9+9'd352]), .c(memory[COL_9+9'd385:COL_9+9'd384]),
                   .d(memory[COL_9+9'd417:COL_9+9'd416]), .e(memory[COL_9+9'd449:COL_9+9'd448]), .ans(col_ans[237:236]));
    Checker col9_12(.a(memory[COL_9+9'd481:COL_9+9'd480]), .b(memory[COL_9+9'd353:COL_9+9'd352]), .c(memory[COL_9+9'd385:COL_9+9'd384]),
                   .d(memory[COL_9+9'd417:COL_9+9'd416]), .e(memory[COL_9+9'd449:COL_9+9'd448]), .ans(col_ans[239:238]));
    Summarize12 col9_sum(.check_ans(col_ans[239:216]), .out(col_sum[19:18]));

    // Column 10 (12 possible to check)
    Checker col10_1(.a(memory[COL_10+9'd1:COL_10+9'd0]), .b(memory[COL_10+9'd33:COL_10+9'd32]), .c(memory[COL_10+9'd65:COL_10+9'd64]),
                    .d(memory[COL_10+9'd97:COL_10+9'd96]), .e(memory[COL_10+9'd129:COL_10+9'd128]), .ans(col_ans[241:240]));
    Checker col10_2(.a(memory[COL_10+9'd161:COL_10+9'd160]), .b(memory[COL_10+9'd33:COL_10+9'd32]), .c(memory[COL_10+9'd65:COL_10+9'd64]),
                    .d(memory[COL_10+9'd97:COL_10+9'd96]), .e(memory[COL_10+9'd129:COL_10+9'd128]), .ans(col_ans[243:242]));
    Checker col10_3(.a(memory[COL_10+9'd161:COL_10+9'd160]), .b(memory[COL_10+9'd193:COL_10+9'd192]), .c(memory[COL_10+9'd65:COL_10+9'd64]),
                    .d(memory[COL_10+9'd97:COL_10+9'd96]), .e(memory[COL_10+9'd129:COL_10+9'd128]), .ans(col_ans[245:244]));
    Checker col10_4(.a(memory[COL_10+9'd161:COL_10+9'd160]), .b(memory[COL_10+9'd193:COL_10+9'd192]), .c(memory[COL_10+9'd225:COL_10+9'd224]),
                    .d(memory[COL_10+9'd97:COL_10+9'd96]), .e(memory[COL_10+9'd129:COL_10+9'd128]), .ans(col_ans[247:246]));
    Checker col10_5(.a(memory[COL_10+9'd161:COL_10+9'd160]), .b(memory[COL_10+9'd193:COL_10+9'd192]), .c(memory[COL_10+9'd225:COL_10+9'd224]),
                    .d(memory[COL_10+9'd257:COL_10+9'd256]), .e(memory[COL_10+9'd129:COL_10+9'd128]), .ans(col_ans[249:248]));
    Checker col10_6(.a(memory[COL_10+9'd161:COL_10+9'd160]), .b(memory[COL_10+9'd193:COL_10+9'd192]), .c(memory[COL_10+9'd225:COL_10+9'd224]),
                    .d(memory[COL_10+9'd257:COL_10+9'd256]), .e(memory[COL_10+9'd289:COL_10+9'd288]), .ans(col_ans[251:250]));
    Checker col10_7(.a(memory[COL_10+9'd321:COL_10+9'd320]), .b(memory[COL_10+9'd193:COL_10+9'd192]), .c(memory[COL_10+9'd225:COL_10+9'd224]),
                    .d(memory[COL_10+9'd257:COL_10+9'd256]), .e(memory[COL_10+9'd289:COL_10+9'd288]), .ans(col_ans[253:252]));
    Checker col10_8(.a(memory[COL_10+9'd321:COL_10+9'd320]), .b(memory[COL_10+9'd353:COL_10+9'd352]), .c(memory[COL_10+9'd225:COL_10+9'd224]),
                    .d(memory[COL_10+9'd257:COL_10+9'd256]), .e(memory[COL_10+9'd289:COL_10+9'd288]), .ans(col_ans[255:254]));
    Checker col10_9(.a(memory[COL_10+9'd321:COL_10+9'd320]), .b(memory[COL_10+9'd353:COL_10+9'd352]), .c(memory[COL_10+9'd385:COL_10+9'd384]),
                    .d(memory[COL_10+9'd257:COL_10+9'd256]), .e(memory[COL_10+9'd289:COL_10+9'd288]), .ans(col_ans[257:256]));
    Checker col10_10(.a(memory[COL_10+9'd321:COL_10+9'd320]), .b(memory[COL_10+9'd353:COL_10+9'd352]), .c(memory[COL_10+9'd385:COL_10+9'd384]),
                     .d(memory[COL_10+9'd417:COL_10+9'd416]), .e(memory[COL_10+9'd289:COL_10+9'd288]), .ans(col_ans[259:258]));
    Checker col10_11(.a(memory[COL_10+9'd321:COL_10+9'd320]), .b(memory[COL_10+9'd353:COL_10+9'd352]), .c(memory[COL_10+9'd385:COL_10+9'd384]),
                     .d(memory[COL_10+9'd417:COL_10+9'd416]), .e(memory[COL_10+9'd449:COL_10+9'd448]), .ans(col_ans[261:260]));
    Checker col10_12(.a(memory[COL_10+9'd481:COL_10+9'd480]), .b(memory[COL_10+9'd353:COL_10+9'd352]), .c(memory[COL_10+9'd385:COL_10+9'd384]),
                     .d(memory[COL_10+9'd417:COL_10+9'd416]), .e(memory[COL_10+9'd449:COL_10+9'd448]), .ans(col_ans[263:262]));
    Summarize12 col10_sum(.check_ans(col_ans[263:240]), .out(col_sum[21:20]));

    // Column 11 (12 possible to check)
    Checker col11_1(.a(memory[COL_11+9'd1:COL_11+9'd0]), .b(memory[COL_11+9'd33:COL_11+9'd32]), .c(memory[COL_11+9'd65:COL_11+9'd64]),
                    .d(memory[COL_11+9'd97:COL_11+9'd96]), .e(memory[COL_11+9'd129:COL_11+9'd128]), .ans(col_ans[265:264]));
    Checker col11_2(.a(memory[COL_11+9'd161:COL_11+9'd160]), .b(memory[COL_11+9'd33:COL_11+9'd32]), .c(memory[COL_11+9'd65:COL_11+9'd64]),
                    .d(memory[COL_11+9'd97:COL_11+9'd96]), .e(memory[COL_11+9'd129:COL_11+9'd128]), .ans(col_ans[267:266]));
    Checker col11_3(.a(memory[COL_11+9'd161:COL_11+9'd160]), .b(memory[COL_11+9'd193:COL_11+9'd192]), .c(memory[COL_11+9'd65:COL_11+9'd64]),
                    .d(memory[COL_11+9'd97:COL_11+9'd96]), .e(memory[COL_11+9'd129:COL_11+9'd128]), .ans(col_ans[269:268]));
    Checker col11_4(.a(memory[COL_11+9'd161:COL_11+9'd160]), .b(memory[COL_11+9'd193:COL_11+9'd192]), .c(memory[COL_11+9'd225:COL_11+9'd224]),
                    .d(memory[COL_11+9'd97:COL_11+9'd96]), .e(memory[COL_11+9'd129:COL_11+9'd128]), .ans(col_ans[271:270]));
    Checker col11_5(.a(memory[COL_11+9'd161:COL_11+9'd160]), .b(memory[COL_11+9'd193:COL_11+9'd192]), .c(memory[COL_11+9'd225:COL_11+9'd224]),
                    .d(memory[COL_11+9'd257:COL_11+9'd256]), .e(memory[COL_11+9'd129:COL_11+9'd128]), .ans(col_ans[273:272]));
    Checker col11_6(.a(memory[COL_11+9'd161:COL_11+9'd160]), .b(memory[COL_11+9'd193:COL_11+9'd192]), .c(memory[COL_11+9'd225:COL_11+9'd224]),
                    .d(memory[COL_11+9'd257:COL_11+9'd256]), .e(memory[COL_11+9'd289:COL_11+9'd288]), .ans(col_ans[275:274]));
    Checker col11_7(.a(memory[COL_11+9'd321:COL_11+9'd320]), .b(memory[COL_11+9'd193:COL_11+9'd192]), .c(memory[COL_11+9'd225:COL_11+9'd224]),
                    .d(memory[COL_11+9'd257:COL_11+9'd256]), .e(memory[COL_11+9'd289:COL_11+9'd288]), .ans(col_ans[277:276]));
    Checker col11_8(.a(memory[COL_11+9'd321:COL_11+9'd320]), .b(memory[COL_11+9'd353:COL_11+9'd352]), .c(memory[COL_11+9'd225:COL_11+9'd224]),
                    .d(memory[COL_11+9'd257:COL_11+9'd256]), .e(memory[COL_11+9'd289:COL_11+9'd288]), .ans(col_ans[279:278]));
    Checker col11_9(.a(memory[COL_11+9'd321:COL_11+9'd320]), .b(memory[COL_11+9'd353:COL_11+9'd352]), .c(memory[COL_11+9'd385:COL_11+9'd384]),
                    .d(memory[COL_11+9'd257:COL_11+9'd256]), .e(memory[COL_11+9'd289:COL_11+9'd288]), .ans(col_ans[281:280]));
    Checker col11_10(.a(memory[COL_11+9'd321:COL_11+9'd320]), .b(memory[COL_11+9'd353:COL_11+9'd352]), .c(memory[COL_11+9'd385:COL_11+9'd384]),
                     .d(memory[COL_11+9'd417:COL_11+9'd416]), .e(memory[COL_11+9'd289:COL_11+9'd288]), .ans(col_ans[283:282]));
    Checker col11_11(.a(memory[COL_11+9'd321:COL_11+9'd320]), .b(memory[COL_11+9'd353:COL_11+9'd352]), .c(memory[COL_11+9'd385:COL_11+9'd384]),
                     .d(memory[COL_11+9'd417:COL_11+9'd416]), .e(memory[COL_11+9'd449:COL_11+9'd448]), .ans(col_ans[285:284]));
    Checker col11_12(.a(memory[COL_11+9'd481:COL_11+9'd480]), .b(memory[COL_11+9'd353:COL_11+9'd352]), .c(memory[COL_11+9'd385:COL_11+9'd384]),
                     .d(memory[COL_11+9'd417:COL_11+9'd416]), .e(memory[COL_11+9'd449:COL_11+9'd448]), .ans(col_ans[287:286]));
    Summarize12 col11_sum(.check_ans(col_ans[287:264]), .out(col_sum[23:22]));

    // Column 12 (12 possible to check)
    Checker col12_1(.a(memory[COL_12+9'd1:COL_12+9'd0]), .b(memory[COL_12+9'd33:COL_12+9'd32]), .c(memory[COL_12+9'd65:COL_12+9'd64]),
                    .d(memory[COL_12+9'd97:COL_12+9'd96]), .e(memory[COL_12+9'd129:COL_12+9'd128]), .ans(col_ans[289:288]));
    Checker col12_2(.a(memory[COL_12+9'd161:COL_12+9'd160]), .b(memory[COL_12+9'd33:COL_12+9'd32]), .c(memory[COL_12+9'd65:COL_12+9'd64]),
                    .d(memory[COL_12+9'd97:COL_12+9'd96]), .e(memory[COL_12+9'd129:COL_12+9'd128]), .ans(col_ans[291:290]));
    Checker col12_3(.a(memory[COL_12+9'd161:COL_12+9'd160]), .b(memory[COL_12+9'd193:COL_12+9'd192]), .c(memory[COL_12+9'd65:COL_12+9'd64]),
                    .d(memory[COL_12+9'd97:COL_12+9'd96]), .e(memory[COL_12+9'd129:COL_12+9'd128]), .ans(col_ans[293:292]));
    Checker col12_4(.a(memory[COL_12+9'd161:COL_12+9'd160]), .b(memory[COL_12+9'd193:COL_12+9'd192]), .c(memory[COL_12+9'd225:COL_12+9'd224]),
                    .d(memory[COL_12+9'd97:COL_12+9'd96]), .e(memory[COL_12+9'd129:COL_12+9'd128]), .ans(col_ans[295:294]));
    Checker col12_5(.a(memory[COL_12+9'd161:COL_12+9'd160]), .b(memory[COL_12+9'd193:COL_12+9'd192]), .c(memory[COL_12+9'd225:COL_12+9'd224]),
                    .d(memory[COL_12+9'd257:COL_12+9'd256]), .e(memory[COL_12+9'd129:COL_12+9'd128]), .ans(col_ans[297:296]));
    Checker col12_6(.a(memory[COL_12+9'd161:COL_12+9'd160]), .b(memory[COL_12+9'd193:COL_12+9'd192]), .c(memory[COL_12+9'd225:COL_12+9'd224]),
                    .d(memory[COL_12+9'd257:COL_12+9'd256]), .e(memory[COL_12+9'd289:COL_12+9'd288]), .ans(col_ans[299:298]));
    Checker col12_7(.a(memory[COL_12+9'd321:COL_12+9'd320]), .b(memory[COL_12+9'd193:COL_12+9'd192]), .c(memory[COL_12+9'd225:COL_12+9'd224]),
                    .d(memory[COL_12+9'd257:COL_12+9'd256]), .e(memory[COL_12+9'd289:COL_12+9'd288]), .ans(col_ans[301:300]));
    Checker col12_8(.a(memory[COL_12+9'd321:COL_12+9'd320]), .b(memory[COL_12+9'd353:COL_12+9'd352]), .c(memory[COL_12+9'd225:COL_12+9'd224]),
                    .d(memory[COL_12+9'd257:COL_12+9'd256]), .e(memory[COL_12+9'd289:COL_12+9'd288]), .ans(col_ans[303:302]));
    Checker col12_9(.a(memory[COL_12+9'd321:COL_12+9'd320]), .b(memory[COL_12+9'd353:COL_12+9'd352]), .c(memory[COL_12+9'd385:COL_12+9'd384]),
                    .d(memory[COL_12+9'd257:COL_12+9'd256]), .e(memory[COL_12+9'd289:COL_12+9'd288]), .ans(col_ans[305:304]));
    Checker col12_10(.a(memory[COL_12+9'd321:COL_12+9'd320]), .b(memory[COL_12+9'd353:COL_12+9'd352]), .c(memory[COL_12+9'd385:COL_12+9'd384]),
                     .d(memory[COL_12+9'd417:COL_12+9'd416]), .e(memory[COL_12+9'd289:COL_12+9'd288]), .ans(col_ans[307:306]));
    Checker col12_11(.a(memory[COL_12+9'd321:COL_12+9'd320]), .b(memory[COL_12+9'd353:COL_12+9'd352]), .c(memory[COL_12+9'd385:COL_12+9'd384]),
                     .d(memory[COL_12+9'd417:COL_12+9'd416]), .e(memory[COL_12+9'd449:COL_12+9'd448]), .ans(col_ans[309:308]));
    Checker col12_12(.a(memory[COL_12+9'd481:COL_12+9'd480]), .b(memory[COL_12+9'd353:COL_12+9'd352]), .c(memory[COL_12+9'd385:COL_12+9'd384]),
                     .d(memory[COL_12+9'd417:COL_12+9'd416]), .e(memory[COL_12+9'd449:COL_12+9'd448]), .ans(col_ans[311:310]));
    Summarize12 col12_sum(.check_ans(col_ans[311:288]), .out(col_sum[25:24]));

    // Column 13 (12 possible to check)
    Checker col13_1(.a(memory[COL_13+9'd1:COL_13+9'd0]), .b(memory[COL_13+9'd33:COL_13+9'd32]), .c(memory[COL_13+9'd65:COL_13+9'd64]),
                    .d(memory[COL_13+9'd97:COL_13+9'd96]), .e(memory[COL_13+9'd129:COL_13+9'd128]), .ans(col_ans[313:312]));
    Checker col13_2(.a(memory[COL_13+9'd161:COL_13+9'd160]), .b(memory[COL_13+9'd33:COL_13+9'd32]), .c(memory[COL_13+9'd65:COL_13+9'd64]),
                    .d(memory[COL_13+9'd97:COL_13+9'd96]), .e(memory[COL_13+9'd129:COL_13+9'd128]), .ans(col_ans[315:314]));
    Checker col13_3(.a(memory[COL_13+9'd161:COL_13+9'd160]), .b(memory[COL_13+9'd193:COL_13+9'd192]), .c(memory[COL_13+9'd65:COL_13+9'd64]),
                    .d(memory[COL_13+9'd97:COL_13+9'd96]), .e(memory[COL_13+9'd129:COL_13+9'd128]), .ans(col_ans[317:316]));
    Checker col13_4(.a(memory[COL_13+9'd161:COL_13+9'd160]), .b(memory[COL_13+9'd193:COL_13+9'd192]), .c(memory[COL_13+9'd225:COL_13+9'd224]),
                    .d(memory[COL_13+9'd97:COL_13+9'd96]), .e(memory[COL_13+9'd129:COL_13+9'd128]), .ans(col_ans[319:318]));
    Checker col13_5(.a(memory[COL_13+9'd161:COL_13+9'd160]), .b(memory[COL_13+9'd193:COL_13+9'd192]), .c(memory[COL_13+9'd225:COL_13+9'd224]),
                    .d(memory[COL_13+9'd257:COL_13+9'd256]), .e(memory[COL_13+9'd129:COL_13+9'd128]), .ans(col_ans[321:320]));
    Checker col13_6(.a(memory[COL_13+9'd161:COL_13+9'd160]), .b(memory[COL_13+9'd193:COL_13+9'd192]), .c(memory[COL_13+9'd225:COL_13+9'd224]),
                    .d(memory[COL_13+9'd257:COL_13+9'd256]), .e(memory[COL_13+9'd289:COL_13+9'd288]), .ans(col_ans[323:322]));
    Checker col13_7(.a(memory[COL_13+9'd321:COL_13+9'd320]), .b(memory[COL_13+9'd193:COL_13+9'd192]), .c(memory[COL_13+9'd225:COL_13+9'd224]),
                    .d(memory[COL_13+9'd257:COL_13+9'd256]), .e(memory[COL_13+9'd289:COL_13+9'd288]), .ans(col_ans[325:324]));
    Checker col13_8(.a(memory[COL_13+9'd321:COL_13+9'd320]), .b(memory[COL_13+9'd353:COL_13+9'd352]), .c(memory[COL_13+9'd225:COL_13+9'd224]),
                    .d(memory[COL_13+9'd257:COL_13+9'd256]), .e(memory[COL_13+9'd289:COL_13+9'd288]), .ans(col_ans[327:326]));
    Checker col13_9(.a(memory[COL_13+9'd321:COL_13+9'd320]), .b(memory[COL_13+9'd353:COL_13+9'd352]), .c(memory[COL_13+9'd385:COL_13+9'd384]),
                    .d(memory[COL_13+9'd257:COL_13+9'd256]), .e(memory[COL_13+9'd289:COL_13+9'd288]), .ans(col_ans[329:328]));
    Checker col13_10(.a(memory[COL_13+9'd321:COL_13+9'd320]), .b(memory[COL_13+9'd353:COL_13+9'd352]), .c(memory[COL_13+9'd385:COL_13+9'd384]),
                     .d(memory[COL_13+9'd417:COL_13+9'd416]), .e(memory[COL_13+9'd289:COL_13+9'd288]), .ans(col_ans[331:330]));
    Checker col13_11(.a(memory[COL_13+9'd321:COL_13+9'd320]), .b(memory[COL_13+9'd353:COL_13+9'd352]), .c(memory[COL_13+9'd385:COL_13+9'd384]),
                     .d(memory[COL_13+9'd417:COL_13+9'd416]), .e(memory[COL_13+9'd449:COL_13+9'd448]), .ans(col_ans[333:332]));
    Checker col13_12(.a(memory[COL_13+9'd481:COL_13+9'd480]), .b(memory[COL_13+9'd353:COL_13+9'd352]), .c(memory[COL_13+9'd385:COL_13+9'd384]),
                     .d(memory[COL_13+9'd417:COL_13+9'd416]), .e(memory[COL_13+9'd449:COL_13+9'd448]), .ans(col_ans[335:334]));
    Summarize12 col13_sum(.check_ans(col_ans[335:312]), .out(col_sum[27:26]));

    // Column 14 (12 possible to check)
    Checker col14_1(.a(memory[COL_14+9'd1:COL_14+9'd0]), .b(memory[COL_14+9'd33:COL_14+9'd32]), .c(memory[COL_14+9'd65:COL_14+9'd64]),
                    .d(memory[COL_14+9'd97:COL_14+9'd96]), .e(memory[COL_14+9'd129:COL_14+9'd128]), .ans(col_ans[337:336]));
    Checker col14_2(.a(memory[COL_14+9'd161:COL_14+9'd160]), .b(memory[COL_14+9'd33:COL_14+9'd32]), .c(memory[COL_14+9'd65:COL_14+9'd64]),
                    .d(memory[COL_14+9'd97:COL_14+9'd96]), .e(memory[COL_14+9'd129:COL_14+9'd128]), .ans(col_ans[339:338]));
    Checker col14_3(.a(memory[COL_14+9'd161:COL_14+9'd160]), .b(memory[COL_14+9'd193:COL_14+9'd192]), .c(memory[COL_14+9'd65:COL_14+9'd64]),
                    .d(memory[COL_14+9'd97:COL_14+9'd96]), .e(memory[COL_14+9'd129:COL_14+9'd128]), .ans(col_ans[341:340]));
    Checker col14_4(.a(memory[COL_14+9'd161:COL_14+9'd160]), .b(memory[COL_14+9'd193:COL_14+9'd192]), .c(memory[COL_14+9'd225:COL_14+9'd224]),
                    .d(memory[COL_14+9'd97:COL_14+9'd96]), .e(memory[COL_14+9'd129:COL_14+9'd128]), .ans(col_ans[343:342]));
    Checker col14_5(.a(memory[COL_14+9'd161:COL_14+9'd160]), .b(memory[COL_14+9'd193:COL_14+9'd192]), .c(memory[COL_14+9'd225:COL_14+9'd224]),
                    .d(memory[COL_14+9'd257:COL_14+9'd256]), .e(memory[COL_14+9'd129:COL_14+9'd128]), .ans(col_ans[345:344]));
    Checker col14_6(.a(memory[COL_14+9'd161:COL_14+9'd160]), .b(memory[COL_14+9'd193:COL_14+9'd192]), .c(memory[COL_14+9'd225:COL_14+9'd224]),
                    .d(memory[COL_14+9'd257:COL_14+9'd256]), .e(memory[COL_14+9'd289:COL_14+9'd288]), .ans(col_ans[347:346]));
    Checker col14_7(.a(memory[COL_14+9'd321:COL_14+9'd320]), .b(memory[COL_14+9'd193:COL_14+9'd192]), .c(memory[COL_14+9'd225:COL_14+9'd224]),
                    .d(memory[COL_14+9'd257:COL_14+9'd256]), .e(memory[COL_14+9'd289:COL_14+9'd288]), .ans(col_ans[349:348]));
    Checker col14_8(.a(memory[COL_14+9'd321:COL_14+9'd320]), .b(memory[COL_14+9'd353:COL_14+9'd352]), .c(memory[COL_14+9'd225:COL_14+9'd224]),
                    .d(memory[COL_14+9'd257:COL_14+9'd256]), .e(memory[COL_14+9'd289:COL_14+9'd288]), .ans(col_ans[351:350]));
    Checker col14_9(.a(memory[COL_14+9'd321:COL_14+9'd320]), .b(memory[COL_14+9'd353:COL_14+9'd352]), .c(memory[COL_14+9'd385:COL_14+9'd384]),
                    .d(memory[COL_14+9'd257:COL_14+9'd256]), .e(memory[COL_14+9'd289:COL_14+9'd288]), .ans(col_ans[353:352]));
    Checker col14_10(.a(memory[COL_14+9'd321:COL_14+9'd320]), .b(memory[COL_14+9'd353:COL_14+9'd352]), .c(memory[COL_14+9'd385:COL_14+9'd384]),
                     .d(memory[COL_14+9'd417:COL_14+9'd416]), .e(memory[COL_14+9'd289:COL_14+9'd288]), .ans(col_ans[355:354]));
    Checker col14_11(.a(memory[COL_14+9'd321:COL_14+9'd320]), .b(memory[COL_14+9'd353:COL_14+9'd352]), .c(memory[COL_14+9'd385:COL_14+9'd384]),
                     .d(memory[COL_14+9'd417:COL_14+9'd416]), .e(memory[COL_14+9'd449:COL_14+9'd448]), .ans(col_ans[357:356]));
    Checker col14_12(.a(memory[COL_14+9'd481:COL_14+9'd480]), .b(memory[COL_14+9'd353:COL_14+9'd352]), .c(memory[COL_14+9'd385:COL_14+9'd384]),
                     .d(memory[COL_14+9'd417:COL_14+9'd416]), .e(memory[COL_14+9'd449:COL_14+9'd448]), .ans(col_ans[359:358]));
    Summarize12 col14_sum(.check_ans(col_ans[359:336]), .out(col_sum[29:28]));

    // Column 15 (12 possible to check)
    Checker col15_1(.a(memory[COL_15+9'd1:COL_15+9'd0]), .b(memory[COL_15+9'd33:COL_15+9'd32]), .c(memory[COL_15+9'd65:COL_15+9'd64]),
                    .d(memory[COL_15+9'd97:COL_15+9'd96]), .e(memory[COL_15+9'd129:COL_15+9'd128]), .ans(col_ans[361:360]));
    Checker col15_2(.a(memory[COL_15+9'd161:COL_15+9'd160]), .b(memory[COL_15+9'd33:COL_15+9'd32]), .c(memory[COL_15+9'd65:COL_15+9'd64]),
                    .d(memory[COL_15+9'd97:COL_15+9'd96]), .e(memory[COL_15+9'd129:COL_15+9'd128]), .ans(col_ans[363:362]));
    Checker col15_3(.a(memory[COL_15+9'd161:COL_15+9'd160]), .b(memory[COL_15+9'd193:COL_15+9'd192]), .c(memory[COL_15+9'd65:COL_15+9'd64]),
                    .d(memory[COL_15+9'd97:COL_15+9'd96]), .e(memory[COL_15+9'd129:COL_15+9'd128]), .ans(col_ans[365:364]));
    Checker col15_4(.a(memory[COL_15+9'd161:COL_15+9'd160]), .b(memory[COL_15+9'd193:COL_15+9'd192]), .c(memory[COL_15+9'd225:COL_15+9'd224]),
                    .d(memory[COL_15+9'd97:COL_15+9'd96]), .e(memory[COL_15+9'd129:COL_15+9'd128]), .ans(col_ans[367:366]));
    Checker col15_5(.a(memory[COL_15+9'd161:COL_15+9'd160]), .b(memory[COL_15+9'd193:COL_15+9'd192]), .c(memory[COL_15+9'd225:COL_15+9'd224]),
                    .d(memory[COL_15+9'd257:COL_15+9'd256]), .e(memory[COL_15+9'd129:COL_15+9'd128]), .ans(col_ans[369:368]));
    Checker col15_6(.a(memory[COL_15+9'd161:COL_15+9'd160]), .b(memory[COL_15+9'd193:COL_15+9'd192]), .c(memory[COL_15+9'd225:COL_15+9'd224]),
                    .d(memory[COL_15+9'd257:COL_15+9'd256]), .e(memory[COL_15+9'd289:COL_15+9'd288]), .ans(col_ans[370:370]));
    Checker col15_7(.a(memory[COL_15+9'd321:COL_15+9'd320]), .b(memory[COL_15+9'd193:COL_15+9'd192]), .c(memory[COL_15+9'd225:COL_15+9'd224]),
                    .d(memory[COL_15+9'd257:COL_15+9'd256]), .e(memory[COL_15+9'd289:COL_15+9'd288]), .ans(col_ans[373:372]));
    Checker col15_8(.a(memory[COL_15+9'd321:COL_15+9'd320]), .b(memory[COL_15+9'd353:COL_15+9'd352]), .c(memory[COL_15+9'd225:COL_15+9'd224]),
                    .d(memory[COL_15+9'd257:COL_15+9'd256]), .e(memory[COL_15+9'd289:COL_15+9'd288]), .ans(col_ans[375:374]));
    Checker col15_9(.a(memory[COL_15+9'd321:COL_15+9'd320]), .b(memory[COL_15+9'd353:COL_15+9'd352]), .c(memory[COL_15+9'd385:COL_15+9'd384]),
                    .d(memory[COL_15+9'd257:COL_15+9'd256]), .e(memory[COL_15+9'd289:COL_15+9'd288]), .ans(col_ans[377:376]));
    Checker col15_10(.a(memory[COL_15+9'd321:COL_15+9'd320]), .b(memory[COL_15+9'd353:COL_15+9'd352]), .c(memory[COL_15+9'd385:COL_15+9'd384]),
                     .d(memory[COL_15+9'd417:COL_15+9'd416]), .e(memory[COL_15+9'd289:COL_15+9'd288]), .ans(col_ans[379:378]));
    Checker col15_11(.a(memory[COL_15+9'd321:COL_15+9'd320]), .b(memory[COL_15+9'd353:COL_15+9'd352]), .c(memory[COL_15+9'd385:COL_15+9'd384]),
                     .d(memory[COL_15+9'd417:COL_15+9'd416]), .e(memory[COL_15+9'd449:COL_15+9'd448]), .ans(col_ans[381:380]));
    Checker col15_12(.a(memory[COL_15+9'd481:COL_15+9'd480]), .b(memory[COL_15+9'd353:COL_15+9'd352]), .c(memory[COL_15+9'd385:COL_15+9'd384]),
                     .d(memory[COL_15+9'd417:COL_15+9'd416]), .e(memory[COL_15+9'd449:COL_15+9'd448]), .ans(col_ans[383:382]));
    Summarize12 col15_sum(.check_ans(col_ans[383:360]), .out(col_sum[31:30]));

    //Summarize all rows and all columns further
    wire [3:0] sum_board;
    Summarize16 sum_rows(.check_ans(row_sum[31:0]), .out(sum_board[1:0]));
    Summarize16 sum_cols(.check_ans(col_sum[31:0]), .out(sum_board[3:2]));

    always@(*)
    begin
        // If all checks fail, return 00
        if((sum_board[1:0] == 2'b00) && (sum_board[3:2] == 2'b00)) ans[1:0]=2'b00;
        // If some checks shows 10, return 10
        else if((sum_board[1:0] == 2'b10) || (sum_board[3:2] == 2'b10)) ans[1:0]=2'b10;
        // Else, return 01
        else ans[1:0]=2'b01;
    end


endmodule
