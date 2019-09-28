; ModuleID = 'prime_openmp_new.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.gomp_critical_user_.reduction.var = common global [8 x i32] zeroinitializer
@str = private unnamed_addr constant [13 x i8] c"PRIME_OPENMP\00"
@str.11 = private unnamed_addr constant [19 x i8] c"  C/OpenMP version\00"
@.str.3 = private unnamed_addr constant [39 x i8] c"  Number of processors available = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [39 x i8] c"  Number of threads =              %d\0A\00", align 1
@str.12 = private unnamed_addr constant [13 x i8] c"PRIME_OPENMP\00"
@str.13 = private unnamed_addr constant [27 x i8] c"  Normal end of execution.\00"
@str.14 = private unnamed_addr constant [7 x i8] c"TEST01\00"
@str.15 = private unnamed_addr constant [53 x i8] c"  Call PRIME_NUMBER to count the primes from 1 to N.\00"
@str.16 = private unnamed_addr constant [35 x i8] c"         N        Pi          Time\00"
@.str.9 = private unnamed_addr constant [18 x i8] c"  %8d  %8d  %14f\0A\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 18, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant %ident_t { i32 0, i32 66, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@.str.10 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@.str = private unnamed_addr constant [13 x i8] c"%s.%d.bbfout\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"hello world  %s\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.3.1 = private unnamed_addr constant [17 x i8] c"open file wrong\0A\00", align 1
@.str.4.2 = private unnamed_addr constant [5 x i8] c"%ld\09\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = tail call i32 @putchar(i32 10)
  %4 = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str, i64 0, i64 0))
  %5 = tail call i32 @puts(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @str.11, i64 0, i64 0))
  %6 = tail call i32 @putchar(i32 10)
  %7 = tail call i32 @omp_get_num_procs() #1
  %8 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.3, i64 0, i64 0), i32 %7)
  %9 = tail call i32 @omp_get_max_threads() #1
  %10 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.4, i64 0, i64 0), i32 %9)
  tail call void @prime_number_sweep(i32 1, i32 131072, i32 2)
  tail call void @prime_number_sweep(i32 5, i32 500000, i32 10)
  %11 = tail call i32 @putchar(i32 10)
  %12 = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.12, i64 0, i64 0))
  %13 = tail call i32 @puts(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @str.13, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @putchar(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #1

declare i32 @omp_get_num_procs() local_unnamed_addr #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

declare i32 @omp_get_max_threads() local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define void @prime_number_sweep(i32, i32, i32) local_unnamed_addr #0 {
  %4 = tail call i32 @putchar(i32 10)
  %5 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.14, i64 0, i64 0))
  %6 = tail call i32 @puts(i8* getelementptr inbounds ([53 x i8], [53 x i8]* @str.15, i64 0, i64 0))
  %7 = tail call i32 @putchar(i32 10)
  %8 = tail call i32 @puts(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @str.16, i64 0, i64 0))
  %9 = tail call i32 @putchar(i32 10)
  %10 = icmp sgt i32 %0, %1
  br i1 %10, label %21, label %11

; <label>:11:                                     ; preds = %3
  br label %12

; <label>:12:                                     ; preds = %11, %12
  %13 = phi i32 [ %19, %12 ], [ %0, %11 ]
  %14 = tail call double @omp_get_wtime() #1
  %15 = tail call i32 @prime_number(i32 %13)
  %16 = tail call double @omp_get_wtime() #1
  %17 = fsub double %16, %14
  %18 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i32 %13, i32 %15, double %17)
  %19 = mul nsw i32 %13, %2
  %20 = icmp sgt i32 %19, %1
  br i1 %20, label %21, label %12

; <label>:21:                                     ; preds = %12, %3
  ret void
}

declare double @omp_get_wtime() local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define i32 @prime_number(i32) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4, !tbaa !2
  %4 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #1
  store i32 0, i32* %3, align 4, !tbaa !2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* nonnull %3, i32* nonnull %2) #1
  %5 = load i32, i32* %3, align 4, !tbaa !2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #1
  ret i32 %5
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #4

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly, i32* noalias nocapture readnone, i32* nocapture dereferenceable(4), i32* nocapture readonly dereferenceable(4)) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca [1 x i8*], align 8
  %11 = load i32, i32* %3, align 4, !tbaa !2
  %12 = add nsw i32 %11, -2
  %13 = icmp sgt i32 %11, 1
  br i1 %13, label %14, label %59

