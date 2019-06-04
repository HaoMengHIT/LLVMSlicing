#!/bin/bash

kinst-ompp-papi icc -fopenmp dummy.c -o dummy.o -c
kinst-ompp-papi icc -fopenmp timing.c -o timing.o -c
kinst-ompp-papi icc -fopenmp j3d_c.c -o j3d_c.o -c

kinst-ompp-papi icc -fopenmp dummy.o timing.o j3d_c.o -o j3d_final_kinst


