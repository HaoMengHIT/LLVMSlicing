#include <stdio.h>
#include <omp.h>
#include <math.h>

int sum = 0;

void getsum()
{
   for(int i = 0; i < 100;i++)
   {
      sum+=sqrt(i);
   }
   return;

}
int main()
{
   
   printf("Init sum = %d\n",sum);
   getsum();
   if(sum>=10000)
      printf("Final sum = %d\n",sum);
   else
      printf("Error!\n");
   return 0;
}
