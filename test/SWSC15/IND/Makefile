#
BHOME	=$(PWD)
#
F90	= ifort
CC	= icc
#
#
COMP	= -fopenmp
FOMP	= -fopenmp
COPTS	=  -O3
FOPTS	=  -O3 
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

