; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@firstParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@secondParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@matrixMultiResult = global [1024 x [1024 x double]] zeroinitializer, align 16
@.str.2 = private unnamed_addr constant [12 x i8] c"Time: %lld\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
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
  %9 = icmp slt i32 %8, 1024
  br i1 %9, label %10, label %31

; <label>:10:                                     ; preds = %7
  %11 = load i32, i32* %3, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [1024 x [1024 x double]], [1024 x [1024 x double]]* @firstParaMatrix, i64 0, i64 %12
  %14 = load i32, i32* %6, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [1024 x double], [1024 x double]* %13, i64 0, i64 %15
  %17 = load double, double* %16, align 8
  %18 = load i32, i32* %6, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [1024 x [1024 x double]], [1024 x [1024 x double]]* @secondParaMatrix, i64 0, i64 %19
  %21 = load i32, i32* %4, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [1024 x double], [1024 x double]* %20, i64 0, i64 %22
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

; Function Attrs: noinline nounwind optnone uwtable
define void @matrixInit() #0 {
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @1, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
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
  %12 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %7, align 4
  store i32 1023, i32* %8, align 4
  store i32 1, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %13 = load i32*, i32** %3, align 8
  %14 = load i32, i32* %13, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %14, i32 34, i32* %10, i32* %7, i32* %8, i32* %9, i32 1, i32 1)
  %15 = load i32, i32* %8, align 4
  %16 = icmp sgt i32 %15, 1023
  br i1 %16, label %17, label %18

; <label>:17:                                     ; preds = %2
  br label %20

; <label>:18:                                     ; preds = %2
  %19 = load i32, i32* %8, align 4
  br label %20

; <label>:20:                                     ; preds = %18, %17
  %21 = phi i32 [ 1023, %17 ], [ %19, %18 ]
  store i32 %21, i32* %8, align 4
  %22 = load i32, i32* %7, align 4
  store i32 %22, i32* %5, align 4
  br label %23

; <label>:23:                                     ; preds = %63, %20
  %24 = load i32, i32* %5, align 4
  %25 = load i32, i32* %8, align 4
  %26 = icmp sle i32 %24, %25
  br i1 %26, label %27, label %66

; <label>:27:                                     ; preds = %23
  %28 = load i32, i32* %5, align 4
  %29 = mul nsw i32 %28, 1
  %30 = add nsw i32 0, %29
  store i32 %30, i32* %11, align 4
  store i32 0, i32* %12, align 4
  br label %31

; <label>:31:                                     ; preds = %58, %27
  %32 = load i32, i32* %12, align 4
  %33 = icmp slt i32 %32, 1024
  br i1 %33, label %34, label %61

; <label>:34:                                     ; preds = %31
  %35 = load i32, i32* %11, align 4
  %36 = load i32, i32* %12, align 4
  %37 = add nsw i32 %35, %36
  call void @srand(i32 %37) #3
  %38 = call i32 @rand() #3
  %39 = srem i32 %38, 10
  %40 = sitofp i32 %39 to double
  %41 = fmul double %40, 1.100000e+00
  %42 = load i32, i32* %11, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [1024 x [1024 x double]], [1024 x [1024 x double]]* @firstParaMatrix, i64 0, i64 %43
  %45 = load i32, i32* %12, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x double], [1024 x double]* %44, i64 0, i64 %46
  store double %41, double* %47, align 8
  %48 = call i32 @rand() #3
  %49 = srem i32 %48, 10
  %50 = sitofp i32 %49 to double
  %51 = fmul double %50, 1.100000e+00
  %52 = load i32, i32* %11, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [1024 x [1024 x double]], [1024 x [1024 x double]]* @secondParaMatrix, i64 0, i64 %53
  %55 = load i32, i32* %12, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [1024 x double], [1024 x double]* %54, i64 0, i64 %56
  store double %51, double* %57, align 8
  br label %58

; <label>:58:                                     ; preds = %34
  %59 = load i32, i32* %12, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %12, align 4
  br label %31

; <label>:61:                                     ; preds = %31
  br label %62

; <label>:62:                                     ; preds = %61
  br label %63

; <label>:63:                                     ; preds = %62
  %64 = load i32, i32* %5, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, i32* %5, align 4
  br label %23

; <label>:66:                                     ; preds = %23
  br label %67

; <label>:67:                                     ; preds = %66
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %14)
  ret void
}

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i32 @rand() #1

declare void @__kmpc_for_static_fini(%ident_t*, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: noinline nounwind optnone uwtable
define void @matrixMulti() #0 {
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @1, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined..1 to void (i32*, i32*, ...)*))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
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
  %12 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %7, align 4
  store i32 1023, i32* %8, align 4
  store i32 1, i32* %9, align 4
  store i32 0, i32* %10, align 4
  %13 = load i32*, i32** %3, align 8
  %14 = load i32, i32* %13, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %14, i32 34, i32* %10, i32* %7, i32* %8, i32* %9, i32 1, i32 1)
  %15 = load i32, i32* %8, align 4
  %16 = icmp sgt i32 %15, 1023
  br i1 %16, label %17, label %18

; <label>:17:                                     ; preds = %2
  br label %20

; <label>:18:                                     ; preds = %2
  %19 = load i32, i32* %8, align 4
  br label %20

; <label>:20:                                     ; preds = %18, %17
  %21 = phi i32 [ 1023, %17 ], [ %19, %18 ]
  store i32 %21, i32* %8, align 4
  %22 = load i32, i32* %7, align 4
  store i32 %22, i32* %5, align 4
  br label %23

; <label>:23:                                     ; preds = %49, %20
  %24 = load i32, i32* %5, align 4
  %25 = load i32, i32* %8, align 4
  %26 = icmp sle i32 %24, %25
  br i1 %26, label %27, label %52

; <label>:27:                                     ; preds = %23
  %28 = load i32, i32* %5, align 4
  %29 = mul nsw i32 %28, 1
  %30 = add nsw i32 0, %29
  store i32 %30, i32* %11, align 4
  store i32 0, i32* %12, align 4
  br label %31

; <label>:31:                                     ; preds = %44, %27
  %32 = load i32, i32* %12, align 4
  %33 = icmp slt i32 %32, 1024
  br i1 %33, label %34, label %47

; <label>:34:                                     ; preds = %31
  %35 = load i32, i32* %11, align 4
  %36 = load i32, i32* %12, align 4
  %37 = call double @calcuPartOfMatrixMulti(i32 %35, i32 %36)
  %38 = load i32, i32* %11, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [1024 x [1024 x double]], [1024 x [1024 x double]]* @matrixMultiResult, i64 0, i64 %39
  %41 = load i32, i32* %12, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [1024 x double], [1024 x double]* %40, i64 0, i64 %42
  store double %37, double* %43, align 8
  br label %44

; <label>:44:                                     ; preds = %34
  %45 = load i32, i32* %12, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* %12, align 4
  br label %31

; <label>:47:                                     ; preds = %31
  br label %48

; <label>:48:                                     ; preds = %47
  br label %49

; <label>:49:                                     ; preds = %48
  %50 = load i32, i32* %5, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %5, align 4
  br label %23

; <label>:52:                                     ; preds = %23
  br label %53

; <label>:53:                                     ; preds = %52
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %14)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
