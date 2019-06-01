#
BHOME	=$(PWD)
#
F90	= ifort
CC	= icc
#
#
COMP	= -openmp
FOMP	= -openmp
COPTS	=  -O3 -xHost -fno-inline -fno-alias
FOPTS	=  -O3 -xHost -fno-inline
FLONG	= 
#
#
NOLINK= -c
#

IND_C.exe: ind_c.o timing.o dummy.o
	$(CC) $(COMP) -o IND_C.exe ind_c.o timing.o dummy.o

%.o: %.c
	$(CC) $(COPTS) $(COMP) $(NOLINK) $<

%.o: %.f90
	$(F90) $(FOPTS) $(FOMP) $(NOLINK) $<

clean:
	rm -f *.o *.exe

