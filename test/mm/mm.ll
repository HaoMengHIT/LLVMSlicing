; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@firstParaMatrix = global [2048 x [2048 x double]] zeroinitializer, align 16
@secondParaMatrix = global [2048 x [2048 x double]] zeroinitializer, align 16
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@matrixMultiResult = global [2048 x [2048 x double]] zeroinitializer, align 16
@.str.2 = private unnamed_addr constant [12 x i8] c"Time: %lld\0A\00", align 1

; Function Attrs: nounwind uwtable
define double @calcuPartOfMatrixMulti(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  %6 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  store double 0.000000e+00, double* %5, align 8
  store i32 0, i32* %6, align 4
  br label %7

; <label>:7:                                      ; preds = %28, %2
  %8 = load i32, i32* %6, align 4
  %9 = icmp slt i32 %8, 2048
  br i1 %9, label %10, label %31

; <label>:10:                                     ; preds = %7
  %11 = load i32, i32* %6, align 4
  %12 = sext i32 %11 to i64
  %13 = load i32, i32* %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @firstParaMatrix, i64 0, i64 %14
  %16 = getelementptr inbounds [2048 x double], [2048 x double]* %15, i64 0, i64 %12
  %17 = load double, double* %16, align 8
  %18 = load i32, i32* %4, align 4
  %19 = sext i32 %18 to i64
  %20 = load i32, i32* %6, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @secondParaMatrix, i64 0, i64 %21
  %23 = getelementptr inbounds [2048 x double], [2048 x double]* %22, i64 0, i64 %19
  %24 = load double, double* %23, align 8
  %25 = fmul double %17, %24
  %26 = load double, double* %5, align 8
  %27 = fadd double %26, %25
  store double %27, double* %5, align 8
  br label %28

; <label>:28:                                     ; preds = %10
  %29 = load i32, i32* %6, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %6, align 4
  br label %7

; <label>:31:                                     ; preds = %7
  %32 = load double, double* %5, align 8
  ret double %32
}

; Function Attrs: nounwind uwtable
define void @matrixInit() #0 {
  %1 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  call void @__kmpc_push_num_threads(%ident_t* @0, i32 %1, i32 64)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*))
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %6, align 4
  store i32 2047, i32* %7, align 4
  store i32 1, i32* %8, align 4
  store i32 0, i32* %9, align 4
  %12 = load i32*, i32** %3, align 8
  %13 = load i32, i32* %12, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %13, i32 34, i32* %9, i32* %6, i32* %7, i32* %8, i32 1, i32 1)
  %14 = load i32, i32* %7, align 4
  %15 = icmp sgt i32 %14, 2047
  br i1 %15, label %16, label %17

; <label>:16:                                     ; preds = %2
  br label %19

; <label>:17:                                     ; preds = %2
  %18 = load i32, i32* %7, align 4
  br label %19

; <label>:19:                                     ; preds = %17, %16
  %20 = phi i32 [ 2047, %16 ], [ %18, %17 ]
  store i32 %20, i32* %7, align 4
  %21 = load i32, i32* %6, align 4
  store i32 %21, i32* %5, align 4
  br label %22

; <label>:22:                                     ; preds = %62, %19
  %23 = load i32, i32* %5, align 4
  %24 = load i32, i32* %7, align 4
  %25 = icmp sle i32 %23, %24
  br i1 %25, label %26, label %65

; <label>:26:                                     ; preds = %22
  %27 = load i32, i32* %5, align 4
  %28 = mul nsw i32 %27, 1
  %29 = add nsw i32 0, %28
  store i32 %29, i32* %10, align 4
  store i32 0, i32* %11, align 4
  br label %30

; <label>:30:                                     ; preds = %57, %26
  %31 = load i32, i32* %11, align 4
  %32 = icmp slt i32 %31, 2048
  br i1 %32, label %33, label %60

; <label>:33:                                     ; preds = %30
  %34 = load i32, i32* %10, align 4
  %35 = load i32, i32* %11, align 4
  %36 = add nsw i32 %34, %35
  call void @srand(i32 %36) #3
  %37 = call i32 @rand() #3
  %38 = srem i32 %37, 10
  %39 = sitofp i32 %38 to double
  %40 = fmul double %39, 1.100000e+00
  %41 = load i32, i32* %11, align 4
  %42 = sext i32 %41 to i64
  %43 = load i32, i32* %10, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @firstParaMatrix, i64 0, i64 %44
  %46 = getelementptr inbounds [2048 x double], [2048 x double]* %45, i64 0, i64 %42
  store double %40, double* %46, align 8
  %47 = call i32 @rand() #3
  %48 = srem i32 %47, 10
  %49 = sitofp i32 %48 to double
  %50 = fmul double %49, 1.100000e+00
  %51 = load i32, i32* %11, align 4
  %52 = sext i32 %51 to i64
  %53 = load i32, i32* %10, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @secondParaMatrix, i64 0, i64 %54
  %56 = getelementptr inbounds [2048 x double], [2048 x double]* %55, i64 0, i64 %52
  store double %50, double* %56, align 8
  br label %57

