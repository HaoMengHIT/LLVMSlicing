SHELL=/bin/sh
BENCHMARK=ep
BENCHMARKU=EP
LLVM_VER=6.0

include ../config/make.def

OBJS = ep.o ${COMMON}/c_print_results.o ${COMMON}/c_${RAND}.o \
       ${COMMON}/c_timers.o ${COMMON}/c_wtime.o

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	llvm-link-${LLVM_VER} ${OBJS} -o ${PROGRAM}.bc
	llc-${LLVM_VER} -filetype=obj ${PROGRAM}.bc -o ${PROGRAM}.o
	${CLINK} -fopenmp ${CLINKFLAGS} -o ${PROGRAM} ${PROGRAM}.o ${C_LIB} -lm


ep.o:		ep.c npbparams.h
	${CCOMPILE} ep.c

clean:
	- rm -f *.o *~ 
	- rm -f npbparams.h core



