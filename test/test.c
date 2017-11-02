#include<stdio.h>
#include<math.h>

int sumFunc(int sum,int num)
{
   for(int i = 0;i < num;i++)
   {
      sum+=(sqrt(i)*i);
   }
   return sum;
}
int main()
{
   int sum = 0;
   int num = 100;
   sum = sumFunc(sum,num);
   if(sum > 10000)
       printf("Sum = %d\n",sum);
   else
      printf("Error\n");
   return 0;
}
