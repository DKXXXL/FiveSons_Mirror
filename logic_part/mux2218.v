module mux2218(in1, in2, choice, out);
    input[7:0] in1,in2;
    input choice;
    output reg [7:0] out;
    always@(*) begin
      if (choice == 1'b1) out = in1;
      else out = in2;
    end
endmodule
