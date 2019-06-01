; ModuleID = 'montecarlo.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@.str = private unnamed_addr constant [34 x i8] c"please input the number of point\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0) }, align 8
@.gomp_critical_user_.reduction.var = common global [8 x i32] zeroinitializer
@1 = private unnamed_addr constant %ident_t { i32 0, i32 18, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.2, i32 0, i32 0) }, align 8
@.str.3 = private unnamed_addr constant [33 x i8] c"the estimate value of pi is %lf\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %num_in_cycle = alloca i64, align 8
  %num_point = alloca i64, align 8
  %thread_count = alloca i32, align 4
  %x = alloca double, align 8
  %y = alloca double, align 8
  %distance_point = alloca double, align 8
  %i = alloca i64, align 8
  %4 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  %estimate_pi = alloca double, align 8
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i64 0, i64* %num_in_cycle, align 8
  %5 = load i8**, i8*** %3, align 8
  %6 = getelementptr inbounds i8*, i8** %5, i64 1
  %7 = load i8*, i8** %6, align 8
  %8 = call i64 @strtol(i8* %7, i8** null, i32 10) #3
  %9 = trunc i64 %8 to i32
  store i32 %9, i32* %thread_count, align 4
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str, i32 0, i32 0))
  %11 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i64* %num_point)
  %12 = call i64 @time(i64* null) #3
  %13 = trunc i64 %12 to i32
  call void @srand(i32 %13) #3
  %14 = load i32, i32* %thread_count, align 4
  call void @__kmpc_push_num_threads(%ident_t* @0, i32 %4, i32 %14)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64*, i64*)* @.omp_outlined. to void (i32*, i32*, ...)*), i64* %num_point, i64* %num_in_cycle)
  %15 = load i64, i64* %num_in_cycle, align 8
  %16 = sitofp i64 %15 to double
  %17 = load i64, i64* %num_point, align 8
  %18 = sitofp i64 %17 to double
  %19 = fdiv double %16, %18
  %20 = fmul double %19, 4.000000e+00
  store double %20, double* %estimate_pi, align 8
  %21 = load double, double* %estimate_pi, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.3, i32 0, i32 0), double %21)
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @strtol(i8*, i8**, i32) #1

declare i32 @printf(i8*, ...) #2

declare i32 @__isoc99_scanf(i8*, ...) #2

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i64 @time(i64*) #1

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64* dereferenceable(8) %num_point, i64* dereferenceable(8) %num_in_cycle) #0 {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i64*, align 8
  %4 = alloca i64*, align 8
  %.omp.iv = alloca i64, align 8
  %.omp.last.iteration = alloca i64, align 8
  %i = alloca i64, align 8
  %.omp.lb = alloca i64, align 8
  %.omp.ub = alloca i64, align 8
  %.omp.stride = alloca i64, align 8
  %.omp.is_last = alloca i32, align 4
  %i1 = alloca i64, align 8
  %x = alloca double, align 8
  %y = alloca double, align 8
  %distance_point = alloca double, align 8
  %num_in_cycle2 = alloca i64, align 8
  %i3 = alloca i64, align 8
  %5 = alloca [1 x i8*], align 8
  store i32* %.global_tid., i32** %1, align 8
  store i32* %.bound_tid., i32** %2, align 8
  store i64* %num_point, i64** %3, align 8
  store i64* %num_in_cycle, i64** %4, align 8
  %6 = load i64*, i64** %3, align 8
  %7 = load i64*, i64** %4, align 8
  %8 = load i64, i64* %6, align 8
  %9 = sub nsw i64 %8, 0
  %10 = sub nsw i64 %9, 1
  %11 = add nsw i64 %10, 1
  %12 = sdiv i64 %11, 1
  %13 = sub nsw i64 %12, 1
  store i64 %13, i64* %.omp.last.iteration, align 8
  store i64 0, i64* %i, align 8
  %14 = load i64, i64* %6, align 8
  %15 = icmp slt i64 0, %14
  br i1 %15, label %16, label %79

; <label>:16                                      ; preds = %0
  store i64 0, i64* %.omp.lb, align 8
  %17 = load i64, i64* %.omp.last.iteration, align 8
  store i64 %17, i64* %.omp.ub, align 8
  store i64 1, i64* %.omp.stride, align 8
  store i32 0, i32* %.omp.is_last, align 4
  store i64 0, i64* %num_in_cycle2, align 8
  %18 = load i32*, i32** %1, align 8
  %19 = load i32, i32* %18, align 4
  call void @__kmpc_for_static_init_8(%ident_t* @0, i32 %19, i32 34, i32* %.omp.is_last, i64* %.omp.lb, i64* %.omp.ub, i64* %.omp.stride, i64 1, i64 1)
  %20 = load i64, i64* %.omp.ub, align 8
  %21 = load i64, i64* %.omp.last.iteration, align 8
  %22 = icmp sgt i64 %20, %21
  br i1 %22, label %23, label %25

; <label>:23                                      ; preds = %16
  %24 = load i64, i64* %.omp.last.iteration, align 8
  br label %27

; <label>:25                                      ; preds = %16
  %26 = load i64, i64* %.omp.ub, align 8
  br label %27

