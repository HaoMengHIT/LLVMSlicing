#include <stdio.h>
#include <omp.h>

int main()
{
   int sum = 0;
#pragma omp parallel
   {
#pragma omp for reduction(+:sum)
      for(int i = 0; i < 100;i++)
      {
         sum+=i;
      }
//      printf("Thread %d: Sum = %d\n",omp_get_thread_num(),sum);
   }
   if(sum>=10000)
      printf("Final sum = %d\n",sum);
   else
      printf("Error!\n");
   return 0;
}
