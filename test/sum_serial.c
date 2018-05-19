#include <stdio.h>
#include <omp.h>
#include <math.h>

int sum[2] = {0,0};

void getsum()
{
   for(int i = 0; i < 100;i++)
   {
      sum[0]+=sqrt(i);
   }
   return;

}
int main()
{
   
   printf("Init sum = %d\n",sum[0]);
   getsum();
   if(sum[0]>=10000)
      printf("Final sum = %d\n",sum[0]);
   else
      printf("Error!\n");
   return 0;
}
