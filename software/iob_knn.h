#pragma once

//
//Data structures
//

//labeled dataset
struct datum {
  short x;
  short y;
  unsigned char label;
};

//neighbor info
struct neighbor {
  unsigned int idx; //index in dataset array
  unsigned int dist; //distance to test point
};


//Functions
void knn_init(int base_adress);
unsigned long long sq_dist(struct datum x, struct datum data) ;

