#include <stdio.h>
#include <omp.h>
#include <math.h>
#include <stdlib.h>

int sum = 0;

void getsum(int start, int end)
{
   for(int i = start; i < end;i++)
   {
      sum+=sqrt(i);
   }
   return;

}
void readFile(int &start, int &end)
{
   FILE *fp;
   fp = fopen("num.txt","r");
   fscanf(fp,"%d %d",&start, &end);
   printf("start = %d, end = %d\n",start, end);
   fclose(fp);
}
int main()
{
   int start, end;
   readFile(start, end);
   printf("Init sum = %d\n",sum);
   getsum(start, end);
   printf("Final sum = %d\n",sum);
   return 0;
}
