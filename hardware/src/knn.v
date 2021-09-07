`timescale 1ns/1ps
`include "iob_lib.vh"
`include "KNNsw_reg.vh"

module switch
  #(
    parameter DATA_W = 32,
    parameter N_elem = 10
    )
   (
    `INOUT(mem, 2*N_elem*DATA_W),
    `INPUT(position, DATA_W),
    `INPUT(new_value, 2*DATA_W),
    `INPUT(clk, 1)
    );

   `SIGNAL(actual_value, 2*DATA_W)
   `SIGNAL(new_mem, N_elem*2*DATA_W)
   `SIGNAL(old_mem, N_elem*2*DATA_W)

   integer i;

   `COMB old_mem = mem;

   /*initial begin
      for(i=0; i<N_elem-1; i=i+1) begin
	 actual_value <= old_mem[DATA_W-1:0];
			       
	 if(i == position) begin
	    new_mem <= new_value;
	    new_mem <= new_mem << 2*DATA_W;
	    new_mem = actual_value;
	 end	 
	 else if(i < position)
	   new_mem <= actual_value;
	 else
	   new_mem <= actual_value;

	 new_mem <= new_mem << 2*DATA_W;
	 old_mem <= old_mem >> 2*DATA_W;	 
      end
      
      for(i=0; i<N_elem; i=i+1) begin
	 old_mem <= old_mem << 2*DATA_W;
	 actual_value <= new_mem[2*DATA_W-1:0];
	 old_mem[2*DATA_W-1:0*DATA_W] <= actual_value;
	 new_mem <= new_mem >> 2*DATA_W;
      end
      
   end // initial begin
    
    */
   `COMB i=i+1;
   
   `REG(clk,old_mem[2*DATA_W-1:0*DATA_W],i)
   
   `SIGNAL2OUT(mem, old_mem)
   
endmodule
