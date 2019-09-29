#llvm-link-6.0 ep.B.bc WriteOpenMPProfile.bc -o ep.b_new.bc -S

opt-6.0 -load ../../../build/lib/libLLVMSlicing.so -insert-openmp-profiling ep.b_new.bc -o ep.b_inst.bc -S

opt-6.0 -load ../../../build/lib/libLLVMSlicing.so -insert-BB-profiling ep.b_new.bc -o ep.b_BB.bc -S

clang-6.0 -fopenmp ep.b_inst.bc -o ep.b_inst -lm

clang-6.0 -fopenmp ep.b_BB.bc -o ep.b_BB -lm
