; ModuleID = 'ep.B.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.timeval = type { i64, i64 }
%struct.timezone = type { i32, i32 }

@.gomp_critical_user_.reduction.var = common global [8 x i32] zeroinitializer
@.gomp_critical_user_.var = common global [8 x i32] zeroinitializer
@main.dum = private unnamed_addr constant [3 x double] [double 1.000000e+00, double 1.000000e+00, double 1.000000e+00], align 16
@str = private unnamed_addr constant [74 x i8] c"\0A\0A NAS Parallel Benchmarks 3.0 structured OpenMP C version - EP Benchmark\00"
@.str.1 = private unnamed_addr constant [7 x i8] c"%12.0f\00", align 1
@.str.2 = private unnamed_addr constant [43 x i8] c" Number of random numbers generated: %13s\0A\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@x = internal thread_local global [131072 x double] zeroinitializer, align 16
@q = internal unnamed_addr global [10 x double] zeroinitializer, align 16
@1 = private unnamed_addr constant %ident_t { i32 0, i32 66, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant %ident_t { i32 0, i32 18, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@.str.3 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@.str.1.1 = private unnamed_addr constant [27 x i8] c"\0A\0A %s Benchmark Completed\0A\00", align 1
@.str.2.2 = private unnamed_addr constant [46 x i8] c" Class           =                        %c\0A\00", align 1
@.str.3.3 = private unnamed_addr constant [37 x i8] c" Size            =             %12d\0A\00", align 1
@.str.4 = private unnamed_addr constant [45 x i8] c" Size            =              %3dx%3dx%3d\0A\00", align 1
@.str.5 = private unnamed_addr constant [37 x i8] c" Iterations      =             %12d\0A\00", align 1
@.str.6 = private unnamed_addr constant [37 x i8] c" Threads         =             %12d\0A\00", align 1
@.str.7 = private unnamed_addr constant [39 x i8] c" Time in seconds =             %12.2f\0A\00", align 1
@.str.8 = private unnamed_addr constant [39 x i8] c" Mop/s total     =             %12.2f\0A\00", align 1
@.str.9 = private unnamed_addr constant [25 x i8] c" Operation type  = %24s\0A\00", align 1
@str.23 = private unnamed_addr constant [44 x i8] c" Verification    =               SUCCESSFUL\00"
@str.4 = private unnamed_addr constant [44 x i8] c" Verification    =             UNSUCCESSFUL\00"
@.str.12 = private unnamed_addr constant [35 x i8] c" Version         =           %12s\0A\00", align 1
@.str.13 = private unnamed_addr constant [37 x i8] c" Compile date    =             %12s\0A\00", align 1
@str.22 = private unnamed_addr constant [19 x i8] c"\0A Compile options:\00"
@.str.15 = private unnamed_addr constant [23 x i8] c"    CC           = %s\0A\00", align 1
@.str.16 = private unnamed_addr constant [23 x i8] c"    CLINK        = %s\0A\00", align 1
@.str.17 = private unnamed_addr constant [23 x i8] c"    C_LIB        = %s\0A\00", align 1
@.str.18 = private unnamed_addr constant [23 x i8] c"    C_INC        = %s\0A\00", align 1
@.str.19 = private unnamed_addr constant [23 x i8] c"    CFLAGS       = %s\0A\00", align 1
@.str.20 = private unnamed_addr constant [23 x i8] c"    CLINKFLAGS   = %s\0A\00", align 1
@.str.21 = private unnamed_addr constant [23 x i8] c"    RAND         = %s\0A\00", align 1
@elapsed = common local_unnamed_addr global [64 x double] zeroinitializer, align 16
@start = common local_unnamed_addr global [64 x double] zeroinitializer, align 16
@wtime_.sec = internal unnamed_addr global i32 -1, align 4

; Function Attrs: nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca [3 x double], align 16
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca [14 x i8], align 1
  %13 = bitcast double* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %13) #2
  %14 = bitcast double* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %14) #2
  %15 = bitcast double* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #2
  %16 = bitcast double* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %16) #2
  %17 = bitcast [3 x double]* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %17) #2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %17, i8* bitcast ([3 x double]* @main.dum to i8*), i64 24, i32 16, i1 false)
  %18 = bitcast i32* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %18) #2
  %19 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %19) #2
  %20 = bitcast i32* %10 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %20) #2
  %21 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %21) #2
  store i32 1, i32* %11, align 4, !tbaa !2
  %22 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %22) #2
  %23 = tail call i32 @puts(i8* getelementptr inbounds ([74 x i8], [74 x i8]* @str, i64 0, i64 0))
  %24 = call i32 (i8*, i8*, ...) @sprintf(i8* nonnull %22, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0), double 0x41E0000000000000) #2
  %25 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 13
  %26 = load i8, i8* %25, align 1, !tbaa !6
  %27 = icmp eq i8 %26, 46
  br i1 %27, label %28, label %29

; <label>:28:                                     ; preds = %2
  store i8 32, i8* %25, align 1, !tbaa !6
  br label %29

; <label>:29:                                     ; preds = %2, %28
  %30 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 12
  %31 = load i8, i8* %30, align 1, !tbaa !6
  %32 = icmp eq i8 %31, 46
  br i1 %32, label %33, label %34

; <label>:33:                                     ; preds = %29
  store i8 32, i8* %30, align 1, !tbaa !6
  br label %34

; <label>:34:                                     ; preds = %33, %29
  %35 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 11
  %36 = load i8, i8* %35, align 1, !tbaa !6
  %37 = icmp eq i8 %36, 46
  br i1 %37, label %38, label %39

; <label>:38:                                     ; preds = %34
  store i8 32, i8* %35, align 1, !tbaa !6
  br label %39

; <label>:39:                                     ; preds = %38, %34
  %40 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 10
  %41 = load i8, i8* %40, align 1, !tbaa !6
  %42 = icmp eq i8 %41, 46
  br i1 %42, label %43, label %44

