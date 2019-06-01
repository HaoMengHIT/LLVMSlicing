#
BHOME	=$(PWD)
#
F90	= ifort
CC	= icc
#
#
COMP	= #-openmp
FOMP	= #-openmp
COPTS	=  -O3 -xHOST -fno-alias
FOPTS	=  -O3 -xHOST -fno-alias
FLONG	= 
#
#
NOLINK= -c
#
all: OPT_C.exe OPT_F.exe

OPT_C.exe: opt_c.o timing.o dummy.o
	$(CC) $(COMP) -o $@ $^

OPT_F.exe: opt_f.o timing.o dummy.o
	$(F90) $(FOMP) -o $@ $^

all: OPT_F.exe OPT_C.exe

%.o: %.c
	$(CC) $(COPTS) $(COMP) $(NOLINK) $<

%.o: %.f90
	$(F90) $(FOPTS) $(FOMP) $(NOLINK) $<

clean:
	rm -f *.o *.exe

