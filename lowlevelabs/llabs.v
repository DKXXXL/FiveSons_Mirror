
module llabs(


);
	ram1122x3 videoMem(
		.address(address),
		.clock(Clck),
		.data(color),
		.wren(print_enable),
		.q(mem_output)
		);

    


endmodule

module DummyStart(
    in_cont_signal,
	// input : The signal to start 
	out_cont_signal,
	// output: The signal for next continuation to start
	next_out_cont_signal,
	// input : indicating the next continuation is finished, going to the next after the next
    Clck,
);

    always@(posedge Clck)
    begin
      if(in_cont_signal == 1)
        out_cont_signal = 1;
      else
        if(next_out_cont_signal == 1)
            out_cont_signal = 0;
    
    end

endmodule