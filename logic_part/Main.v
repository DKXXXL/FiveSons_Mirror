module horizontal_check(reset, active, pointer, chess, address, currstate, success, active_next, clk);
module overall_check(reset, active, pointer, chess, success, fail, clk);

module posedge_gen(in, pulse, clk);
    input in;
    input clk;
    output pulse;
    reg pul;
    assign pulse = pul;
    initial begin
        pul = 1'b0;
    end
    always @(in, negedge clk) begin
        if (clk == 1'b0) pul = 1'b0;
        else pul = 1'b1;
    end
endmodule

module Main(KEY, CLOCK_50, SW);
    input KEY[3:0];
    input CLOCK_50;
    input SW[17:0];

    wire write_add[7:0];
    wire read_add[7:0];
    wire inmem[1:0];
    wire outmem[1:0];
    wire mem[511:0];
    wire check_active_pulse;
    wire pointer_reset_pulse;
    wire pointer;
    wire round_end_pulse;
    wire vic;
    wire continue;
    reg checker_active;
    reg pointer_reset;
    reg currplayer[1:0];
    reg currstate[1:0];
    reg FSM[3:0];
    reg nxt_FSM[3:0];
    assign state = currstate;

    localparam WAIT_SELET = 4'd0;
    localparam PLAY = 4'd1;
    localparam WAIT_CHECK = 4'd2;
    localparam END_ROUND = 4'd3;

    initial begin
        currstate = 2'd0;
        currplayer = 2'b01;
        checker_active = 1'b0;
        pointer_reset = 1'b0;
        FSM = WAIT_SELET;
        nxt_FSM = WAIT_SELET;
    end

    posedge_gen gen(currplayer, round_end_pulse, CLOCK_50);
    Memory_Read read(mem, read_add, outmem, CLOCK_50, SW[17]),
    Memory_Write write(inmem, write_add)

    pointer pit(KEY[3], KEY[2], round_end_pulse, pointer);
    overall_check allck(SW[17], KEY[1], pointer, currplayer, vic, continue, CLOCK_50);
    always @(*) begin
        case(FSM) begin
            WAIT_SELET: if (KEY[1] == 1'b1) nxt_FSM = PLAY;
                        else nxt_FSM = WAIT_SELET;
            PLAY: if 


