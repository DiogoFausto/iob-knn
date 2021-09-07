#include "interconnect.h"
#include "iob_knn.h"
#include "KNNsw_reg.h"

//base address
static int base;
static int mem_address; 
static int numb_elem;

void knn_init(int base_address) {
  base = base_address;
}

unsigned long long sq_dist(struct datum x, struct datum data) {
  unsigned long long distance = 0;
  unsigned int distance_low = 0, distance_high = 0;
  
  //Initialize values

  IO_SET(base, COORD_XX, x.x);
  IO_SET(base, COORD_DATAX, data.x);
  IO_SET(base, COORD_XY, x.y);
  IO_SET(base, COORD_DATAY, data.y);

  //Get the square distance done in verilog
  distance_low = (unsigned long long) IO_GET(base, DISTANCE_LOW);
  distance_high = (unsigned long long) IO_GET(base, DISTANCE_HIGH);
  
  distance = distance_high;
  distance <<= 32;
  distance = distance_low;
  
  return distance;
}

