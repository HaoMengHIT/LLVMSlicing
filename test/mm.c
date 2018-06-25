#include <omp.h> // OpenMP编程需要包含的头文件
#include <time.h>
#include <stdlib.h>


#define MatrixOrder 1024
#define FactorIntToDouble 1.1; //使用rand（）函数产生int型随机数，将其乘以因子转化为double型；

double firstParaMatrix [MatrixOrder] [MatrixOrder] = {0.0};  
double secondParaMatrix [MatrixOrder] [MatrixOrder] = {0.0};
double matrixMultiResult [MatrixOrder] [MatrixOrder] = {0.0};

//计算matrixMultiResult[row][col]
double calcuPartOfMatrixMulti(int row,int col)
{
    double resultValue = 0;
    for(int transNumber = 0 ; transNumber < MatrixOrder ; transNumber++) {
        resultValue += firstParaMatrix [row] [transNumber] * secondParaMatrix [transNumber] [col] ;
    }
    return resultValue;
}

/* * * * * * * * * * * * * * * * * * * * * * * * *
* 使用随机数为乘数矩阵和被乘数矩阵赋double型初值 *
* * * * * * * * * * * * * * * * * * * * * * * * */
void matrixInit()
{
    #pragma omp parallel for num_threads(64)
    for(int row = 0 ; row < MatrixOrder ; row++ ) {
        for(int col = 0 ; col < MatrixOrder ;col++){
            srand(row+col);
            firstParaMatrix [row] [col] = ( rand() % 10 ) * FactorIntToDouble;
            secondParaMatrix [row] [col] = ( rand() % 10 ) * FactorIntToDouble;
        }
    }
    //#pragma omp barrier
}

/* * * * * * * * * * * * * * * * * * * * * * * 
* 实现矩阵相乘 *                    
* * * * * * * * * * * * * * * * * * * * * * * */
void matrixMulti()
{

    #pragma omp parallel for num_threads(64)
    for(int row = 0 ; row < MatrixOrder ; row++){
        for(int col = 0; col < MatrixOrder ; col++){
            matrixMultiResult [row] [col] = calcuPartOfMatrixMulti (row,col);
        }
    }
    //#pragma omp barrier
}

int main()  
{ 
    matrixInit();

    clock_t t1 = clock(); //开始计时；
    matrixMulti();
    clock_t t2 = clock(); //结束计时
    printf("Time: %lld\n",t2-t1); 
    

    return 0;  
}
