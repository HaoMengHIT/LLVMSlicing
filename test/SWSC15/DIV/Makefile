#
BHOME	=$(PWD)
#
F90	= ifort
CC	= icc
#
#
COMP	= -openmp
FOMP	= -openmp
COPTS	=  -O3 -xHost -fno-alias -no-vec
FOPTS	=  -O3 -xHost -fno-alias -no-vec
FLONG	= -132
#
#
NOLINK= -c
#

all:	DIV_F.exe DIV_C.exe

DIV_F.exe: div_f.o timing.o
	$(F90) $(FOMP) -o DIV_F.exe $^ $(LINKF)

DIV_C.exe: div_c.o timing.o
	$(CC) $(COMP) -o DIV_C.exe $^ $(LINKF)

%.o:  %.c
	$(CC) $(COPTS) $(COMP) $(NOLINK) $<

%.o:  %.f90
	$(F90) $(FOPTS) $(FOMP) $(NOLINK) $<

clean:
	rm -f *.o *.exe

