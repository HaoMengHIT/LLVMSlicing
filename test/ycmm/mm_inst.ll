; ModuleID = 'mm_new.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@firstParaMatrix = global [3000 x [3000 x double]] zeroinitializer, align 16
@secondParaMatrix = global [3000 x [3000 x double]] zeroinitializer, align 16
@matrixMultiResult = global [3000 x [3000 x double]] zeroinitializer, align 16
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"Time: %lf\0A\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"%s.%d.bbfout\00", align 1
@.str.1.2 = private unnamed_addr constant [17 x i8] c"hello world  %s\0A\00", align 1
@.str.2.3 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"open file wrong\0A\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"%ld\09\00", align 1
@BBCounters = internal global [2736 x i64] zeroinitializer

; Function Attrs: noinline nounwind optnone uwtable
define double @calcuPartOfMatrixMulti(i32, i32) #0 {
  %3 = call i32 @sched_getcpu()
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  %7 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store double 0.000000e+00, double* %6, align 8
  store i32 0, i32* %7, align 4
  %IndexSExt = sext i32 %3 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 0
  %8 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %8
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %8
  br label %9

; <label>:9:                                      ; preds = %32, %2
  %10 = load i32, i32* %7, align 4
  %11 = icmp slt i32 %10, 3000
  %IndexSExt1 = sext i32 %3 to i64
  %IndexValMul2 = mul i64 %IndexSExt1, 38
  %IndexValAdd3 = add i64 %IndexValMul2, 1
  %12 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd3
  %OldBBCounter4 = load i64, i64* %12
  %NewBBCounter5 = add i64 %OldBBCounter4, 1
  store i64 %NewBBCounter5, i64* %12
  br i1 %11, label %13, label %36

; <label>:13:                                     ; preds = %9
  %14 = load i32, i32* %4, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [3000 x [3000 x double]], [3000 x [3000 x double]]* @firstParaMatrix, i64 0, i64 %15
  %17 = load i32, i32* %7, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [3000 x double], [3000 x double]* %16, i64 0, i64 %18
  %20 = load double, double* %19, align 8
  %21 = load i32, i32* %7, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [3000 x [3000 x double]], [3000 x [3000 x double]]* @secondParaMatrix, i64 0, i64 %22
  %24 = load i32, i32* %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [3000 x double], [3000 x double]* %23, i64 0, i64 %25
  %27 = load double, double* %26, align 8
  %28 = fmul double %20, %27
  %29 = load double, double* %6, align 8
  %30 = fadd double %29, %28
  store double %30, double* %6, align 8
  %IndexSExt6 = sext i32 %3 to i64
  %IndexValMul7 = mul i64 %IndexSExt6, 38
  %IndexValAdd8 = add i64 %IndexValMul7, 2
  %31 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd8
  %OldBBCounter9 = load i64, i64* %31
  %NewBBCounter10 = add i64 %OldBBCounter9, 1
  store i64 %NewBBCounter10, i64* %31
  br label %32

; <label>:32:                                     ; preds = %13
  %33 = load i32, i32* %7, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, i32* %7, align 4
  %IndexSExt11 = sext i32 %3 to i64
  %IndexValMul12 = mul i64 %IndexSExt11, 38
  %IndexValAdd13 = add i64 %IndexValMul12, 3
  %35 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd13
  %OldBBCounter14 = load i64, i64* %35
  %NewBBCounter15 = add i64 %OldBBCounter14, 1
  store i64 %NewBBCounter15, i64* %35
  br label %9

; <label>:36:                                     ; preds = %9
  %37 = load double, double* %6, align 8
  %IndexSExt16 = sext i32 %3 to i64
  %IndexValMul17 = mul i64 %IndexSExt16, 38
  %IndexValAdd18 = add i64 %IndexValMul17, 4
  %38 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd18
  %OldBBCounter19 = load i64, i64* %38
  %NewBBCounter20 = add i64 %OldBBCounter19, 1
  store i64 %NewBBCounter20, i64* %38
  ret double %37
}

