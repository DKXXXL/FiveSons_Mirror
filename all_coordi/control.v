module control(clock, resetn, put, change_turn);
    input clock, resetn, put;
    output reg change_turn;

    localparam  INITIAL     = 3'd0,
                CHOICE      = 3'd1,
                PUT_WAIT    = 3'd2,
                CHECK       = 3'd3,
                CHANGE      = 3'd4;


    reg [2:0] current_state, next_state; 

    // State transition
    always@(*)
    begin: state_table 
        case (current_state)
            //Initial state directly move to CHOICE state
            INITIAL: next_state = CHOICE;
            //When player press put, move to PUT_WAIT state
            CHOICE: next_state = (put == 1'b1) ? PUT_WAIT : CHOICE;
            //When player release put, "put" finish, move to CHECK state
            PUT_WAIT: next_state = (put == 1'b1) ? PUT_WAIT : CHECK;
            //CHECK state directly move to CHANGE state
            CHECK: next_state = CHANGE;
            //CHANGE state directly move to CHOICE state
            CHANGE: next_state = CHOICE;
            default: next_state = INITIAL;
        endcase
    end // state_table

    // Datapath control signals
    always @(*)
    begin: enable_signals
        case (current_state)
            CHANGE: change_turn = 1'b1;
            default: change_turn = 1'b0;
        endcase
    end


    // current_state registers
    always@(posedge clock, negedge resetn)
    begin: state_FFs
        if(!resetn)
            current_state <= INITIAL;
        else
            current_state <= next_state;
    end // state_FFS

endmodule
