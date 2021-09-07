`timescale 1ns/1ps
`include "iob_lib.vh"
`include "interconnect.vh"
`include "iob_knn.vh"

module iob_knn 
  #(
    parameter N_elem = 10,
    parameter ADDR_W = `KNN_ADDR_W, //NODOC Address width
    parameter DATA_W = `DATA_W, //NODOC Data word width
    parameter WDATA_W = `KNN_WDATA_W //NODOC Data word width on writes
    )
   (
`include "cpu_nat_s_if.v"
`include "gen_if.v"
    );

//BLOCK Register File & Configuration, control and status registers accessible by the sofware
`include "KNNsw_reg.v"
`include "KNNsw_reg_gen.v"

    //combined hard/soft reset 
   `SIGNAL(rst_int, 1)
   `COMB rst_int = rst | KNN_RESET;

   //write signal
   `SIGNAL(write, 1) 
   `COMB write = | wstrb;

   //
   //BLOCK 64-bit time counter & Free-running 64-bit counter with enable and soft reset capabilities
   //

   `SIGNAL_SIGNED(X1, DATA_W)
   `SIGNAL_SIGNED(X2, DATA_W)
   `SIGNAL_SIGNED(Y1, DATA_W)
   `SIGNAL_SIGNED(Y2, DATA_W)

   assign X1 = COORD_XX;
   assign X2 = COORD_DATAX; 
   assign Y1 = COORD_XY;
   assign Y2 = COORD_DATAY;
   
   `SIGNAL_OUT(DISTANCE, 2*DATA_W)
  
   get_sq_dist sq_dist
     (
      .x1(X1),
      .x2(X2),
      .y1(Y1),
      .y2(Y2),
      .KNN_SAMPLE(KNN_SAMPLE),
      .DISTANCE(DISTANCE),
      .clk(clk)
      );
  
   assign DISTANCE_LOW = DISTANCE[DATA_W-1:0];
   assign DISTANCE_HIGH = DISTANCE[2*DATA_W-1:DATA_W];

  /*
  /*********** SORT DISTANCES ***********

   `SIGNAL(mem, N_elem*2*DATA_W)
   `SIGNAL(final_mem, N_elem*2*DATA_W)
   `SIGNAL(actual_value, 2*DATA_W)
   `SIGNAL(i, DATA_W)
   `SIGNAL(position, DATA_W)
   
   `COMB mem = final_mem;
   
   initial begin
      for(i=0; i<ADDRESS_MEM; i=i+1) begin
	actual_value <= mem[2*DATA_W-1:0];    
	if(DISTANCE < actual_value || actual_value == 0) begin
	   position <= i;
	   i <= ADDRESS_MEM;
	end
	 mem <= mem << 2*DATA_W;
      end 
   end

   switch switch_values
     (
      .mem(final_mem),
      .position(position),
      .new_value(DISTANCE),
      .clk(clk)
      );
   */


   
endmodule

