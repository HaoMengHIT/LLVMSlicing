llvm-link-6.0  j3d_final.bc WriteOpenMPProfile.bc -o j3d_final_new.bc -S

opt-6.0 -load ../../../build/lib/libLLVMSlicing.so -insert-openmp-profiling j3d_final_new.bc -o j3d_final_inst.bc -S

clang-6.0 -fopenmp j3d_final_inst.bc -o j3d_final_inst