; <label>:57:                                     ; preds = %33
  %58 = load i32, i32* %11, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, i32* %11, align 4
  br label %30

; <label>:60:                                     ; preds = %30
  br label %61

; <label>:61:                                     ; preds = %60
  br label %62

; <label>:62:                                     ; preds = %61
  %63 = load i32, i32* %5, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, i32* %5, align 4
  br label %22

; <label>:65:                                     ; preds = %22
  br label %66

; <label>:66:                                     ; preds = %65
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %13)
  ret void
}

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i32 @rand() #1

declare void @__kmpc_for_static_fini(%ident_t*, i32)

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_push_num_threads(%ident_t*, i32, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: nounwind uwtable
define void @matrixMulti() #0 {
  %1 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  call void @__kmpc_push_num_threads(%ident_t* @0, i32 %1, i32 64)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined..1 to void (i32*, i32*, ...)*))
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined..1(i32* noalias, i32* noalias) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %6, align 4
  store i32 2047, i32* %7, align 4
  store i32 1, i32* %8, align 4
  store i32 0, i32* %9, align 4
  %12 = load i32*, i32** %3, align 8
  %13 = load i32, i32* %12, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %13, i32 34, i32* %9, i32* %6, i32* %7, i32* %8, i32 1, i32 1)
  %14 = load i32, i32* %7, align 4
  %15 = icmp sgt i32 %14, 2047
  br i1 %15, label %16, label %17

; <label>:16:                                     ; preds = %2
  br label %19

; <label>:17:                                     ; preds = %2
  %18 = load i32, i32* %7, align 4
  br label %19

; <label>:19:                                     ; preds = %17, %16
  %20 = phi i32 [ 2047, %16 ], [ %18, %17 ]
  store i32 %20, i32* %7, align 4
  %21 = load i32, i32* %6, align 4
  store i32 %21, i32* %5, align 4
  br label %22

; <label>:22:                                     ; preds = %48, %19
  %23 = load i32, i32* %5, align 4
  %24 = load i32, i32* %7, align 4
  %25 = icmp sle i32 %23, %24
  br i1 %25, label %26, label %51

; <label>:26:                                     ; preds = %22
  %27 = load i32, i32* %5, align 4
  %28 = mul nsw i32 %27, 1
  %29 = add nsw i32 0, %28
  store i32 %29, i32* %10, align 4
  store i32 0, i32* %11, align 4
  br label %30

; <label>:30:                                     ; preds = %43, %26
  %31 = load i32, i32* %11, align 4
  %32 = icmp slt i32 %31, 2048
  br i1 %32, label %33, label %46

; <label>:33:                                     ; preds = %30
  %34 = load i32, i32* %10, align 4
  %35 = load i32, i32* %11, align 4
  %36 = call double @calcuPartOfMatrixMulti(i32 %34, i32 %35)
  %37 = load i32, i32* %11, align 4
  %38 = sext i32 %37 to i64
  %39 = load i32, i32* %10, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @matrixMultiResult, i64 0, i64 %40
  %42 = getelementptr inbounds [2048 x double], [2048 x double]* %41, i64 0, i64 %38
  store double %36, double* %42, align 8
  br label %43

; <label>:43:                                     ; preds = %33
  %44 = load i32, i32* %11, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %11, align 4
  br label %30

; <label>:46:                                     ; preds = %30
  br label %47

; <label>:47:                                     ; preds = %46
  br label %48

; <label>:48:                                     ; preds = %47
  %49 = load i32, i32* %5, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* %5, align 4
  br label %22

; <label>:51:                                     ; preds = %22
  br label %52

; <label>:52:                                     ; preds = %51
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %13)
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @matrixInit()
  %4 = call i64 @clock() #3
  store i64 %4, i64* %2, align 8
  call void @matrixMulti()
  %5 = call i64 @clock() #3
  store i64 %5, i64* %3, align 8
  %6 = load i64, i64* %3, align 8
  %7 = load i64, i64* %2, align 8
  %8 = sub nsw i64 %6, %7
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 %8)
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @clock() #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1-19ubuntu1 (tags/RELEASE_391/rc2)"}