; <label>:43:                                     ; preds = %39
  store i8 32, i8* %40, align 1, !tbaa !6
  br label %44

; <label>:44:                                     ; preds = %43, %39
  %45 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 9
  %46 = load i8, i8* %45, align 1, !tbaa !6
  %47 = icmp eq i8 %46, 46
  br i1 %47, label %48, label %49

; <label>:48:                                     ; preds = %44
  store i8 32, i8* %45, align 1, !tbaa !6
  br label %49

; <label>:49:                                     ; preds = %48, %44
  %50 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 8
  %51 = load i8, i8* %50, align 1, !tbaa !6
  %52 = icmp eq i8 %51, 46
  br i1 %52, label %53, label %54

; <label>:53:                                     ; preds = %49
  store i8 32, i8* %50, align 1, !tbaa !6
  br label %54

; <label>:54:                                     ; preds = %53, %49
  %55 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 7
  %56 = load i8, i8* %55, align 1, !tbaa !6
  %57 = icmp eq i8 %56, 46
  br i1 %57, label %58, label %59

; <label>:58:                                     ; preds = %54
  store i8 32, i8* %55, align 1, !tbaa !6
  br label %59

; <label>:59:                                     ; preds = %58, %54
  %60 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 6
  %61 = load i8, i8* %60, align 1, !tbaa !6
  %62 = icmp eq i8 %61, 46
  br i1 %62, label %63, label %64

; <label>:63:                                     ; preds = %59
  store i8 32, i8* %60, align 1, !tbaa !6
  br label %64

; <label>:64:                                     ; preds = %63, %59
  %65 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 5
  %66 = load i8, i8* %65, align 1, !tbaa !6
  %67 = icmp eq i8 %66, 46
  br i1 %67, label %68, label %69

; <label>:68:                                     ; preds = %64
  store i8 32, i8* %65, align 1, !tbaa !6
  br label %69

; <label>:69:                                     ; preds = %68, %64
  %70 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 4
  %71 = load i8, i8* %70, align 1, !tbaa !6
  %72 = icmp eq i8 %71, 46
  br i1 %72, label %73, label %74

; <label>:73:                                     ; preds = %69
  store i8 32, i8* %70, align 1, !tbaa !6
  br label %74

; <label>:74:                                     ; preds = %73, %69
  %75 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 3
  %76 = load i8, i8* %75, align 1, !tbaa !6
  %77 = icmp eq i8 %76, 46
  br i1 %77, label %78, label %79

; <label>:78:                                     ; preds = %74
  store i8 32, i8* %75, align 1, !tbaa !6
  br label %79

; <label>:79:                                     ; preds = %78, %74
  %80 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 2
  %81 = load i8, i8* %80, align 1, !tbaa !6
  %82 = icmp eq i8 %81, 46
  br i1 %82, label %83, label %84

; <label>:83:                                     ; preds = %79
  store i8 32, i8* %80, align 1, !tbaa !6
  br label %84

; <label>:84:                                     ; preds = %83, %79
  %85 = getelementptr inbounds [14 x i8], [14 x i8]* %12, i64 0, i64 1
  %86 = load i8, i8* %85, align 1, !tbaa !6
  %87 = icmp eq i8 %86, 46
  br i1 %87, label %88, label %89

; <label>:88:                                     ; preds = %84
  store i8 32, i8* %85, align 1, !tbaa !6
  br label %89

; <label>:89:                                     ; preds = %88, %84
  %90 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.2, i64 0, i64 0), i8* nonnull %22)
  store i32 16384, i32* %8, align 4, !tbaa !2
  %91 = getelementptr inbounds [3 x double], [3 x double]* %7, i64 0, i64 0
  %92 = getelementptr inbounds [3 x double], [3 x double]* %7, i64 0, i64 1
  %93 = getelementptr inbounds [3 x double], [3 x double]* %7, i64 0, i64 2
  call void @vranlc(i32 0, double* nonnull %91, double 1.000000e+00, double* nonnull %93) #2
  %94 = load double, double* %93, align 16, !tbaa !7
  %95 = call double @randlc(double* nonnull %92, double %94) #2
  store double %95, double* %91, align 16, !tbaa !7
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*)) #2
  call void @timer_clear(i32 1) #2
  call void @timer_clear(i32 2) #2
  call void @timer_clear(i32 3) #2
  call void @timer_start(i32 1) #2
  call void @vranlc(i32 0, double* nonnull %3, double 0x41D2309CE5400000, double* getelementptr inbounds ([131072 x double], [131072 x double]* @x, i64 0, i64 0)) #2
  store double 0x41D2309CE5400000, double* %3, align 8, !tbaa !7
  %96 = call double @randlc(double* nonnull %3, double 0x41D2309CE5400000) #2
  %97 = load double, double* %3, align 8, !tbaa !7
  %98 = call double @randlc(double* nonnull %3, double %97) #2
  %99 = load double, double* %3, align 8, !tbaa !7
  %100 = call double @randlc(double* nonnull %3, double %99) #2
  %101 = load double, double* %3, align 8, !tbaa !7
  %102 = call double @randlc(double* nonnull %3, double %101) #2
  %103 = load double, double* %3, align 8, !tbaa !7
  %104 = call double @randlc(double* nonnull %3, double %103) #2
  %105 = load double, double* %3, align 8, !tbaa !7
  %106 = call double @randlc(double* nonnull %3, double %105) #2
  %107 = load double, double* %3, align 8, !tbaa !7
  %108 = call double @randlc(double* nonnull %3, double %107) #2
  %109 = load double, double* %3, align 8, !tbaa !7
  %110 = call double @randlc(double* nonnull %3, double %109) #2
  %111 = load double, double* %3, align 8, !tbaa !7
  %112 = call double @randlc(double* nonnull %3, double %111) #2
  %113 = load double, double* %3, align 8, !tbaa !7
  %114 = call double @randlc(double* nonnull %3, double %113) #2
  %115 = load double, double* %3, align 8, !tbaa !7
  %116 = call double @randlc(double* nonnull %3, double %115) #2
  %117 = load double, double* %3, align 8, !tbaa !7
  %118 = call double @randlc(double* nonnull %3, double %117) #2
  %119 = load double, double* %3, align 8, !tbaa !7
  %120 = call double @randlc(double* nonnull %3, double %119) #2
  %121 = load double, double* %3, align 8, !tbaa !7
  %122 = call double @randlc(double* nonnull %3, double %121) #2
  %123 = load double, double* %3, align 8, !tbaa !7
  %124 = call double @randlc(double* nonnull %3, double %123) #2
  %125 = load double, double* %3, align 8, !tbaa !7
  %126 = call double @randlc(double* nonnull %3, double %125) #2
  %127 = load double, double* %3, align 8, !tbaa !7
  %128 = call double @randlc(double* nonnull %3, double %127) #2
  %129 = bitcast double* %3 to i64*
  %130 = load i64, i64* %129, align 8, !tbaa !7
  %131 = bitcast double* %6 to i64*
  store i64 %130, i64* %131, align 8, !tbaa !7
  store double 0.000000e+00, double* %4, align 8, !tbaa !7
  store double 0.000000e+00, double* %5, align 8, !tbaa !7
  call void @llvm.memset.p0i8.i64(i8* bitcast ([10 x double]* @q to i8*), i8 0, i64 80, i32 16, i1 false)
  store i32 -1, i32* %10, align 4, !tbaa !2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 8, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, double*, double*, i32*, i32*, i32*, double*, i32*, [131072 x double]*)* @.omp_outlined..4 to void (i32*, i32*, ...)*), double* nonnull %4, double* nonnull %5, i32* nonnull %9, i32* nonnull %8, i32* nonnull %10, double* nonnull %6, i32* nonnull %11, [131072 x double]* nonnull @x) #2
  call void @timer_stop(i32 1) #2
  %132 = call double @timer_read(i32 1) #2
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %22) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %21) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %20) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %19) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %18) #2
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %17) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %16) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %14) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %13) #2
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #2

