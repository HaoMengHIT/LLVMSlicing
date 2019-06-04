#include "pomp_lib.h"


extern struct ompregdescr omp_rd_4;

int POMP_MAX_ID = 5;

struct ompregdescr* pomp_rd_table[5] = {
  0,
  0,
  0,
  0,
  &omp_rd_4,
};
