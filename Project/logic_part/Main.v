module Fivesons(KEY,
 CLOCK_50, 
 SW, //LEDR,

		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
);
    input [3:0] KEY;
    input CLOCK_50; 
    input [17:0] SW;

    wire [7:0] pointer;
    wire play_pulse, check_activate_pulse, check_reset_pulse;
    wire [511:0] board;
    wire [7:0] add;
    wire [1:0] content_write, board_chess;
    wire round_suc, round_fai;

    reg play, check_activate, check_reset;
    reg [1:0] curr_player;
    reg [7:0] prev_add;
    reg [1:0] game_state;
    reg [3:0] curr_state, nxt_state;
    

	 
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;			//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0
	 

	llabs labs(
	// input : change indicating startworking, can't be stopped
	.Clck(CLOCK_50),
	// input : the clock,
	.board(board),
	// input : the board status
	.gaming_status(gaming_status),
	// input : the status of gaming
	.pointer_loc_x(pointer[3:0]),
	.pointer_loc_y(pointer[7:4]),
	// inputs : the location of pointer, x, y coordinate
	.Reset(
	SW[17]),
	// inputs : the reset
	.VGA_CLK(VGA_CLK), // VGA_CLK;
	.VGA_HS(VGA_HS), // VGA_H_SYNC
	.VGA_VS(VGA_VS), // VGA_V_SYNCpointer_reset
	.VGA_BLANK_N(VGA_BLANK_N), // VGA_BLANK
	.VGA_SYNC_N(VGA_SYNC_N), //VGA SYNC
	.VGA_R(VGA_R), // VGA Red[9:0]
	.VGA_G(VGA_G), // VGA Green[9:0]
	.VGA_B(VGA_B) // VGA Blue[9:0]
);


    pospulse_gen p2(play, play_pulse, CLOCK_50);
    pospulse_gen p3(check_activate, check_activate_pulse, CLOCK_50);
    pospulse_gen p4(check_reset, check_reset_pulse, CLOCK_50);
    
    mux2218 mx1(pointer, prev_add, SW[0], add);
    mux2212 mx2(curr_player, 2'b00, SW[0], content_write);
    
    Memory_Write mem(.in(content_write), .select(add), .out(board), .clock(play_pulse), .reset(SW[17]));
    Memory_Read mr(.in(board), .select(pointer), .out(board_chess));
    
    pointer pt(SW[3], SW[2], 1'b0, pointer);

    overall_check oc(.reset(check_reset_pulse), .active(check_activate_pulse),
        .pointer(pointer), .chess(curr_player), .success(round_suc), .fail(round_fai), .board(board), .clk(CLOCK_50));

    localparam WAIT_SELECT = 4'd0,
            BEGIN_REGRET = 4'd1,
            BEGIN_PLAY = 4'd2,
            PLAY = 4'd3,
            BEGIN_CHECK = 4'd4,
            END_CHECK = 4'd5,
            END_ROUND = 4'd6,
            WIN = 4'd7,
            
            BLACK = 2'b01,
            WHITE = 2'b10;

    initial begin
        check_activate = 1'b0;
        play = 1'b0;
        check_reset = 1'b0;
        curr_player = BLACK;
        prev_add = 8'd0;
        game_state = 2'd0;
        curr_state = WAIT_SELECT;
        nxt_state = WAIT_SELECT;
    end

    
    always @(*) begin
        case(curr_state)
            WAIT_SELECT: begin
                if (SW[1] == 1'b0) nxt_state = BEGIN_PLAY;
                else if (SW[0] == 1'b0) nxt_state = BEGIN_REGRET;
                else nxt_state = WAIT_SELECT;
                end
            
            BEGIN_REGRET: begin
                if (SW[0] == 1'b1) nxt_state = WAIT_SELECT;
                else nxt_state = BEGIN_REGRET;
                end

            BEGIN_PLAY: begin
                if (board_chess != 2'd0) nxt_state = WAIT_SELECT;
                else nxt_state = PLAY;
                end
            
            PLAY: nxt_state = BEGIN_CHECK;
            
            BEGIN_CHECK: begin
                if (check_reset_pulse == 1'b0) nxt_state = END_CHECK;
                else nxt_state = BEGIN_CHECK;
                end            

            END_CHECK: begin
                if (round_suc == 1'b1) nxt_state = WIN;
                else if (round_fai == 1'b1) nxt_state = END_ROUND;
                else nxt_state = END_CHECK;
                end
            
            WIN: nxt_state = WIN;
            
            END_ROUND: nxt_state = WAIT_SELECT;
            
            default: nxt_state = WAIT_SELECT;
        endcase
     end
    
     always @(curr_state) begin
        case(curr_state)
        
            BEGIN_REGRET:begin 
                play = !play;
                curr_player = ~curr_player;
                end
            
            PLAY: begin
                play = !play;
                prev_add = pointer;
                end
            
            BEGIN_CHECK: check_reset = !check_reset;

            END_CHECK: check_activate = !check_activate;

            WIN: game_state = curr_player;
            
            END_ROUND : begin
                check_reset = !check_reset;
                if (curr_player == BLACK) curr_player = WHITE;
                else curr_player = BLACK;
                end
        endcase
    end

    always @(negedge SW[17], posedge CLOCK_50) begin
        if (SW[17] == 1'b0) curr_state = END_ROUND;
        else curr_state = nxt_state;
    end
endmodule
