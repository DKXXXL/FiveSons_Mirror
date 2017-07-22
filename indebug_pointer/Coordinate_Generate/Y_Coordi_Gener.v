module Y_Coordi_Gener(right, control_set, resetn, out);
    input right;
    input resetn, control_set;
    output [3:0] out;

    reg [3:0] yco;

    initial begin
        yco = 4'd0;
    end

    always@(posedge right, negedge resetn, posedge control_set)
    begin
        if(!resetn || control_set) yco <= 4'd0;
        else begin
           if(yco == 4'd15) yco <= 4'd0;
           else yco <= yco + 4'b0001;
        end
    end

    assign out[3:0] = yco[3:0];

endmodule
