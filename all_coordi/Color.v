/**
 * This module is used to switch between player (current chess color).
 */
module Color(enable, resetn, out);
    input enable; //switch triger
    input resetn; //reset
    output [1:0] out; // curren chess color, 1 for player0, 2 for player1.

    reg [1:0] color;
    //always player0 first
    initial begin
        color = 2'b01;
    end

    //Switch player whenever get a triger or reset
    always@(posedge enable, negedge resetn)
    begin
       if(!resetn) color = 2'b01;
       else if (color == 2'b01) color = 2'b10;
       else color = 2'b01;
    end

    assign out = color;

endmodule

