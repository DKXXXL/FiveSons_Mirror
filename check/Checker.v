/**
 * This module takes in five adjacent points on the board, give out whether there are five adjacent
 * chesses with same color. If yes, give out the color, else give out 0
 */
module Checker(a, b, c, d, e, ans);
    input [1:0] a,b,c,d,e; //Five 2-bit inputs stands for five adjacent points on the board
    output reg [1:0] ans; //2-bit output; 0: no one win; 1: player 1 wins; 2: player 2 wins
    
    always@(*)
    begin
        // If all color 01, set ans to 01
        if((a==2'b01) && (b==2'b01) && (c==2'b01) && (d==2'b01) && (e==2'b01)) ans = 2'b01;
        // Else if all color 10, set ans to 10
        else if ((a==2'b10) && (b==2'b10) && (c==2'b10) && (d==2'b10) && (e==2'b10)) ans = 2'b10;
        // Else set ans to 00
        else ans = 2'b00;
    end

endmodule