; Function Attrs: noinline nounwind optnone uwtable
define void @matrixInit() #0 {
  %1 = call i32 @sched_getcpu()
  %IndexSExt = sext i32 %1 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 5
  %2 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %2
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*))
  %3 = call i32 @sched_getcpu()
  %IndexSExt1 = sext i32 %3 to i64
  %IndexValMul2 = mul i64 %IndexSExt1, 38
  %IndexValAdd3 = add i64 %IndexValMul2, 6
  %4 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd3
  %OldBBCounter4 = load i64, i64* %4
  %NewBBCounter5 = add i64 %OldBBCounter4, 1
  store i64 %NewBBCounter5, i64* %4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias) #0 {
  %3 = call i32 @sched_getcpu()
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 0, i32* %8, align 4
  store i32 2999, i32* %9, align 4
  store i32 1, i32* %10, align 4
  store i32 0, i32* %11, align 4
  %14 = load i32*, i32** %4, align 8
  %15 = load i32, i32* %14, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @1, i32 %15, i32 34, i32* %11, i32* %8, i32* %9, i32* %10, i32 1, i32 1)
  %16 = load i32, i32* %9, align 4
  %17 = icmp sgt i32 %16, 2999
  %IndexSExt = sext i32 %3 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 7
  %18 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %18
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %18
  br i1 %17, label %19, label %21

; <label>:19:                                     ; preds = %2
  %IndexSExt1 = sext i32 %3 to i64
  %IndexValMul2 = mul i64 %IndexSExt1, 38
  %IndexValAdd3 = add i64 %IndexValMul2, 8
  %20 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd3
  %OldBBCounter4 = load i64, i64* %20
  %NewBBCounter5 = add i64 %OldBBCounter4, 1
  store i64 %NewBBCounter5, i64* %20
  br label %24

; <label>:21:                                     ; preds = %2
  %22 = load i32, i32* %9, align 4
  %IndexSExt6 = sext i32 %3 to i64
  %IndexValMul7 = mul i64 %IndexSExt6, 38
  %IndexValAdd8 = add i64 %IndexValMul7, 9
  %23 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd8
  %OldBBCounter9 = load i64, i64* %23
  %NewBBCounter10 = add i64 %OldBBCounter9, 1
  store i64 %NewBBCounter10, i64* %23
  br label %24

; <label>:24:                                     ; preds = %21, %19
  %25 = phi i32 [ 2999, %19 ], [ %22, %21 ]
  store i32 %25, i32* %9, align 4
  %26 = load i32, i32* %8, align 4
  store i32 %26, i32* %6, align 4
  %IndexSExt11 = sext i32 %3 to i64
  %IndexValMul12 = mul i64 %IndexSExt11, 38
  %IndexValAdd13 = add i64 %IndexValMul12, 10
  %27 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd13
  %OldBBCounter14 = load i64, i64* %27
  %NewBBCounter15 = add i64 %OldBBCounter14, 1
  store i64 %NewBBCounter15, i64* %27
  br label %28

; <label>:28:                                     ; preds = %70, %24
  %29 = load i32, i32* %6, align 4
  %30 = load i32, i32* %9, align 4
  %31 = icmp sle i32 %29, %30
  %IndexSExt16 = sext i32 %3 to i64
  %IndexValMul17 = mul i64 %IndexSExt16, 38
  %IndexValAdd18 = add i64 %IndexValMul17, 11
  %32 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd18
  %OldBBCounter19 = load i64, i64* %32
  %NewBBCounter20 = add i64 %OldBBCounter19, 1
  store i64 %NewBBCounter20, i64* %32
  br i1 %31, label %33, label %74

