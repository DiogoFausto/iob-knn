`timescale 1ns/1ps
`include "iob_lib.vh"
`include "KNNsw_reg.vh"

module get_sq_dist
  #(
    parameter DATA_W = 32
    )
   (
    `INPUT(x1, `DATA_W),
    `INPUT(x2, `DATA_W),
    `INPUT(y1, `DATA_W),
    `INPUT(y2, `DATA_W),
    `INPUT(KNN_SAMPLE, `KNN_SAMPLE_W),
    `OUTPUT(DISTANCE, `DISTANCE_HIGH_W + `DISTANCE_LOW_W),
    `INPUT(clk, 1)
    );

   //calculate distance
   `SIGNAL_SIGNED(distX, 2*DATA_W)
   `SIGNAL_SIGNED(distY, 2*DATA_W)
   `SIGNAL_SIGNED(sq_distX, 2*DATA_W)
   `SIGNAL_SIGNED(sq_distY, 2*DATA_W)
   `SIGNAL_SIGNED(sq_dist, 2*DATA_W)
  
   `COMB begin 
      distX = x1 - x2;
      distY = y1 - y2;
      sq_distX = distX*distX;
      sq_distY = distY * distY;
      sq_dist =  sq_distX + sq_distY;
   end

   `SIGNAL(actual_result, 2*DATA_W)

   `REG(clk, actual_result, sq_dist)
   //always @(posedge clk)  actual_result <= sq_dist;

   `SIGNAL2OUT(DISTANCE, actual_result)

      
endmodule