; <label>:14:                                     ; preds = %4
  %15 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %15) #1
  store i32 0, i32* %5, align 4, !tbaa !2
  %16 = bitcast i32* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %16) #1
  store i32 %12, i32* %6, align 4, !tbaa !2
  %17 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %17) #1
  store i32 1, i32* %7, align 4, !tbaa !2
  %18 = bitcast i32* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %18) #1
  store i32 0, i32* %8, align 4, !tbaa !2
  %19 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %19) #1
  store i32 0, i32* %9, align 4, !tbaa !2
  %20 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @1, i32 %20, i32 34, i32* nonnull %8, i32* nonnull %5, i32* nonnull %6, i32* nonnull %7, i32 1, i32 1) #1
  %21 = load i32, i32* %6, align 4, !tbaa !2
  %22 = icmp sgt i32 %21, %12
  %23 = select i1 %22, i32 %12, i32 %21
  store i32 %23, i32* %6, align 4, !tbaa !2
  %24 = load i32, i32* %5, align 4, !tbaa !2
  %25 = icmp sgt i32 %24, %23
  br i1 %25, label %47, label %26

; <label>:26:                                     ; preds = %14
  %27 = load i32, i32* %9, align 4, !tbaa !2
  br label %28

; <label>:28:                                     ; preds = %41, %26
  %29 = phi i32 [ %27, %26 ], [ %43, %41 ]
  %30 = phi i32 [ %24, %26 ], [ %44, %41 ]
  %31 = add nsw i32 %30, 2
  %32 = icmp sgt i32 %30, 0
  br i1 %32, label %33, label %41

; <label>:33:                                     ; preds = %28
  br label %36

; <label>:34:                                     ; preds = %36
  %35 = icmp slt i32 %40, %31
  br i1 %35, label %36, label %41

; <label>:36:                                     ; preds = %33, %34
  %37 = phi i32 [ %40, %34 ], [ 2, %33 ]
  %38 = srem i32 %31, %37
  %39 = icmp eq i32 %38, 0
  %40 = add nuw nsw i32 %37, 1
  br i1 %39, label %41, label %34

; <label>:41:                                     ; preds = %34, %36, %28
  %42 = phi i32 [ 1, %28 ], [ 0, %36 ], [ 1, %34 ]
  %43 = add nsw i32 %29, %42
  %44 = add nsw i32 %30, 1
  %45 = icmp slt i32 %30, %23
  br i1 %45, label %28, label %46

; <label>:46:                                     ; preds = %41
  store i32 %43, i32* %9, align 4, !tbaa !2
  br label %47

; <label>:47:                                     ; preds = %46, %14
  call void @__kmpc_for_static_fini(%ident_t* nonnull @1, i32 %20) #1
  %48 = bitcast [1 x i8*]* %10 to i32**
  store i32* %9, i32** %48, align 8
  %49 = bitcast [1 x i8*]* %10 to i8*
  %50 = call i32 @__kmpc_reduce(%ident_t* nonnull @2, i32 %20, i32 1, i64 8, i8* nonnull %49, void (i8*, i8*)* nonnull @.omp.reduction.reduction_func, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #1
  switch i32 %50, label %58 [
    i32 1, label %51
    i32 2, label %55
  ]

; <label>:51:                                     ; preds = %47
  %52 = load i32, i32* %2, align 4, !tbaa !2
  %53 = load i32, i32* %9, align 4, !tbaa !2
  %54 = add nsw i32 %53, %52
  store i32 %54, i32* %2, align 4, !tbaa !2
  call void @__kmpc_end_reduce(%ident_t* nonnull @2, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #1
  br label %58

; <label>:55:                                     ; preds = %47
  %56 = load i32, i32* %9, align 4, !tbaa !2
  %57 = atomicrmw add i32* %2, i32 %56 monotonic
  call void @__kmpc_end_reduce(%ident_t* nonnull @2, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #1
  br label %58

; <label>:58:                                     ; preds = %55, %51, %47
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %19) #1
  br label %59

; <label>:59:                                     ; preds = %58, %4
  %60 = bitcast i32* %8 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %60) #1
  %61 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %61) #1
  %62 = bitcast i32* %6 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %62) #1
  %63 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %63) #1
  %64 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_barrier(%ident_t* nonnull @3, i32 %64) #1
  ret void
}

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #4

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

