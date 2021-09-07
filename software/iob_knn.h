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
void knn_init(int base_adress, int numb_elements);
unsigned long long sq_dist(struct datum x, struct datum data) ;
void get_dist_sorted(unsigned int* distances);

