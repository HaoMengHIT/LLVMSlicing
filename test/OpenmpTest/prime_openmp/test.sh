#!/bin/bash

clang-6.0 -O1 -fopenmp -emit-llvm $1.c -o $1.bc -c -lm
llvm-link-6.0 $1.bc ../../../libprofile/WriteOpenMPProfile.bc -o $1_new.bc 
opt-6.0 -load ../../../build/lib/libLLVMSlicing.so -insert-openmp-profiling $1_new.bc -o $1_inst.bc -S
clang-6.0 -fopenmp $1_inst.bc -o $1_inst -lm
clang-6.0 -fopenmp $1_new.bc -o $1_new -lm
