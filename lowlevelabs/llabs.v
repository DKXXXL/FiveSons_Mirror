`define SCR_HEIGHT 12544
`define SCR_WIDTH `SCR_HEIGHT



`define MEM_ADDR_START 0


`define ADDR_SIZE 14


`define COOR_TO_OFFSET(x, y) (x + (y * `SCR_WIDTH))


module screenFlasher(
		     CLK, 
		     // input: The CLOCK
		     in_cont_signal, 
		     // input: The signal to start flashing, continuation
		     read_addr, 
		     // output : the address to read from
		     read_data,
		     // input : the data got from the address
		     out_cont_signal
		     // output: The signal that flashing has stop
		     );
   input CLK;
   input in_cont_signal;


endmodule
   
   
	       