; Function Attrs: nounwind
declare i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly, i32* noalias nocapture readnone) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #2
  store i32 0, i32* %3, align 4, !tbaa !2
  %8 = bitcast i32* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %8) #2
  store i32 131071, i32* %4, align 4, !tbaa !2
  %9 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %9) #2
  store i32 1, i32* %5, align 4, !tbaa !2
  %10 = bitcast i32* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %10) #2
  store i32 0, i32* %6, align 4, !tbaa !2
  %11 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @2, i32 %11, i32 34, i32* nonnull %6, i32* nonnull %3, i32* nonnull %4, i32* nonnull %5, i32 1, i32 1) #2
  %12 = load i32, i32* %4, align 4, !tbaa !2
  %13 = icmp slt i32 %12, 131071
  %14 = select i1 %13, i32 %12, i32 131071
  store i32 %14, i32* %4, align 4, !tbaa !2
  %15 = load i32, i32* %3, align 4, !tbaa !2
  %16 = icmp sgt i32 %15, %14
  br i1 %16, label %88, label %17

; <label>:17:                                     ; preds = %2
  %18 = sext i32 %15 to i64
  %19 = sext i32 %14 to i64
  %20 = icmp sgt i64 %19, %18
  %21 = select i1 %20, i64 %19, i64 %18
  %22 = add nsw i64 %21, 1
  %23 = sub nsw i64 %22, %18
  %24 = icmp ult i64 %23, 4
  br i1 %24, label %81, label %25

; <label>:25:                                     ; preds = %17
  %26 = and i64 %23, -4
  %27 = add nsw i64 %26, %18
  %28 = add nsw i64 %26, -4
  %29 = lshr exact i64 %28, 2
  %30 = add nuw nsw i64 %29, 1
  %31 = and i64 %30, 3
  %32 = icmp ult i64 %28, 12
  br i1 %32, label %64, label %33

; <label>:33:                                     ; preds = %25
  %34 = sub nsw i64 %30, %31
  br label %35

; <label>:35:                                     ; preds = %35, %33
  %36 = phi i64 [ 0, %33 ], [ %61, %35 ]
  %37 = phi i64 [ %34, %33 ], [ %62, %35 ]
  %38 = add i64 %36, %18
  %39 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %38
  %40 = bitcast double* %39 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %40, align 8, !tbaa !7
  %41 = getelementptr double, double* %39, i64 2
  %42 = bitcast double* %41 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %42, align 8, !tbaa !7
  %43 = or i64 %36, 4
  %44 = add i64 %43, %18
  %45 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %44
  %46 = bitcast double* %45 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %46, align 8, !tbaa !7
  %47 = getelementptr double, double* %45, i64 2
  %48 = bitcast double* %47 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %48, align 8, !tbaa !7
  %49 = or i64 %36, 8
  %50 = add i64 %49, %18
  %51 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %50
  %52 = bitcast double* %51 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %52, align 8, !tbaa !7
  %53 = getelementptr double, double* %51, i64 2
  %54 = bitcast double* %53 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %54, align 8, !tbaa !7
  %55 = or i64 %36, 12
  %56 = add i64 %55, %18
  %57 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %56
  %58 = bitcast double* %57 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %58, align 8, !tbaa !7
  %59 = getelementptr double, double* %57, i64 2
  %60 = bitcast double* %59 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %60, align 8, !tbaa !7
  %61 = add i64 %36, 16
  %62 = add i64 %37, -4
  %63 = icmp eq i64 %62, 0
  br i1 %63, label %64, label %35, !llvm.loop !9

; <label>:64:                                     ; preds = %35, %25
  %65 = phi i64 [ 0, %25 ], [ %61, %35 ]
  %66 = icmp eq i64 %31, 0
  br i1 %66, label %79, label %67

; <label>:67:                                     ; preds = %64
  br label %68

