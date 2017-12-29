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