; <label>:33:                                     ; preds = %28
  %34 = load i32, i32* %6, align 4
  %35 = mul nsw i32 %34, 1
  %36 = add nsw i32 0, %35
  store i32 %36, i32* %12, align 4
  store i32 0, i32* %13, align 4
  %IndexSExt21 = sext i32 %3 to i64
  %IndexValMul22 = mul i64 %IndexSExt21, 38
  %IndexValAdd23 = add i64 %IndexValMul22, 12
  %37 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd23
  %OldBBCounter24 = load i64, i64* %37
  %NewBBCounter25 = add i64 %OldBBCounter24, 1
  store i64 %NewBBCounter25, i64* %37
  br label %38

; <label>:38:                                     ; preds = %62, %33
  %39 = load i32, i32* %13, align 4
  %40 = icmp slt i32 %39, 3000
  %IndexSExt26 = sext i32 %3 to i64
  %IndexValMul27 = mul i64 %IndexSExt26, 38
  %IndexValAdd28 = add i64 %IndexValMul27, 13
  %41 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd28
  %OldBBCounter29 = load i64, i64* %41
  %NewBBCounter30 = add i64 %OldBBCounter29, 1
  store i64 %NewBBCounter30, i64* %41
  br i1 %40, label %42, label %66

; <label>:42:                                     ; preds = %38
  %43 = load i32, i32* %12, align 4
  %44 = load i32, i32* %13, align 4
  %45 = add nsw i32 %43, %44
  %46 = sitofp i32 %45 to double
  %47 = load i32, i32* %12, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [3000 x [3000 x double]], [3000 x [3000 x double]]* @firstParaMatrix, i64 0, i64 %48
  %50 = load i32, i32* %13, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [3000 x double], [3000 x double]* %49, i64 0, i64 %51
  store double %46, double* %52, align 8
  %53 = load i32, i32* %12, align 4
  %54 = sitofp i32 %53 to double
  %55 = load i32, i32* %12, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [3000 x [3000 x double]], [3000 x [3000 x double]]* @secondParaMatrix, i64 0, i64 %56
  %58 = load i32, i32* %13, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [3000 x double], [3000 x double]* %57, i64 0, i64 %59
  store double %54, double* %60, align 8
  %IndexSExt31 = sext i32 %3 to i64
  %IndexValMul32 = mul i64 %IndexSExt31, 38
  %IndexValAdd33 = add i64 %IndexValMul32, 14
  %61 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd33
  %OldBBCounter34 = load i64, i64* %61
  %NewBBCounter35 = add i64 %OldBBCounter34, 1
  store i64 %NewBBCounter35, i64* %61
  br label %62

; <label>:62:                                     ; preds = %42
  %63 = load i32, i32* %13, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, i32* %13, align 4
  %IndexSExt36 = sext i32 %3 to i64
  %IndexValMul37 = mul i64 %IndexSExt36, 38
  %IndexValAdd38 = add i64 %IndexValMul37, 15
  %65 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd38
  %OldBBCounter39 = load i64, i64* %65
  %NewBBCounter40 = add i64 %OldBBCounter39, 1
  store i64 %NewBBCounter40, i64* %65
  br label %38

; <label>:66:                                     ; preds = %38
  %IndexSExt41 = sext i32 %3 to i64
  %IndexValMul42 = mul i64 %IndexSExt41, 38
  %IndexValAdd43 = add i64 %IndexValMul42, 16
  %67 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd43
  %OldBBCounter44 = load i64, i64* %67
  %NewBBCounter45 = add i64 %OldBBCounter44, 1
  store i64 %NewBBCounter45, i64* %67
  br label %68

; <label>:68:                                     ; preds = %66
  %IndexSExt46 = sext i32 %3 to i64
  %IndexValMul47 = mul i64 %IndexSExt46, 38
  %IndexValAdd48 = add i64 %IndexValMul47, 17
  %69 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd48
  %OldBBCounter49 = load i64, i64* %69
  %NewBBCounter50 = add i64 %OldBBCounter49, 1
  store i64 %NewBBCounter50, i64* %69
  br label %70

