#include<stdio.h>
#include<math.h>

int sumFunc(int num)
{
   int sum = 0;
   for(int i = 0;i < num;i++)
   {
      sum+=(sqrt(i)*i);
   }
   return sum;
}
int main()
{
   int num = 100;
   int sum = sumFunc(num);
   printf("Sum = %d\n",sum);
   return 0;
}