declare void @__kmpc_for_static_fini(%ident_t*, i32) local_unnamed_addr

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp.reduction.reduction_func(i8* nocapture readonly, i8* nocapture readonly) #5 {
  %3 = bitcast i8* %1 to i32**
  %4 = load i32*, i32** %3, align 8
  %5 = bitcast i8* %0 to i32**
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4, !tbaa !2
  %8 = load i32, i32* %4, align 4, !tbaa !2
  %9 = add nsw i32 %8, %7
  store i32 %9, i32* %6, align 4, !tbaa !2
  ret void
}

declare i32 @__kmpc_reduce(%ident_t*, i32, i32, i64, i8*, void (i8*, i8*)*, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_reduce(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_barrier(%ident_t*, i32) local_unnamed_addr

; Function Attrs: noinline optnone uwtable
define void @_Z18WriteOpenMPProfilePll(i64*, i64) #6 {
  %3 = alloca i64*, align 8
  %4 = alloca i64, align 8
  %5 = alloca [150 x i8], align 16
  %6 = alloca [100 x i8], align 16
  %7 = alloca i32, align 4
  %8 = alloca %struct._IO_FILE*, align 8
  %9 = alloca i32, align 4
  store i64* %0, i64** %3, align 8
  store i64 %1, i64* %4, align 8
  %10 = call i32 @getpid() #1
  store i32 %10, i32* %7, align 4
  %11 = getelementptr inbounds [100 x i8], [100 x i8]* %6, i32 0, i32 0
  %12 = call i32 @gethostname(i8* %11, i64 99) #1
  %13 = getelementptr inbounds [150 x i8], [150 x i8]* %5, i32 0, i32 0
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %6, i32 0, i32 0
  %15 = load i32, i32* %7, align 4
  %16 = call i32 (i8*, i8*, ...) @sprintf(i8* %13, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0), i8* %14, i32 %15) #1
  %17 = getelementptr inbounds [150 x i8], [150 x i8]* %5, i32 0, i32 0
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i8* %17)
  %19 = getelementptr inbounds [150 x i8], [150 x i8]* %5, i32 0, i32 0
  %20 = call %struct._IO_FILE* @fopen(i8* %19, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0))
  store %struct._IO_FILE* %20, %struct._IO_FILE** %8, align 8
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %22 = icmp eq %struct._IO_FILE* %21, null
  br i1 %22, label %23, label %25

; <label>:23:                                     ; preds = %2
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3.1, i32 0, i32 0))
  br label %45

; <label>:25:                                     ; preds = %2
  store i32 0, i32* %9, align 4
  br label %26

; <label>:26:                                     ; preds = %39, %25
  %27 = load i32, i32* %9, align 4
  %28 = sext i32 %27 to i64
  %29 = load i64, i64* %4, align 8
  %30 = icmp slt i64 %28, %29
  br i1 %30, label %31, label %42

; <label>:31:                                     ; preds = %26
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %33 = load i64*, i64** %3, align 8
  %34 = load i32, i32* %9, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i64, i64* %33, i64 %35
  %37 = load i64, i64* %36, align 8
  %38 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %32, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4.2, i32 0, i32 0), i64 %37)
  br label %39

; <label>:39:                                     ; preds = %31
  %40 = load i32, i32* %9, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %9, align 4
  br label %26

; <label>:42:                                     ; preds = %26
  %43 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %44 = call i32 @fclose(%struct._IO_FILE* %43)
  br label %45

; <label>:45:                                     ; preds = %42, %23
  ret void
}

; Function Attrs: nounwind
declare i32 @getpid() #7

; Function Attrs: nounwind
declare i32 @gethostname(i8*, i64) #7

; Function Attrs: nounwind
declare i32 @sprintf(i8*, i8*, ...) #7

declare %struct._IO_FILE* @fopen(i8*, i8*) #8

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #8

declare i32 @fclose(%struct._IO_FILE*) #8

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0, !0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 6.0.0-1ubuntu2~16.04.1 (tags/RELEASE_600/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
