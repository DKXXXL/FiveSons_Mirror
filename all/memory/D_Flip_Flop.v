/* This module implements the D-flip-flop. It takes one bit input, a clock signal and an active-low
 * asynchronous reset signal, put out one bit answer.
 */
module D_Flip_Flop(d, clock, write_enable, reset, q);
    input d, clock, reset, write_enable;
    output reg q;

    initial begin
       q = 0;
    end
    // Update the information records in the D-flip-flop at each positive edge of clock and each
    // negative edge of reset
    always@(posedge clock, negedge reset) begin
        // If reset signal is low, set the information
        if (reset == 1'b0)
            q <= 0;
        // Else, update the information according to the given input
        else if (write_enable)
            q <= d;
    end

endmodule