; <label>:68:                                     ; preds = %68, %67
  %69 = phi i64 [ %65, %67 ], [ %76, %68 ]
  %70 = phi i64 [ %31, %67 ], [ %77, %68 ]
  %71 = add i64 %69, %18
  %72 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %71
  %73 = bitcast double* %72 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %73, align 8, !tbaa !7
  %74 = getelementptr double, double* %72, i64 2
  %75 = bitcast double* %74 to <2 x double>*
  store <2 x double> <double 0xD47D42AEA2879F2E, double 0xD47D42AEA2879F2E>, <2 x double>* %75, align 8, !tbaa !7
  %76 = add i64 %69, 4
  %77 = add i64 %70, -1
  %78 = icmp eq i64 %77, 0
  br i1 %78, label %79, label %68, !llvm.loop !11

; <label>:79:                                     ; preds = %68, %64
  %80 = icmp eq i64 %23, %26
  br i1 %80, label %88, label %81

; <label>:81:                                     ; preds = %79, %17
  %82 = phi i64 [ %18, %17 ], [ %27, %79 ]
  br label %83

; <label>:83:                                     ; preds = %81, %83
  %84 = phi i64 [ %86, %83 ], [ %82, %81 ]
  %85 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %84
  store double 0xD47D42AEA2879F2E, double* %85, align 8, !tbaa !7
  %86 = add nsw i64 %84, 1
  %87 = icmp slt i64 %84, %19
  br i1 %87, label %83, label %88, !llvm.loop !13

; <label>:88:                                     ; preds = %83, %79, %2
  call void @__kmpc_for_static_fini(%ident_t* nonnull @2, i32 %11) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %10) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %9) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %8) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #2
  ret void
}

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined..4(i32* noalias nocapture readonly, i32* noalias nocapture readnone, double* nocapture dereferenceable(8), double* nocapture dereferenceable(8), i32* nocapture readnone dereferenceable(4), i32* nocapture readonly dereferenceable(4), i32* nocapture readonly dereferenceable(4), double* nocapture readonly dereferenceable(8), i32* nocapture dereferenceable(4), [131072 x double]* readonly dereferenceable(1048576)) #0 {
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca [10 x double], align 16
  %14 = bitcast [10 x double]* %13 to i8*
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca double, align 8
  %20 = alloca double, align 8
  %21 = alloca [2 x i8*], align 8
  %22 = icmp eq [131072 x double]* %9, @x
  br i1 %22, label %25, label %23

; <label>:23:                                     ; preds = %10
  %24 = bitcast [131072 x double]* %9 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast ([131072 x double]* @x to i8*), i8* nonnull %24, i64 1048576, i32 16, i1 false), !tbaa.struct !15
  br label %25

; <label>:25:                                     ; preds = %10, %23
  %26 = load i32, i32* %0, align 4, !tbaa !2
  tail call void @__kmpc_barrier(%ident_t* nonnull @1, i32 %26) #2
  %27 = bitcast double* %11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #2
  %28 = bitcast double* %12 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %28) #2
  call void @llvm.lifetime.start.p0i8(i64 80, i8* nonnull %14) #2
  call void @llvm.memset.p0i8.i64(i8* nonnull %14, i8 0, i64 80, i32 16, i1 false)
  %29 = load i32, i32* %5, align 4, !tbaa !2
  %30 = add nsw i32 %29, -1
  %31 = icmp sgt i32 %29, 0
  br i1 %31, label %37, label %32

; <label>:32:                                     ; preds = %25
  %33 = bitcast i32* %18 to i8*
  %34 = bitcast i32* %17 to i8*
  %35 = bitcast i32* %16 to i8*
  %36 = bitcast i32* %15 to i8*
  br label %172

; <label>:37:                                     ; preds = %25
  %38 = bitcast i32* %15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %38) #2
  store i32 0, i32* %15, align 4, !tbaa !2
  %39 = bitcast i32* %16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %39) #2
  store i32 %30, i32* %16, align 4, !tbaa !2
  %40 = bitcast i32* %17 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %40) #2
  store i32 1, i32* %17, align 4, !tbaa !2
  %41 = bitcast i32* %18 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %41) #2
  store i32 0, i32* %18, align 4, !tbaa !2
  %42 = bitcast double* %19 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %42) #2
  store double 0.000000e+00, double* %19, align 8, !tbaa !7
  %43 = bitcast double* %20 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %43) #2
  store double 0.000000e+00, double* %20, align 8, !tbaa !7
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @2, i32 %26, i32 34, i32* nonnull %18, i32* nonnull %15, i32* nonnull %16, i32* nonnull %17, i32 1, i32 1) #2
  %44 = load i32, i32* %16, align 4, !tbaa !2
  %45 = icmp sgt i32 %44, %30
  %46 = select i1 %45, i32 %30, i32 %44
  store i32 %46, i32* %16, align 4, !tbaa !2
  %47 = load i32, i32* %15, align 4, !tbaa !2
  %48 = icmp sgt i32 %47, %46
  br i1 %48, label %120, label %49

; <label>:49:                                     ; preds = %37
  %50 = bitcast double* %7 to i64*
  %51 = bitcast double* %12 to i64*
  br label %52

; <label>:52:                                     ; preds = %117, %49
  %53 = phi i32 [ %47, %49 ], [ %54, %117 ]
  %54 = add nsw i32 %53, 1
  %55 = load i32, i32* %6, align 4, !tbaa !2
  %56 = add nsw i32 %55, %54
  store double 0x41B033C4D7000000, double* %11, align 8, !tbaa !7
  %57 = load i64, i64* %50, align 8, !tbaa !7
  store i64 %57, i64* %51, align 8, !tbaa !7
  br label %58

; <label>:58:                                     ; preds = %52, %70
  %59 = phi i32 [ %56, %52 ], [ %61, %70 ]
  %60 = phi i32 [ 1, %52 ], [ %73, %70 ]
  %61 = sdiv i32 %59, 2
  %62 = shl nsw i32 %61, 1
  %63 = icmp eq i32 %62, %59
  br i1 %63, label %67, label %64

