PolyBench/ACC - OpenACC
=======================

##Contacts
* Tristan Vanderbruggen (tristan@udel.edu)
* William Killian (killian@udel.edu)

##Usage

* Set environment variables PATH and LD_LIBRARY_PATH for RoseACC
* Run *make* (it will only build the parallelized benchmarks)

##Status

We are working through the first iteration of parallelizing PolyBench using RoseACC.
This iteration does not include reduction! However, it uses RoseACC's MultiDim extension.
We are not looking for performance yet.

Benchmarks in bold have been parallelized. Benchmarks marked with [*] have reductions.

####datamining
* correlation
* covariance

####linear-algebra/kernels
* **2mm** [*]
* **3mm** [*]
* **atax** [*]
* **bicg** [*]
* cholesky
* doitgen
* gemm
* gemver
* gesummv
* mvt
* symm
* syr2k
* syrk
* trisolv
* trmm

####linear-algebra/solvers
* durbin
* dynprog
* gramschmidt
* lu
* ludcmp

####stencils
* adi
* convolution-2d
* convolution-3d
* fdtd-2d
* jacobi-1d-imper
* jacobi-2d-imper
* seidel-2d

