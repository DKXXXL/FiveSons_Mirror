module DataPath(coordi, resetn, put, turn_control, ledr, ledg, hex0, hex1, clock);
    input [7:0] coordi; //x-y coordinate (row-column) standing for a point player want to put his chess
    input resetn; //reset
    input put; //put signal
    input turn_control; //switch player triger
    input clock; //clock
    output [6:0] hex0, hex1; //HEX0: x coordinate (row), HEX1: y coordinate (column)
    output reg [7:0] ledg, ledr; //LEDR[0]: player0's turn, LEDG[7]: player1's turn; LEDR[7]: player0 win, LEDG[0]: player1 win


    // Display coordinate to HEX
    Hexdisplay row_display(.out(hex1), .in(coordi[7:4]));
    Hexdisplay col_display(.out(hex0), .in(coordi[3:0]));

    // Get current chess color
    wire [1:0] color; 
    Color(.enable(turn_control), .resetn(resetn), .out(color));
    
    // memory and write_enable
    wire [511:0] memory;
    wire [1:0] current_state;
    wire write_enable;
    //according to the coordinate, get the current state of that point
    Memory_Read dataOut(.in(memory[511:0]), .select(coordi[7:0]), .out(current_state[1:0]));
    //according to the current state of that point, generate write_enable signal
    Enable_control able(.current_state(current_state[1:0]), .out(write_enable));
    //given write_enable signal and current chess color, try to put a chess to that point
    Memory_Write dataIn(.in(color[1:0]), .select(coordi[7:0]), .out(memory[511:0]), .clock(put), .reset(resetn), .write_enable(write_enable));

    //Check status of the whole board
    wire [1:0] check_ans;
    All_Check checkBoard(.memory(memory[511:0]), .ans(check_ans[1:0]));
    
    //according to the check answer, choose display pattern signal (1 means someone win, 0 means in process)
    reg dis_choice;
    always@(*)
    begin
        if(check_ans[1:0] != 2'b00) dis_choice = 1'b1;
        else dis_choice = 1'b0;
    end

    //Control light according to the display pattern signal
    always@(*)
    begin
        // If someone win, turn on the cooresponding "win" light 
        if(dis_choice) begin
            if(check_ans[1:0] == 2'b01) begin //player0 win
                ledr[7] = 1'b1;
                ledr[0] = 1'b0;
                ledg[0] = 1'b0;
                ledg[7] = 1'b0;
            end
            else begin  //player1 win
                ledr[7] = 1'b0;
                ledr[0] = 1'b0;
                ledg[0] = 1'b1;
                ledg[7] = 1'b0;
            end
        end
        // Else (in process), turn on the cooresponding "turn" light 
        else begin
            if(color[1:0] == 2'b01) begin //player0' turn
                ledr[7] = 1'b0;
                ledr[0] = 1'b1;
                ledg[0] = 1'b0;
                ledg[7] = 1'b0;
            end
            else begin  //player1's turn
                ledr[7] = 1'b0;
                ledr[0] = 1'b0;
                ledg[0] = 1'b0;
                ledg[7] = 1'b1;
            end
        end
    end

endmodule

