
program scan

  double precision :: wctstart,wctend,cpustart,cpuend,ITER_PER_SEC
  integer, parameter :: SLICES = 2000000000

  double precision :: delta_x,x,sum,Pi


  delta_x = 1.d0/SLICES
  
  call timing(wctstart,cpustart)

  sum = 0.d0

  do i=1,SLICES
     x = (i-0.5d0)*delta_x
     sum = sum + (4.d0 / (1.d0 + x * x))
  enddo


  Pi = sum * delta_x

  call timing(wctend,cpuend)
  
  write(*,*) 'Time= ',wctend-wctstart,' sec,  Pi= ',Pi

  end program scan
  