; <label>:70:                                     ; preds = %68
  %71 = load i32, i32* %6, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %6, align 4
  %IndexSExt51 = sext i32 %3 to i64
  %IndexValMul52 = mul i64 %IndexSExt51, 38
  %IndexValAdd53 = add i64 %IndexValMul52, 18
  %73 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd53
  %OldBBCounter54 = load i64, i64* %73
  %NewBBCounter55 = add i64 %OldBBCounter54, 1
  store i64 %NewBBCounter55, i64* %73
  br label %28

; <label>:74:                                     ; preds = %28
  %IndexSExt56 = sext i32 %3 to i64
  %IndexValMul57 = mul i64 %IndexSExt56, 38
  %IndexValAdd58 = add i64 %IndexValMul57, 19
  %75 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd58
  %OldBBCounter59 = load i64, i64* %75
  %NewBBCounter60 = add i64 %OldBBCounter59, 1
  store i64 %NewBBCounter60, i64* %75
  br label %76

; <label>:76:                                     ; preds = %74
  call void @__kmpc_for_static_fini(%ident_t* @1, i32 %15)
  %IndexSExt61 = sext i32 %3 to i64
  %IndexValMul62 = mul i64 %IndexSExt61, 38
  %IndexValAdd63 = add i64 %IndexValMul62, 20
  %77 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd63
  %OldBBCounter64 = load i64, i64* %77
  %NewBBCounter65 = add i64 %OldBBCounter64, 1
  store i64 %NewBBCounter65, i64* %77
  ret void
}

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

declare void @__kmpc_for_static_fini(%ident_t*, i32)

; Function Attrs: noinline nounwind optnone uwtable
define void @matrixMulti() #0 {
  %1 = call i32 @sched_getcpu()
  %IndexSExt = sext i32 %1 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 21
  %2 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %2
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined..1 to void (i32*, i32*, ...)*))
  %3 = call i32 @sched_getcpu()
  %IndexSExt1 = sext i32 %3 to i64
  %IndexValMul2 = mul i64 %IndexSExt1, 38
  %IndexValAdd3 = add i64 %IndexValMul2, 22
  %4 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd3
  %OldBBCounter4 = load i64, i64* %4
  %NewBBCounter5 = add i64 %OldBBCounter4, 1
  store i64 %NewBBCounter5, i64* %4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @.omp_outlined..1(i32* noalias, i32* noalias) #0 {
  %3 = call i32 @sched_getcpu()
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 0, i32* %8, align 4
  store i32 2999, i32* %9, align 4
  store i32 1, i32* %10, align 4
  store i32 0, i32* %11, align 4
  %14 = load i32*, i32** %4, align 8
  %15 = load i32, i32* %14, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @1, i32 %15, i32 34, i32* %11, i32* %8, i32* %9, i32* %10, i32 1, i32 1)
  %16 = load i32, i32* %9, align 4
  %17 = icmp sgt i32 %16, 2999
  %IndexSExt = sext i32 %3 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 23
  %18 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %18
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %18
  br i1 %17, label %19, label %21

; <label>:19:                                     ; preds = %2
  %IndexSExt1 = sext i32 %3 to i64
  %IndexValMul2 = mul i64 %IndexSExt1, 38
  %IndexValAdd3 = add i64 %IndexValMul2, 24
  %20 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd3
  %OldBBCounter4 = load i64, i64* %20
  %NewBBCounter5 = add i64 %OldBBCounter4, 1
  store i64 %NewBBCounter5, i64* %20
  br label %24

; <label>:21:                                     ; preds = %2
  %22 = load i32, i32* %9, align 4
  %IndexSExt6 = sext i32 %3 to i64
  %IndexValMul7 = mul i64 %IndexSExt6, 38
  %IndexValAdd8 = add i64 %IndexValMul7, 25
  %23 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd8
  %OldBBCounter9 = load i64, i64* %23
  %NewBBCounter10 = add i64 %OldBBCounter9, 1
  store i64 %NewBBCounter10, i64* %23
  br label %24