; <label>:64:                                     ; preds = %58
  %65 = load double, double* %12, align 8, !tbaa !7
  %66 = call double @randlc(double* nonnull %11, double %65) #2
  br label %67

; <label>:67:                                     ; preds = %58, %64
  %68 = add i32 %59, 1
  %69 = icmp ult i32 %68, 3
  br i1 %69, label %75, label %70

; <label>:70:                                     ; preds = %67
  %71 = load double, double* %12, align 8, !tbaa !7
  %72 = call double @randlc(double* nonnull %12, double %71) #2
  %73 = add nuw nsw i32 %60, 1
  %74 = icmp ult i32 %73, 101
  br i1 %74, label %58, label %75

; <label>:75:                                     ; preds = %67, %70
  call void @vranlc(i32 131072, double* nonnull %11, double 0x41D2309CE5400000, double* getelementptr ([131072 x double], [131072 x double]* @x, i64 0, i64 -1)) #2
  br label %76

; <label>:76:                                     ; preds = %114, %75
  %77 = phi i64 [ 0, %75 ], [ %115, %114 ]
  %78 = shl nuw nsw i64 %77, 1
  %79 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %78
  %80 = bitcast double* %79 to <2 x double>*
  %81 = load <2 x double>, <2 x double>* %80, align 16, !tbaa !7
  %82 = fmul <2 x double> %81, <double 2.000000e+00, double 2.000000e+00>
  %83 = fadd <2 x double> %82, <double -1.000000e+00, double -1.000000e+00>
  %84 = fmul <2 x double> %83, %83
  %85 = extractelement <2 x double> %84, i32 0
  %86 = extractelement <2 x double> %84, i32 1
  %87 = fadd double %85, %86
  store double %87, double* %11, align 8, !tbaa !7
  %88 = fcmp ugt double %87, 1.000000e+00
  br i1 %88, label %114, label %89

; <label>:89:                                     ; preds = %76
  %90 = call double @log(double %87) #2
  %91 = fmul double %90, -2.000000e+00
  %92 = load double, double* %11, align 8, !tbaa !7
  %93 = fdiv double %91, %92
  %94 = call double @sqrt(double %93) #2
  store double %94, double* %12, align 8, !tbaa !7
  %95 = insertelement <2 x double> undef, double %94, i32 0
  %96 = shufflevector <2 x double> %95, <2 x double> undef, <2 x i32> zeroinitializer
  %97 = fmul <2 x double> %83, %96
  %98 = call <2 x double> @llvm.fabs.v2f64(<2 x double> %97)
  %99 = extractelement <2 x double> %98, i32 0
  %100 = extractelement <2 x double> %98, i32 1
  %101 = fcmp ogt double %99, %100
  %102 = select i1 %101, double %99, double %100
  %103 = fptosi double %102 to i32
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 %104
  %106 = load double, double* %105, align 8, !tbaa !7
  %107 = fadd double %106, 1.000000e+00
  store double %107, double* %105, align 8, !tbaa !7
  %108 = load double, double* %19, align 8, !tbaa !7
  %109 = extractelement <2 x double> %97, i32 0
  %110 = fadd double %109, %108
  store double %110, double* %19, align 8, !tbaa !7
  %111 = load double, double* %20, align 8, !tbaa !7
  %112 = extractelement <2 x double> %97, i32 1
  %113 = fadd double %112, %111
  store double %113, double* %20, align 8, !tbaa !7
  br label %114

; <label>:114:                                    ; preds = %76, %89
  %115 = add nuw nsw i64 %77, 1
  %116 = icmp eq i64 %115, 65536
  br i1 %116, label %117, label %76

; <label>:117:                                    ; preds = %114
  %118 = load i32, i32* %16, align 4, !tbaa !2
  %119 = icmp slt i32 %53, %118
  br i1 %119, label %52, label %120

