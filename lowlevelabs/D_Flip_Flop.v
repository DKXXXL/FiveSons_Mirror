/* This module implements the D-flip-flop. It takes one bit input, a clock signal and an active-low
 * asynchronous reset signal, put out one bit answer.
 */
module D_Flip_Flop(d, clock, reset, q);
    input d, clock, reset;
    output q;

    reg data;
    // Update the information records in the D-flip-flop at each positive edge of clock and each
    // negative edge of reset
    always@(posedge clock, negedge reset) begin
        // If reset signal is low, set the information
        if (reset == 1'b0)
            data <= 0;
        // Else, update the information according to the given input
        else if (d == 1'b1)
            data <= 1'b1;
        else 
            data <= 1'b0;
    end

    assign q = data;
endmodule