; <label>:24:                                     ; preds = %21, %19
  %25 = phi i32 [ 2999, %19 ], [ %22, %21 ]
  store i32 %25, i32* %9, align 4
  %26 = load i32, i32* %8, align 4
  store i32 %26, i32* %6, align 4
  %IndexSExt11 = sext i32 %3 to i64
  %IndexValMul12 = mul i64 %IndexSExt11, 38
  %IndexValAdd13 = add i64 %IndexValMul12, 26
  %27 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd13
  %OldBBCounter14 = load i64, i64* %27
  %NewBBCounter15 = add i64 %OldBBCounter14, 1
  store i64 %NewBBCounter15, i64* %27
  br label %28

; <label>:28:                                     ; preds = %61, %24
  %29 = load i32, i32* %6, align 4
  %30 = load i32, i32* %9, align 4
  %31 = icmp sle i32 %29, %30
  %IndexSExt16 = sext i32 %3 to i64
  %IndexValMul17 = mul i64 %IndexSExt16, 38
  %IndexValAdd18 = add i64 %IndexValMul17, 27
  %32 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd18
  %OldBBCounter19 = load i64, i64* %32
  %NewBBCounter20 = add i64 %OldBBCounter19, 1
  store i64 %NewBBCounter20, i64* %32
  br i1 %31, label %33, label %65

; <label>:33:                                     ; preds = %28
  %34 = load i32, i32* %6, align 4
  %35 = mul nsw i32 %34, 1
  %36 = add nsw i32 0, %35
  store i32 %36, i32* %12, align 4
  store i32 0, i32* %13, align 4
  %IndexSExt21 = sext i32 %3 to i64
  %IndexValMul22 = mul i64 %IndexSExt21, 38
  %IndexValAdd23 = add i64 %IndexValMul22, 28
  %37 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd23
  %OldBBCounter24 = load i64, i64* %37
  %NewBBCounter25 = add i64 %OldBBCounter24, 1
  store i64 %NewBBCounter25, i64* %37
  br label %38

; <label>:38:                                     ; preds = %53, %33
  %39 = load i32, i32* %13, align 4
  %40 = icmp slt i32 %39, 3000
  %IndexSExt26 = sext i32 %3 to i64
  %IndexValMul27 = mul i64 %IndexSExt26, 38
  %IndexValAdd28 = add i64 %IndexValMul27, 29
  %41 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd28
  %OldBBCounter29 = load i64, i64* %41
  %NewBBCounter30 = add i64 %OldBBCounter29, 1
  store i64 %NewBBCounter30, i64* %41
  br i1 %40, label %42, label %57

; <label>:42:                                     ; preds = %38
  %43 = load i32, i32* %12, align 4
  %44 = load i32, i32* %13, align 4
  %45 = call double @calcuPartOfMatrixMulti(i32 %43, i32 %44)
  %46 = load i32, i32* %12, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [3000 x [3000 x double]], [3000 x [3000 x double]]* @matrixMultiResult, i64 0, i64 %47
  %49 = load i32, i32* %13, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [3000 x double], [3000 x double]* %48, i64 0, i64 %50
  store double %45, double* %51, align 8
  %IndexSExt31 = sext i32 %3 to i64
  %IndexValMul32 = mul i64 %IndexSExt31, 38
  %IndexValAdd33 = add i64 %IndexValMul32, 30
  %52 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd33
  %OldBBCounter34 = load i64, i64* %52
  %NewBBCounter35 = add i64 %OldBBCounter34, 1
  store i64 %NewBBCounter35, i64* %52
  br label %53