; <label>:120:                                    ; preds = %117, %37
  call void @__kmpc_for_static_fini(%ident_t* nonnull @2, i32 %26) #2
  %121 = bitcast [2 x i8*]* %21 to double**
  store double* %19, double** %121, align 8
  %122 = getelementptr inbounds [2 x i8*], [2 x i8*]* %21, i64 0, i64 1
  %123 = bitcast i8** %122 to double**
  store double* %20, double** %123, align 8
  %124 = bitcast [2 x i8*]* %21 to i8*
  %125 = call i32 @__kmpc_reduce(%ident_t* nonnull @3, i32 %26, i32 2, i64 16, i8* nonnull %124, void (i8*, i8*)* nonnull @.omp.reduction.reduction_func, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  switch i32 %125, label %158 [
    i32 1, label %126
    i32 2, label %133
  ]

; <label>:126:                                    ; preds = %120
  %127 = load double, double* %2, align 8, !tbaa !7
  %128 = load double, double* %19, align 8, !tbaa !7
  %129 = fadd double %127, %128
  store double %129, double* %2, align 8, !tbaa !7
  %130 = load double, double* %3, align 8, !tbaa !7
  %131 = load double, double* %20, align 8, !tbaa !7
  %132 = fadd double %130, %131
  store double %132, double* %3, align 8, !tbaa !7
  call void @__kmpc_end_reduce(%ident_t* nonnull @3, i32 %26, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  br label %158

; <label>:133:                                    ; preds = %120
  %134 = bitcast double* %2 to i64*
  %135 = load atomic i64, i64* %134 monotonic, align 8, !tbaa !7
  %136 = load double, double* %19, align 8, !tbaa !7
  br label %137

; <label>:137:                                    ; preds = %137, %133
  %138 = phi i64 [ %135, %133 ], [ %143, %137 ]
  %139 = bitcast i64 %138 to double
  %140 = fadd double %136, %139
  %141 = bitcast double %140 to i64
  %142 = cmpxchg i64* %134, i64 %138, i64 %141 monotonic monotonic
  %143 = extractvalue { i64, i1 } %142, 0
  %144 = extractvalue { i64, i1 } %142, 1
  br i1 %144, label %145, label %137

; <label>:145:                                    ; preds = %137
  %146 = bitcast double* %3 to i64*
  %147 = load atomic i64, i64* %146 monotonic, align 8, !tbaa !7
  %148 = load double, double* %20, align 8, !tbaa !7
  br label %149

; <label>:149:                                    ; preds = %149, %145
  %150 = phi i64 [ %147, %145 ], [ %155, %149 ]
  %151 = bitcast i64 %150 to double
  %152 = fadd double %148, %151
  %153 = bitcast double %152 to i64
  %154 = cmpxchg i64* %146, i64 %150, i64 %153 monotonic monotonic
  %155 = extractvalue { i64, i1 } %154, 0
  %156 = extractvalue { i64, i1 } %154, 1
  br i1 %156, label %157, label %149

; <label>:157:                                    ; preds = %149
  call void @__kmpc_end_reduce(%ident_t* nonnull @3, i32 %26, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  br label %158

; <label>:158:                                    ; preds = %157, %126, %120
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %43) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %42) #2
  %159 = bitcast [10 x double]* %13 to <2 x double>*
  %160 = load <2 x double>, <2 x double>* %159, align 16, !tbaa !7
  %161 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 2
  %162 = bitcast double* %161 to <2 x double>*
  %163 = load <2 x double>, <2 x double>* %162, align 16, !tbaa !7
  %164 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 4
  %165 = bitcast double* %164 to <2 x double>*
  %166 = load <2 x double>, <2 x double>* %165, align 16, !tbaa !7
  %167 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 6
  %168 = bitcast double* %167 to <2 x double>*
  %169 = load <2 x double>, <2 x double>* %168, align 16, !tbaa !7
  %170 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 8
  %171 = load double, double* %170, align 16, !tbaa !7
  br label %172

; <label>:172:                                    ; preds = %32, %158
  %173 = phi i8* [ %36, %32 ], [ %38, %158 ]
  %174 = phi i8* [ %35, %32 ], [ %39, %158 ]
  %175 = phi i8* [ %34, %32 ], [ %40, %158 ]
  %176 = phi i8* [ %33, %32 ], [ %41, %158 ]
  %177 = phi double [ 0.000000e+00, %32 ], [ %171, %158 ]
  %178 = phi <2 x double> [ zeroinitializer, %32 ], [ %160, %158 ]
  %179 = phi <2 x double> [ zeroinitializer, %32 ], [ %163, %158 ]
  %180 = phi <2 x double> [ zeroinitializer, %32 ], [ %166, %158 ]
  %181 = phi <2 x double> [ zeroinitializer, %32 ], [ %169, %158 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %176) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %175) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %174) #2
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %173) #2
  call void @__kmpc_barrier(%ident_t* nonnull @1, i32 %26) #2
  call void @__kmpc_critical(%ident_t* nonnull @0, i32 %26, [8 x i32]* nonnull @.gomp_critical_user_.var) #2
  %182 = load <2 x double>, <2 x double>* bitcast ([10 x double]* @q to <2 x double>*), align 16, !tbaa !7
  %183 = fadd <2 x double> %178, %182
  store <2 x double> %183, <2 x double>* bitcast ([10 x double]* @q to <2 x double>*), align 16, !tbaa !7
  %184 = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 2) to <2 x double>*), align 16, !tbaa !7
  %185 = fadd <2 x double> %179, %184
  store <2 x double> %185, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 2) to <2 x double>*), align 16, !tbaa !7
  %186 = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 4) to <2 x double>*), align 16, !tbaa !7
  %187 = fadd <2 x double> %180, %186
  store <2 x double> %187, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 4) to <2 x double>*), align 16, !tbaa !7
  %188 = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 6) to <2 x double>*), align 16, !tbaa !7
  %189 = fadd <2 x double> %181, %188
  store <2 x double> %189, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 6) to <2 x double>*), align 16, !tbaa !7
  %190 = getelementptr inbounds [10 x double], [10 x double]* %13, i64 0, i64 9
  %191 = load double, double* %190, align 8, !tbaa !7
  %192 = load <2 x double>, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 8) to <2 x double>*), align 16, !tbaa !7
  %193 = insertelement <2 x double> undef, double %177, i32 0
  %194 = insertelement <2 x double> %193, double %191, i32 1
  %195 = fadd <2 x double> %194, %192
  store <2 x double> %195, <2 x double>* bitcast (double* getelementptr inbounds ([10 x double], [10 x double]* @q, i64 0, i64 8) to <2 x double>*), align 16, !tbaa !7
  call void @__kmpc_end_critical(%ident_t* nonnull @0, i32 %26, [8 x i32]* nonnull @.gomp_critical_user_.var) #2
  %196 = call i32 @__kmpc_master(%ident_t* nonnull @0, i32 %26) #2
  %197 = icmp eq i32 %196, 0
  br i1 %197, label %200, label %198

; <label>:198:                                    ; preds = %172
  %199 = call i32 @omp_get_num_threads() #2
  store i32 %199, i32* %8, align 4, !tbaa !2
  call void @__kmpc_end_master(%ident_t* nonnull @0, i32 %26) #2
  br label %200

; <label>:200:                                    ; preds = %172, %198
  call void @llvm.lifetime.end.p0i8(i64 80, i8* nonnull %14) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %28) #2
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

declare void @__kmpc_barrier(%ident_t*, i32) local_unnamed_addr

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

; Function Attrs: nounwind
declare double @log(double) local_unnamed_addr #3

; Function Attrs: nounwind
declare double @sqrt(double) local_unnamed_addr #3

; Function Attrs: nounwind readnone speculatable
declare <2 x double> @llvm.fabs.v2f64(<2 x double>) #4

