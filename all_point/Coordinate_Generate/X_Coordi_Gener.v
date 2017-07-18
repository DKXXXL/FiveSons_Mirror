module X_Coordi_Gener(down, control_set, resetn, out);
    input down;
    input resetn, control_set;
    output [3:0] out;

    reg [3:0] xco;

    initial begin
        xco = 4'd0;
    end

    always@(posedge down, negedge resetn, posedge control_set)
    begin
        if(!resetn || control_set) xco <= 4'd0;
        else begin
           if(xco == 4'd15) xco <= 4'd0;
           else xco <= xco + 4'b0001;
        end
    end

    assign out[3:0] = xco[3:0];

endmodule