; <label>:53:                                     ; preds = %42
  %54 = load i32, i32* %13, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* %13, align 4
  %IndexSExt36 = sext i32 %3 to i64
  %IndexValMul37 = mul i64 %IndexSExt36, 38
  %IndexValAdd38 = add i64 %IndexValMul37, 31
  %56 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd38
  %OldBBCounter39 = load i64, i64* %56
  %NewBBCounter40 = add i64 %OldBBCounter39, 1
  store i64 %NewBBCounter40, i64* %56
  br label %38

; <label>:57:                                     ; preds = %38
  %IndexSExt41 = sext i32 %3 to i64
  %IndexValMul42 = mul i64 %IndexSExt41, 38
  %IndexValAdd43 = add i64 %IndexValMul42, 32
  %58 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd43
  %OldBBCounter44 = load i64, i64* %58
  %NewBBCounter45 = add i64 %OldBBCounter44, 1
  store i64 %NewBBCounter45, i64* %58
  br label %59

; <label>:59:                                     ; preds = %57
  %IndexSExt46 = sext i32 %3 to i64
  %IndexValMul47 = mul i64 %IndexSExt46, 38
  %IndexValAdd48 = add i64 %IndexValMul47, 33
  %60 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd48
  %OldBBCounter49 = load i64, i64* %60
  %NewBBCounter50 = add i64 %OldBBCounter49, 1
  store i64 %NewBBCounter50, i64* %60
  br label %61

; <label>:61:                                     ; preds = %59
  %62 = load i32, i32* %6, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, i32* %6, align 4
  %IndexSExt51 = sext i32 %3 to i64
  %IndexValMul52 = mul i64 %IndexSExt51, 38
  %IndexValAdd53 = add i64 %IndexValMul52, 34
  %64 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd53
  %OldBBCounter54 = load i64, i64* %64
  %NewBBCounter55 = add i64 %OldBBCounter54, 1
  store i64 %NewBBCounter55, i64* %64
  br label %28

; <label>:65:                                     ; preds = %28
  %IndexSExt56 = sext i32 %3 to i64
  %IndexValMul57 = mul i64 %IndexSExt56, 38
  %IndexValAdd58 = add i64 %IndexValMul57, 35
  %66 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd58
  %OldBBCounter59 = load i64, i64* %66
  %NewBBCounter60 = add i64 %OldBBCounter59, 1
  store i64 %NewBBCounter60, i64* %66
  br label %67

; <label>:67:                                     ; preds = %65
  call void @__kmpc_for_static_fini(%ident_t* @1, i32 %15)
  %IndexSExt61 = sext i32 %3 to i64
  %IndexValMul62 = mul i64 %IndexSExt61, 38
  %IndexValAdd63 = add i64 %IndexValMul62, 36
  %68 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd63
  %OldBBCounter64 = load i64, i64* %68
  %NewBBCounter65 = add i64 %OldBBCounter64, 1
  store i64 %NewBBCounter65, i64* %68
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = call i32 @sched_getcpu()
  %2 = alloca i32, align 4
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store i32 0, i32* %2, align 4
  %5 = call double @omp_get_wtime()
  store double %5, double* %3, align 8
  call void @matrixInit()
  call void @matrixMulti()
  %6 = call double @omp_get_wtime()
  store double %6, double* %4, align 8
  %7 = load double, double* %4, align 8
  %8 = load double, double* %3, align 8
  %9 = fsub double %7, %8
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0), double %9)
  %IndexSExt = sext i32 %1 to i64
  %IndexValMul = mul i64 %IndexSExt, 38
  %IndexValAdd = add i64 %IndexValMul, 37
  %11 = getelementptr [2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 %IndexValAdd
  %OldBBCounter = load i64, i64* %11
  %NewBBCounter = add i64 %OldBBCounter, 1
  store i64 %NewBBCounter, i64* %11
  call void @_Z18WriteOpenMPProfilePll(i64* getelementptr inbounds ([2736 x i64], [2736 x i64]* @BBCounters, i64 0, i64 0), i64 2736)
  ret i32 0
}