declare void @__kmpc_for_static_fini(%ident_t*, i32) local_unnamed_addr

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp.reduction.reduction_func(i8* nocapture readonly, i8* nocapture readonly) #5 {
  %3 = bitcast i8* %1 to double**
  %4 = load double*, double** %3, align 8
  %5 = bitcast i8* %0 to double**
  %6 = load double*, double** %5, align 8
  %7 = getelementptr inbounds i8, i8* %1, i64 8
  %8 = bitcast i8* %7 to double**
  %9 = load double*, double** %8, align 8
  %10 = getelementptr inbounds i8, i8* %0, i64 8
  %11 = bitcast i8* %10 to double**
  %12 = load double*, double** %11, align 8
  %13 = load double, double* %6, align 8, !tbaa !7
  %14 = load double, double* %4, align 8, !tbaa !7
  %15 = fadd double %13, %14
  store double %15, double* %6, align 8, !tbaa !7
  %16 = load double, double* %12, align 8, !tbaa !7
  %17 = load double, double* %9, align 8, !tbaa !7
  %18 = fadd double %16, %17
  store double %18, double* %12, align 8, !tbaa !7
  ret void
}

declare i32 @__kmpc_reduce(%ident_t*, i32, i32, i64, i8*, void (i8*, i8*)*, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_reduce(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_critical(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_critical(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare i32 @__kmpc_master(%ident_t*, i32) local_unnamed_addr

declare i32 @omp_get_num_threads() local_unnamed_addr #6

declare void @__kmpc_end_master(%ident_t*, i32) local_unnamed_addr

; Function Attrs: nounwind uwtable
define void @c_print_results(i8*, i8 signext, i32, i32, i32, i32, i32, double, double, i8*, i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*) local_unnamed_addr #0 {
  %21 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1.1, i64 0, i64 0), i8* %0)
  %22 = sext i8 %1 to i32
  %23 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.2.2, i64 0, i64 0), i32 %22)
  %24 = or i32 %4, %3
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %28

; <label>:26:                                     ; preds = %20
  %27 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.3.3, i64 0, i64 0), i32 %2)
  br label %30

; <label>:28:                                     ; preds = %20
  %29 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.4, i64 0, i64 0), i32 %2, i32 %3, i32 %4)
  br label %30

; <label>:30:                                     ; preds = %28, %26
  %31 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 %5)
  %32 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.6, i64 0, i64 0), i32 %6)
  %33 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.7, i64 0, i64 0), double %7)
  %34 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.8, i64 0, i64 0), double %8)
  %35 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.9, i64 0, i64 0), i8* %9)
  %36 = icmp eq i32 %10, 0
  br i1 %36, label %39, label %37

; <label>:37:                                     ; preds = %30
  %38 = tail call i32 @puts(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @str.23, i64 0, i64 0))
  br label %41

; <label>:39:                                     ; preds = %30
  %40 = tail call i32 @puts(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @str.4, i64 0, i64 0))
  br label %41

; <label>:41:                                     ; preds = %39, %37
  %42 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.12, i64 0, i64 0), i8* %11)
  %43 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.13, i64 0, i64 0), i8* %12)
  %44 = tail call i32 @puts(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @str.22, i64 0, i64 0))
  %45 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.15, i64 0, i64 0), i8* %13)
  %46 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.16, i64 0, i64 0), i8* %14)
  %47 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.17, i64 0, i64 0), i8* %15)
  %48 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.18, i64 0, i64 0), i8* %16)
  %49 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.19, i64 0, i64 0), i8* %17)
  %50 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.20, i64 0, i64 0), i8* %18)
  %51 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.21, i64 0, i64 0), i8* %19)
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define double @randlc(double* nocapture, double) local_unnamed_addr #5 {
  %3 = fmul double %1, 0x3E80000000000000
  %4 = fptosi double %3 to i32
  %5 = sitofp i32 %4 to double
  %6 = fmul double %5, 0x4160000000000000
  %7 = fsub double %1, %6
  %8 = load double, double* %0, align 8, !tbaa !7
  %9 = fmul double %8, 0x3E80000000000000
  %10 = fptosi double %9 to i32
  %11 = sitofp i32 %10 to double
  %12 = fmul double %11, 0x4160000000000000
  %13 = fsub double %8, %12
  %14 = fmul double %13, %5
  %15 = fmul double %7, %11
  %16 = fadd double %15, %14
  %17 = fmul double %16, 0x3E80000000000000
  %18 = fptosi double %17 to i32
  %19 = sitofp i32 %18 to double
  %20 = fmul double %19, 0x4160000000000000
  %21 = fsub double %16, %20
  %22 = fmul double %21, 0x4160000000000000
  %23 = fmul double %7, %13
  %24 = fadd double %23, %22
  %25 = fmul double %24, 0x3D10000000000000
  %26 = fptosi double %25 to i32
  %27 = sitofp i32 %26 to double
  %28 = fmul double %27, 0x42D0000000000000
  %29 = fsub double %24, %28
  store double %29, double* %0, align 8, !tbaa !7
  %30 = fmul double %29, 0x3D10000000000000
  ret double %30
}

; Function Attrs: norecurse nounwind uwtable
define void @vranlc(i32, double* nocapture, double, double* nocapture) local_unnamed_addr #5 {
  %5 = fmul double %2, 0x3E80000000000000
  %6 = fptosi double %5 to i32
  %7 = sitofp i32 %6 to double
  %8 = fmul double %7, 0x4160000000000000
  %9 = fsub double %2, %8
  %10 = load double, double* %1, align 8, !tbaa !7
  %11 = icmp slt i32 %0, 1
  br i1 %11, label %43, label %12

; <label>:12:                                     ; preds = %4
  %13 = add i32 %0, 1
  %14 = zext i32 %13 to i64
  br label %15

