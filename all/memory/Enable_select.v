module Enable_select(enable, select, out);
    input [3:0] select; // 4-bit select signal
    input enable;
    output [15:0] out;
    reg [15:0] reg_out;

    initial  begin
        reg_out[15:0] = 16'd0;
    end

    always @ (*)
    begin
        case (select[3:0])
            4'd0: reg_out[15:0] <= enable ? 16'b0000_0000_0000_0001 : 16'd0; //the 0th output line
            4'd1: reg_out[15:0] <= enable ? 16'b0000_0000_0000_0010 : 16'd0; //the 1th output line
            4'd2: reg_out[15:0] <= enable ? 16'b0000_0000_0000_0100 : 16'd0; //the 2th output line
            4'd3: reg_out[15:0] <= enable ? 16'b0000_0000_0000_1000 : 16'd0; //the 3th output line
            4'd4: reg_out[15:0] <= enable ? 16'b0000_0000_0001_0000 : 16'd0; //the 4th output line
            4'd5: reg_out[15:0] <= enable ? 16'b0000_0000_0010_0000 : 16'd0; //the 5th output line
            4'd6: reg_out[15:0] <= enable ? 16'b0000_0000_0100_0000 : 16'd0; //the 6th output line
            4'd7: reg_out[15:0] <= enable ? 16'b0000_0000_1000_0000 : 16'd0; //the 7th output line
            4'd8: reg_out[15:0] <= enable ? 16'b0000_0001_0000_0000 : 16'd0; //the 8th output line
            4'd9: reg_out[15:0] <= enable ? 16'b0000_0010_0000_0000 : 16'd0; //the 9th output line
            4'd10: reg_out[15:0] <= enable ? 16'b0000_0100_0000_0000 : 16'd0; //the 10th output line
            4'd11: reg_out[15:0] <= enable ? 16'b0000_1000_0000_0000 : 16'd0; //the 11th output line
            4'd12: reg_out[15:0] <= enable ? 16'b0001_0000_0000_0000 : 16'd0; //the 12th output line
            4'd13: reg_out[15:0] <= enable ? 16'b0010_0000_0000_0000 : 16'd0; //the 13th output line
            4'd14: reg_out[15:0] <= enable ? 16'b0100_0000_0000_0000 : 16'd0; //the 14th output line
            4'd15: reg_out[15:0] <= enable ? 16'b1000_0000_0000_0000 : 16'd0; //the 15th output line
            //no need default since having discussed all possibilities
       endcase
    end
	 
    assign out[15:0] = reg_out[15:0];
    
endmodule