declare double @omp_get_wtime() #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: uwtable
define void @_Z18WriteOpenMPProfilePll(i64* %BBCounters, i64 %array_size) #2 {
  %1 = alloca i64*, align 8
  %2 = alloca i64, align 8
  %outstring = alloca [150 x i8], align 16
  %hostname = alloca [100 x i8], align 16
  %pid = alloca i32, align 4
  %fp = alloca %struct._IO_FILE*, align 8
  %i = alloca i32, align 4
  store i64* %BBCounters, i64** %1, align 8
  store i64 %array_size, i64* %2, align 8
  %3 = call i32 @getpid() #5
  store i32 %3, i32* %pid, align 4
  %4 = getelementptr inbounds [100 x i8], [100 x i8]* %hostname, i32 0, i32 0
  %5 = call i32 @gethostname(i8* %4, i64 99) #5
  %6 = getelementptr inbounds [150 x i8], [150 x i8]* %outstring, i32 0, i32 0
  %7 = getelementptr inbounds [100 x i8], [100 x i8]* %hostname, i32 0, i32 0
  %8 = load i32, i32* %pid, align 4
  %9 = call i32 (i8*, i8*, ...) @sprintf(i8* %6, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i8* %7, i32 %8) #5
  %10 = getelementptr inbounds [150 x i8], [150 x i8]* %outstring, i32 0, i32 0
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1.2, i32 0, i32 0), i8* %10)
  %12 = getelementptr inbounds [150 x i8], [150 x i8]* %outstring, i32 0, i32 0
  %13 = call %struct._IO_FILE* @fopen(i8* %12, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2.3, i32 0, i32 0))
  store %struct._IO_FILE* %13, %struct._IO_FILE** %fp, align 8
  %14 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %15 = icmp eq %struct._IO_FILE* %14, null
  br i1 %15, label %16, label %18

; <label>:16:                                     ; preds = %0
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i32 0, i32 0))
  br label %38

; <label>:18:                                     ; preds = %0
  store i32 0, i32* %i, align 4
  br label %19

; <label>:19:                                     ; preds = %32, %18
  %20 = load i32, i32* %i, align 4
  %21 = sext i32 %20 to i64
  %22 = load i64, i64* %2, align 8
  %23 = icmp slt i64 %21, %22
  br i1 %23, label %24, label %35

; <label>:24:                                     ; preds = %19
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %26 = load i32, i32* %i, align 4
  %27 = sext i32 %26 to i64
  %28 = load i64*, i64** %1, align 8
  %29 = getelementptr inbounds i64, i64* %28, i64 %27
  %30 = load i64, i64* %29, align 8
  %31 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %25, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i32 0, i32 0), i64 %30)
  br label %32

; <label>:32:                                     ; preds = %24
  %33 = load i32, i32* %i, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, i32* %i, align 4
  br label %19

; <label>:35:                                     ; preds = %19
  %36 = load %struct._IO_FILE*, %struct._IO_FILE** %fp, align 8
  %37 = call i32 @fclose(%struct._IO_FILE* %36)
  br label %38

; <label>:38:                                     ; preds = %35, %16
  ret void
}

; Function Attrs: nounwind
declare i32 @getpid() #3

; Function Attrs: nounwind
declare i32 @gethostname(i8*, i64) #3

; Function Attrs: nounwind
declare i32 @sprintf(i8*, i8*, ...) #3

declare %struct._IO_FILE* @fopen(i8*, i8*) #4

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #4

declare i32 @fclose(%struct._IO_FILE*) #4

declare i32 @sched_getcpu()

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }

!llvm.ident = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{!"clang version 6.0.0-1ubuntu2~16.04.1 (tags/RELEASE_600/final)"}
!1 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!2 = !{i32 1, !"wchar_size", i32 4}
