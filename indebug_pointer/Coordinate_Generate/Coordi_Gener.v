module Coordi_Gener(right, down, control_set, resetn, out);
    input right, down;
    input resetn, control_set;
    output [7:0] out;

    X_Coordi_Gener xcoodi(.down(down), .control_set(control_set), .resetn(resetn), .out(out[7:4]));
    Y_Coordi_Gener ycoodi(.right(right), .control_set(control_set), .resetn(resetn), .out(out[3:0]));

endmodule
