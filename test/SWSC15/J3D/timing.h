#include <sys/time.h>
#include <sys/types.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/resource.h>

#include <omp.h>


void timing(double* wcTime, double* cpuTime);
void timing_(double* wcTime, double* cpuTime);

