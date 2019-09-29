/********************************************************************
 * matrixmult.c
 *
 * Demonstrates the use of openmp to parallelize computing the product
 * of two matrices, A and B of rank NxM and MxN, respectively, so it's
 * product, C, is NxN.
 * 
 * C_{ij} = \Sum_k A_{ik} B_{kj}
 *
 * Copyright Research Computing Center, University of Chicago
 * Author: Douglas Rudd - 4/19/2013
 *******************************************************************/ 
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <papi.h>

#define N 300
#define M 4000

int main( int argc, char *argv[] ) {
   int i, j, k;
   double *A, *B, *C;

   long long counters[3];
   int PAPI_events[] = {
      PAPI_TOT_CYC,
      PAPI_L2_DCM,
      PAPI_L2_DCA };

   PAPI_library_init(PAPI_VER_CURRENT);

   A = (double *)malloc(N*M*sizeof(double));
   B = (double *)malloc(N*M*sizeof(double));
   C = (double *)malloc(N*N*sizeof(double));

   if ( A == NULL || B == NULL || C == NULL ) {
      fprintf(stderr,"Error allocating memory!\n");
      exit(1);
   }

   /* initialize A & B */
   for ( i = 0; i < N; i++ ) {
      for ( j = 0; j < M; j++ ) { 
         A[M*i+j] = 3.0;
         B[N*j+i] = 2.0;
      }
   }

   for ( i = 0; i < N*N; i++ ) {
      C[i] = 0.0;
   }

   i = PAPI_start_counters( PAPI_events, 3 );

   for ( i = 0; i < N; i++ ) {
      for ( j = 0; j < N; j++ ) {
         for ( k = 0; k < M; k++ ) {
            C[N*i+j] += A[M*i+k]*B[N*k+j];
         }
      }
   }

   PAPI_read_counters( counters, 3 );

   printf("%lld L2 cache misses (%.3lf%% misses) in %lld cycles\n", 
         counters[1],
         (double)counters[1] / (double)counters[2],
         counters[0] );

   free(A);
   free(B);
   free(C);

   return 0;
}
