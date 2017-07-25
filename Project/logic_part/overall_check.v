module overall_check(reset/*quanju reset*/, active/*xia qi*/, pointer, chess, success, fail, board, clk);
    input reset, active, clk;
    input [1:0] chess;
    input [7:0] pointer;
    input [511:0] board;
    output success, fail;

    //Control signal
    wire [3:0] active_next;
    wire reset_next;
    //Results of each check module
    wire [3:0] success_result, active_next_result;

    control counters_control(.clock(clk), .resetn(reset),
                             //feedback signal for moving to next state
                             .go(active), .active_next(active_next_result[3:0]), .success(success_result[3:0]), 
                             //control signal
                             .set(reset_next), .active(active_next[3:0]), .final_suc(success), .final_fai(fail));

    horizontal_check ck0(.reset(reset_next), .active(active_next[0]), //control signal
                         .pointer(pointer), .chess(chess),
                         .success(success_result[0]), .active_next(active_next_result[0]), //result signal
                         .clk(clk), .board(board));

    verticle_check ck1(.reset(reset_next), .active(active_next[1]), //control signal
                         .pointer(pointer), .chess(chess),
                         .success(success_result[1]), .active_next(active_next_result[1]), //result signal
                         .clk(clk), .board(board));

    lean1_check ck2(.reset(reset_next), .active(active_next[2]), //control signal
                         .pointer(pointer), .chess(chess),
                         .success(success_result[2]), .active_next(active_next_result[2]), //result signal
                         .clk(clk), .board(board));

    lean2_check ck3(.reset(reset_next), .active(active_next[3]), //control signal
                         .pointer(pointer), .chess(chess),
                         .success(success_result[3]), .active_next(active_next_result[3]), //result signal
                         .clk(clk), .board(board));

    
endmodule

module control(clock, resetn, go, active_next, success, set, active, final_suc, final_fai);
    input clock, resetn, go;
    input [3:0] active_next, success;
    output reg set;
    output reg [3:0] active;
    output reg final_suc, final_fai;

    localparam  HORI_CHECK     = 4'd0,
                HORI_WAIT      = 4'd1,
                VERTI_CHECK    = 4'd2,
                VERTI_WAIT     = 4'd3,
                LEAN_ONE_CHECK = 4'd4,
                LEAN_ONE_WAIT  = 4'd5,
                LEAN_TWO_CHECK = 4'd6,
                LEAN_TWO_WAIT  = 4'd7,
                SUCCESS        = 4'd8,
                FAIL           = 4'd9,
                INITIAL        = 4'd10,
                INITIAL_WAIT   = 4'd11;


    reg [3:0] current_state, next_state; 

    initial begin
        set = 1'b1;
        active = 4'd0;
        final_fai = 1'b0;
        final_suc = 1'b0;
        current_state = INITIAL;
        next_state = INITIAL;
    end

    // Always wait to check the current state and enable signals (active_next, success)
    always@(*)
    begin: state_table 
            case (current_state)
                //For Initial state, ready to begin the horizontal check if the go signal is high
                //(a chess has been put)
                INITIAL: if(go) next_state = INITIAL_WAIT;
                         else next_state = INITIAL;

                //For INITIAL_WAIT state, enter the horizontal check state when go become low
                INITIAL_WAIT: if(go) next_state = INITIAL_WAIT;
                              else next_state = HORI_CHECK;

                //For HORI_CHECK state, directly enter the HORI_WAIT state and wait for enable
                //signals (active_next, success)
                HORI_CHECK: next_state = HORI_WAIT;

                //For HORI_WAIT state, if success signal raise, directly enter the SUCCESS state;
                //otherwise, if active_next signal raise, enter the VERTI_CHECK state
                HORI_WAIT:
                begin
                    if(success[0]) next_state = SUCCESS;
                    if(active_next[0]) next_state = VERTI_CHECK;
                end

                //For VERTI_CHECK state, directly enter the VERTI_WAIT state and wait for enable
                //signals (active_next, success)
                VERTI_CHECK: next_state = VERTI_WAIT;

                //For VERTI_WAIT state, if success signal raise, directly enter the SUCCESS state;
                //otherwise, if active_next signal raise, enter the LEAN_ONE_CHECK state
                VERTI_WAIT:
                begin
                    if(success[1]) next_state = SUCCESS;
                    if(active_next[1]) next_state = LEAN_ONE_CHECK;
                end

                //For LEAN_ONE_CHECK state, directly enter the LEAN_ONE_WAIT state and wait for
                //enable signals (active_next, success)
                LEAN_ONE_CHECK: next_state = LEAN_ONE_WAIT;

                //For LEAN_ONE_WAIT state, if success signal raise, directly enter the SUCCESS state;
                //otherwise, if active_next signal raise, enter the LEAN_TWO_CHECK state
                LEAN_ONE_WAIT:
                begin
                    if(success[2]) next_state = SUCCESS;
                    if(active_next[2]) next_state = LEAN_TWO_CHECK;
                end

                //For LEAN_TWO_CHECK state, directly enter the LEAN_TWO_WAIT state and wait for
                //enable signals (active_next, success)
                LEAN_TWO_CHECK: next_state = LEAN_TWO_WAIT;

                //For LEAN_TWO_WAIT state, if success signal raise, directly enter the SUCCESS state;
                //otherwise, if active_next signal raise, enter the FAIL state
                LEAN_TWO_WAIT:
                begin
                    if(success[3]) next_state = SUCCESS;
                    if(active_next[3]) next_state = FAIL;
                end

                SUCCESS: next_state = SUCCESS;

                FAIL: next_state = FAIL;

            //Otherwise, return to INITIAL state
            default:
                next_state = INITIAL;
        endcase
    end // state_table

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        //reset = 1'b0;
        //active = 1'b0;

        case (current_state)
            INITIAL : begin
                set = 1'b1;
                active[3:0] = 4'd0;
                final_suc = 1'b0;
                final_fai = 1'b0;
                end
            INITIAL_WAIT : set = 1'b0;
            HORI_CHECK : begin
                set = 1'b1;
                active[3:0] = 4'b0001;
                end
            HORI_WAIT : begin
                set = 1'b0;
                active[3:0] = 4'b0001;
                end
            VERTI_CHECK: begin
                set = 1'b1;
                active[3:0] = 4'b0010;
                end
            VERTI_WAIT: begin
                set = 1'b0;
                active[3:0] = 4'b0010;
                end
            LEAN_ONE_CHECK: begin
                set = 1'b1;
                active[3:0] = 4'b0100;
                end
            LEAN_ONE_WAIT: begin
                set = 1'b0;
                active[3:0] = 4'b0100;
                end
            LEAN_TWO_CHECK: begin
                set = 1'b1;
                active[3:0] = 4'b1000;
                end
            LEAN_TWO_WAIT: begin
                set = 1'b0;
                active[3:0] = 4'b1000;
                end
            SUCCESS: final_suc = 1'b1;

            FAIL: final_fai = 1'b1;
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clock, posedge resetn)
    begin
        if(resetn)
            current_state <= INITIAL;
        else
            current_state <= next_state;
    end // state_FFS

endmodule
