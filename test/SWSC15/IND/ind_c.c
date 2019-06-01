// Jacobi 3D skeleton program
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "timing.h"

void dummy(double*, double*);

int main(int argc, char** argv) {

  double wct_start,wct_end,cput_start,cput_end,runtime,r;
  int iter,size,i,j,k,n,t0,t1,t;
  int method;
  long int *ind;
  double* a,*b;

  if(argc!=3) {
    printf("Usage: %s <size> <init-method>\n",argv[0]);
    exit(1);
  }

  size = atoi(argv[1]);
  method = atoi(argv[2]);
  a = (double*)malloc((size_t)size*sizeof(double));
  b = (double*)malloc((size_t)size*sizeof(double));
  ind = (long int*)malloc((size_t)size*sizeof(long int));

  /* initialize */
  for(i=0; i<size; ++i) {
    a[i] = b[i] = rand()/(double)RAND_MAX;
    switch(method) {
      case 0:
        ind[i] = 0;
        break;
      case 1:
        ind[i] = i;
        break;
      case 2:
        ind[i] = (rand()/(double)RAND_MAX)*size;
        break;
      default:
        printf("method must be 0, 1, or 2\n");
        exit(1);
    }
  }

  iter=1;
  runtime=0.0;
  while(runtime<0.5) {

  // time measurement
  timing(&wct_start, &cput_start);
  for(n=0; n<iter; n++) {
#pragma omp parallel for
    for(i=0; i<size; ++i) {
      a[i] = a[i] + b[ind[i]];
    }
    if(a[size>>1]<0.) dummy(a,b);
  }	  
  
  timing(&wct_end, &cput_end);
  runtime = wct_end-wct_start;
  iter *= 2;
  }

  iter /= 2;

  printf("size: %d  time: %lf  iter: %d MIt/s: %lf\n",size,runtime,iter,(double)size*iter/runtime/1.e6);
  
  return 0;
}
