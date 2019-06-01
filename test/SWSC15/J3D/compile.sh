#!/bin/bash

clang-6.0 -fopenmp -emit-llvm dummy.c -o dummy.bc -c
clang-6.0 -fopenmp -emit-llvm timing.c -o timing.bc -c
clang-6.0 -fopenmp -emit-llvm j3d_c.c -o j3d_c.bc -c

llvm-link-6.0 dummy.bc timing.bc j3d_c.bc -o j3d_final.bc


