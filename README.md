# LLVMSlicing


To be continued ...

# Author:

1. HaoMengHIT: <haomeng@hit.edu.cn>

   License: GPLv3

# Build


Compile and install ***LLVMSlicing***

```bash
$ cd LLVMSlicing
$ mkdir build;
$ cd build
$ cmake ..
$ make
$ make install
```

## Example

There are some examples in folder **test**, for example, the test.c

1. Change test.c into llvm IR.
   ```
   $ clang -emit-llvm -S test.c -o test.ll
   ```
2. Slicing the test.ll 
   ```
   $ opt -load build/src/libLLVMSlicing.so -IRSlicer test.ll
   ```

## Instrument OpenMP program

1. Change the OpenMP program test.c into llvm IR.

```
$clang -fopenmp -emit-llvm test.c -o test.ll -S
```

2. Change the function WriteProfile into llvm IR.

```
$clang++ -emit-llvm WriteOpenMPProfile.cpp -o WriteOpenMPProfile.bc -S
```

3. Link two IR file.

```
$llvm-link test.ll WriteOpenMPProfile.bc -o test_new.ll -S
```

4. Instrument OpenMP program.

```
$opt -load build/src/libLLVMSlicing.so -insert-openmp-profiling test_new.ll -o test_inst.ll -S
```

5. Compile program.

```
$clang test_inst.ll -o test 
```

6. Run program and generate profile including basic block frequencies.

```
$export OMP_NUM_THREADS=16
$./test
```
