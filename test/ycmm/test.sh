clang-6.0 -emit-llvm -fopenmp mm.c -o mm.ll -S
llvm-link-6.0 mm.ll WriteOpenMPProfile.bc -o mm_new.ll -S

opt-6.0 -load ../../build/lib/libLLVMSlicing.so -insert-openmp-profiling mm_new.ll -o mm_inst.ll -S

clang-6.0 -fopenmp mm_inst.ll -o mm_inst
