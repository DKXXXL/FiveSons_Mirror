/**
 * This module is the control module which control the transition between states in the FSM for
 * GoBang and the control signals which controls the datapath.
 */
module control(clock, resetn, put, change_turn, change_able_read);
    input clock; // the clock (50MHZ)
    input resetn; // the reset signal for whole game
    input put; // the signal which stands for put a chess
    output reg change_turn; // the signal for change player
    // the signal for get the information about whether is allowed to change the player
    output reg change_able_read; 

    //States
    localparam  INITIAL     = 3'd0, // initial states
                CHOICE      = 3'd1, // states for user given coordinates
                PUT_WAIT    = 3'd2, // states for (wait to) put a chess
                CHECK       = 3'd3, // states for check the game status after put a chess
                CHANGE      = 3'd4; // states to change player


    reg [2:0] current_state, next_state; 

    // State transition
    always@(*)
    begin
        case (current_state)
            //Initial state directly move to CHOICE state
            INITIAL: next_state = CHOICE;
            //When player press put, move to PUT_WAIT state
            CHOICE: next_state = (put == 1'b0) ? PUT_WAIT : CHOICE;
            //When player release put, "put" finish, move to CHECK state
            PUT_WAIT: next_state = (put == 1'b0) ? PUT_WAIT : CHECK;
            //CHECK state directly move to CHANGE state
            CHECK: next_state = CHANGE;
            //CHANGE state directly move to CHOICE state
            CHANGE: next_state = CHOICE;
            default: next_state = INITIAL;
        endcase
    end // state_table

    // Datapath control signals
    always @(*)
    begin
        case (current_state)
            CHOICE: begin
                // In CHOICE state, we want to be able record whether the next put is legal,
                // so that we can determine whether need to change the player
                change_turn = 1'b0;
                change_able_read = 1'b1;
            end
            CHANGE: begin
                // In CHANGE state, we want to be able change player, according to the
                // information got in CHOICE state.
                change_turn = 1'b1;
                change_able_read = 1'b0;
            end
            default: begin
                // Otherwise, we keep two control signals low to maintain their functionality
                change_turn = 1'b0;
                change_able_read = 1'b0;
            end
        endcase
    end


    // current_state registers
    always@(posedge clock, negedge resetn)
    begin
        if(!resetn)
            current_state <= INITIAL;
        else
            current_state <= next_state;
    end // state_FFS

endmodule