; <label>:15:                                     ; preds = %15, %12
  %16 = phi i64 [ %41, %15 ], [ 1, %12 ]
  %17 = phi double [ %38, %15 ], [ %10, %12 ]
  %18 = fmul double %17, 0x3E80000000000000
  %19 = fptosi double %18 to i32
  %20 = sitofp i32 %19 to double
  %21 = fmul double %20, 0x4160000000000000
  %22 = fsub double %17, %21
  %23 = fmul double %22, %7
  %24 = fmul double %9, %20
  %25 = fadd double %24, %23
  %26 = fmul double %25, 0x3E80000000000000
  %27 = fptosi double %26 to i32
  %28 = sitofp i32 %27 to double
  %29 = fmul double %28, 0x4160000000000000
  %30 = fsub double %25, %29
  %31 = fmul double %30, 0x4160000000000000
  %32 = fmul double %9, %22
  %33 = fadd double %32, %31
  %34 = fmul double %33, 0x3D10000000000000
  %35 = fptosi double %34 to i32
  %36 = sitofp i32 %35 to double
  %37 = fmul double %36, 0x42D0000000000000
  %38 = fsub double %33, %37
  %39 = fmul double %38, 0x3D10000000000000
  %40 = getelementptr inbounds double, double* %3, i64 %16
  store double %39, double* %40, align 8, !tbaa !7
  %41 = add nuw nsw i64 %16, 1
  %42 = icmp eq i64 %41, %14
  br i1 %42, label %43, label %15

; <label>:43:                                     ; preds = %15, %4
  %44 = phi double [ %10, %4 ], [ %38, %15 ]
  store double %44, double* %1, align 8, !tbaa !7
  ret void
}

; Function Attrs: nounwind uwtable
define double @elapsed_time() local_unnamed_addr #0 {
  %1 = alloca double, align 8
  %2 = bitcast double* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2) #2
  call void @wtime_(double* nonnull %1) #2
  %3 = load double, double* %1, align 8, !tbaa !7
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #2
  ret double %3
}

; Function Attrs: norecurse nounwind uwtable
define void @timer_clear(i32) local_unnamed_addr #5 {
  %2 = sext i32 %0 to i64
  %3 = getelementptr inbounds [64 x double], [64 x double]* @elapsed, i64 0, i64 %2
  store double 0.000000e+00, double* %3, align 8, !tbaa !7
  ret void
}

; Function Attrs: nounwind uwtable
define void @timer_start(i32) local_unnamed_addr #0 {
  %2 = alloca double, align 8
  %3 = bitcast double* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #2
  call void @wtime_(double* nonnull %2) #2
  %4 = bitcast double* %2 to i64*
  %5 = load i64, i64* %4, align 8, !tbaa !7
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #2
  %6 = sext i32 %0 to i64
  %7 = getelementptr inbounds [64 x double], [64 x double]* @start, i64 0, i64 %6
  %8 = bitcast double* %7 to i64*
  store i64 %5, i64* %8, align 8, !tbaa !7
  ret void
}

; Function Attrs: nounwind uwtable
define void @timer_stop(i32) local_unnamed_addr #0 {
  %2 = alloca double, align 8
  %3 = bitcast double* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #2
  call void @wtime_(double* nonnull %2) #2
  %4 = load double, double* %2, align 8, !tbaa !7
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #2
  %5 = sext i32 %0 to i64
  %6 = getelementptr inbounds [64 x double], [64 x double]* @start, i64 0, i64 %5
  %7 = load double, double* %6, align 8, !tbaa !7
  %8 = fsub double %4, %7
  %9 = getelementptr inbounds [64 x double], [64 x double]* @elapsed, i64 0, i64 %5
  %10 = load double, double* %9, align 8, !tbaa !7
  %11 = fadd double %10, %8
  store double %11, double* %9, align 8, !tbaa !7
  ret void
}

; Function Attrs: norecurse nounwind readonly uwtable
define double @timer_read(i32) local_unnamed_addr #7 {
  %2 = sext i32 %0 to i64
  %3 = getelementptr inbounds [64 x double], [64 x double]* @elapsed, i64 0, i64 %2
  %4 = load double, double* %3, align 8, !tbaa !7
  ret double %4
}

; Function Attrs: nounwind uwtable
define void @wtime_(double* nocapture) local_unnamed_addr #0 {
  %2 = alloca %struct.timeval, align 8
  %3 = bitcast %struct.timeval* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3) #2
  %4 = call i32 @gettimeofday(%struct.timeval* nonnull %2, %struct.timezone* null) #2
  %5 = load i32, i32* @wtime_.sec, align 4, !tbaa !2
  %6 = icmp slt i32 %5, 0
  %7 = getelementptr inbounds %struct.timeval, %struct.timeval* %2, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !16
  br i1 %6, label %9, label %11

; <label>:9:                                      ; preds = %1
  %10 = trunc i64 %8 to i32
  store i32 %10, i32* @wtime_.sec, align 4, !tbaa !2
  br label %11

; <label>:11:                                     ; preds = %1, %9
  %12 = phi i32 [ %10, %9 ], [ %5, %1 ]
  %13 = sext i32 %12 to i64
  %14 = sub nsw i64 %8, %13
  %15 = sitofp i64 %14 to double
  %16 = getelementptr inbounds %struct.timeval, %struct.timeval* %2, i64 0, i32 1
  %17 = load i64, i64* %16, align 8, !tbaa !19
  %18 = sitofp i64 %17 to double
  %19 = fmul double %18, 0x3EB0C6F7A0B5ED8D
  %20 = fadd double %19, %15
  store double %20, double* %0, align 8, !tbaa !7
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval* nocapture, %struct.timezone* nocapture) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone speculatable }
attributes #5 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { norecurse nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0, !0, !0, !0, !0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 6.0.0-1ubuntu2~16.04.1 (tags/RELEASE_600/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!4, !4, i64 0}
!7 = !{!8, !8, i64 0}
!8 = !{!"double", !4, i64 0}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !14, !10}
!14 = !{!"llvm.loop.unroll.runtime.disable"}
!15 = !{i64 0, i64 1048576, !6}
!16 = !{!17, !18, i64 0}
!17 = !{!"timeval", !18, i64 0, !18, i64 8}
!18 = !{!"long", !4, i64 0}
!19 = !{!17, !18, i64 8}