; <label>:27                                      ; preds = %25, %23
  %28 = phi i64 [ %24, %23 ], [ %26, %25 ]
  store i64 %28, i64* %.omp.ub, align 8
  %29 = load i64, i64* %.omp.lb, align 8
  store i64 %29, i64* %.omp.iv, align 8
  br label %30

; <label>:30                                      ; preds = %58, %27
  %31 = load i64, i64* %.omp.iv, align 8
  %32 = load i64, i64* %.omp.ub, align 8
  %33 = icmp sle i64 %31, %32
  br i1 %33, label %34, label %61

; <label>:34                                      ; preds = %30
  %35 = load i64, i64* %.omp.iv, align 8
  %36 = mul nsw i64 %35, 1
  %37 = add nsw i64 0, %36
  store i64 %37, i64* %i1, align 8
  %38 = call i32 @rand() #3
  %39 = sitofp i32 %38 to double
  %40 = fdiv double %39, 0x41DFFFFFFFC00000
  store double %40, double* %x, align 8
  %41 = call i32 @rand() #3
  %42 = sitofp i32 %41 to double
  %43 = fdiv double %42, 0x41DFFFFFFFC00000
  store double %43, double* %y, align 8
  %44 = load double, double* %x, align 8
  %45 = load double, double* %x, align 8
  %46 = fmul double %44, %45
  %47 = load double, double* %y, align 8
  %48 = load double, double* %y, align 8
  %49 = fmul double %47, %48
  %50 = fadd double %46, %49
  store double %50, double* %distance_point, align 8
  %51 = load double, double* %distance_point, align 8
  %52 = fcmp ole double %51, 1.000000e+00
  br i1 %52, label %53, label %56

; <label>:53                                      ; preds = %34
  %54 = load i64, i64* %num_in_cycle2, align 8
  %55 = add nsw i64 %54, 1
  store i64 %55, i64* %num_in_cycle2, align 8
  br label %56

; <label>:56                                      ; preds = %53, %34
  br label %57

; <label>:57                                      ; preds = %56
  br label %58

; <label>:58                                      ; preds = %57
  %59 = load i64, i64* %.omp.iv, align 8
  %60 = add nsw i64 %59, 1
  store i64 %60, i64* %.omp.iv, align 8
  br label %30

; <label>:61                                      ; preds = %30
  br label %62

; <label>:62                                      ; preds = %61
  %63 = load i32*, i32** %1, align 8
  %64 = load i32, i32* %63, align 4
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %64)
  %65 = getelementptr inbounds [1 x i8*], [1 x i8*]* %5, i64 0, i64 0
  %66 = bitcast i64* %num_in_cycle2 to i8*
  store i8* %66, i8** %65, align 8
  %67 = load i32*, i32** %1, align 8
  %68 = load i32, i32* %67, align 4
  %69 = bitcast [1 x i8*]* %5 to i8*
  %70 = call i32 @__kmpc_reduce_nowait(%ident_t* @1, i32 %68, i32 1, i64 8, i8* %69, void (i8*, i8*)* @.omp.reduction.reduction_func, [8 x i32]* @.gomp_critical_user_.reduction.var)
  switch i32 %70, label %78 [
    i32 1, label %71
    i32 2, label %75
  ]

; <label>:71                                      ; preds = %62
  %72 = load i64, i64* %7, align 8
  %73 = load i64, i64* %num_in_cycle2, align 8
  %74 = add nsw i64 %72, %73
  store i64 %74, i64* %7, align 8
  call void @__kmpc_end_reduce_nowait(%ident_t* @1, i32 %68, [8 x i32]* @.gomp_critical_user_.reduction.var)
  br label %78

; <label>:75                                      ; preds = %62
  %76 = load i64, i64* %num_in_cycle2, align 8
  %77 = atomicrmw add i64* %7, i64 %76 monotonic
  br label %78

; <label>:78                                      ; preds = %75, %71, %62
  br label %79

; <label>:79                                      ; preds = %78, %0
  ret void
}

declare void @__kmpc_for_static_init_8(%ident_t*, i32, i32, i32*, i64*, i64*, i64*, i64, i64)

; Function Attrs: nounwind
declare i32 @rand() #1

declare void @__kmpc_for_static_fini(%ident_t*, i32)

; Function Attrs: nounwind uwtable
define internal void @.omp.reduction.reduction_func(i8*, i8*) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = bitcast i8* %5 to [1 x i8*]*
  %7 = load i8*, i8** %4, align 8
  %8 = bitcast i8* %7 to [1 x i8*]*
  %9 = getelementptr inbounds [1 x i8*], [1 x i8*]* %8, i64 0, i64 0
  %10 = load i8*, i8** %9, align 8
  %11 = bitcast i8* %10 to i64*
  %12 = getelementptr inbounds [1 x i8*], [1 x i8*]* %6, i64 0, i64 0
  %13 = load i8*, i8** %12, align 8
  %14 = bitcast i8* %13 to i64*
  %15 = load i64, i64* %14, align 8
  %16 = load i64, i64* %11, align 8
  %17 = add nsw i64 %15, %16
  store i64 %17, i64* %14, align 8
  ret void
}

declare i32 @__kmpc_reduce_nowait(%ident_t*, i32, i32, i64, i8*, void (i8*, i8*)*, [8 x i32]*)

declare void @__kmpc_end_reduce_nowait(%ident_t*, i32, [8 x i32]*)

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_push_num_threads(%ident_t*, i32, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
