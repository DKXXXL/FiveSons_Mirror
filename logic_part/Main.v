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

module Main(KEY, CLOCK_50, state);
    input KEY[3:0];
    input CLOCK_50;
    output state[1:0]
    wire pulse;
    wire pointer;
    reg pulse_gen;
    reg active_checker;
    reg currplayer;
    reg currstate[1:0];
    assign state = currstate;

    initial begin
        currstate = 2'd0;
        currplayer = 1'b0;
        active_checker = 1'b0;
        pulse_gen = 1'b0;
    end

    posedge_gen gen(pulse_gen, pulse, CLOCK_50);
    pointer pit(KEY[3], KEY[2], pulse, pointer);
    overall_check allck(pulse, active_checker, pointer, )
    