; ModuleID = 'ep.B.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"hello world\0A\00", align 1


%ident_t = type { i32, i32, i32, i32, i8* }

@.gomp_critical_user_.reduction.var = common global [8 x i32] zeroinitializer
@.gomp_critical_user_.var = common global [8 x i32] zeroinitializer
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@x = internal thread_local global [131072 x double] zeroinitializer, align 16
@1 = private unnamed_addr constant %ident_t { i32 0, i32 66, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant %ident_t { i32 0, i32 18, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0) }, align 8
@.str.3 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@elapsed = common local_unnamed_addr global [64 x double] zeroinitializer, align 16
@start = common local_unnamed_addr global [64 x double] zeroinitializer, align 16
@wtime_.sec = internal unnamed_addr global i32 -1, align 4

; Function Attrs: nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca [3 x double], align 16
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca [14 x i8], align 1
  store i32 1, i32* %9, align 4, !tbaa !2
  %11 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 13
  %12 = load i8, i8* %11, align 1, !tbaa !6
  %13 = icmp eq i8 %12, 46
  br i1 %13, label %14, label %15

; <label>:14:                                     ; preds = %2
  br label %15

; <label>:15:                                     ; preds = %14, %2
  %16 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 12
  %17 = load i8, i8* %16, align 1, !tbaa !6
  %18 = icmp eq i8 %17, 46
  br i1 %18, label %19, label %20

; <label>:19:                                     ; preds = %15
  br label %20

; <label>:20:                                     ; preds = %19, %15
  %21 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 11
  %22 = load i8, i8* %21, align 1, !tbaa !6
  %23 = icmp eq i8 %22, 46
  br i1 %23, label %24, label %25

; <label>:24:                                     ; preds = %20
  br label %25

; <label>:25:                                     ; preds = %24, %20
  %26 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 10
  %27 = load i8, i8* %26, align 1, !tbaa !6
  %28 = icmp eq i8 %27, 46
  br i1 %28, label %29, label %30

; <label>:29:                                     ; preds = %25
  br label %30

; <label>:30:                                     ; preds = %29, %25
  %31 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 9
  %32 = load i8, i8* %31, align 1, !tbaa !6
  %33 = icmp eq i8 %32, 46
  br i1 %33, label %34, label %35

; <label>:34:                                     ; preds = %30
  br label %35

; <label>:35:                                     ; preds = %34, %30
  %36 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 8
  %37 = load i8, i8* %36, align 1, !tbaa !6
  %38 = icmp eq i8 %37, 46
  br i1 %38, label %39, label %40

; <label>:39:                                     ; preds = %35
  br label %40

; <label>:40:                                     ; preds = %39, %35
  %41 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 7
  %42 = load i8, i8* %41, align 1, !tbaa !6
  %43 = icmp eq i8 %42, 46
  br i1 %43, label %44, label %45

; <label>:44:                                     ; preds = %40
  br label %45

; <label>:45:                                     ; preds = %44, %40
  %46 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 6
  %47 = load i8, i8* %46, align 1, !tbaa !6
  %48 = icmp eq i8 %47, 46
  br i1 %48, label %49, label %50

; <label>:49:                                     ; preds = %45
  br label %50

; <label>:50:                                     ; preds = %49, %45
  %51 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 5
  %52 = load i8, i8* %51, align 1, !tbaa !6
  %53 = icmp eq i8 %52, 46
  br i1 %53, label %54, label %55

; <label>:54:                                     ; preds = %50
  br label %55

; <label>:55:                                     ; preds = %54, %50
  %56 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 4
  %57 = load i8, i8* %56, align 1, !tbaa !6
  %58 = icmp eq i8 %57, 46
  br i1 %58, label %59, label %60

; <label>:59:                                     ; preds = %55
  br label %60

; <label>:60:                                     ; preds = %59, %55
  %61 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 3
  %62 = load i8, i8* %61, align 1, !tbaa !6
  %63 = icmp eq i8 %62, 46
  br i1 %63, label %64, label %65

; <label>:64:                                     ; preds = %60
  br label %65

; <label>:65:                                     ; preds = %64, %60
  %66 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 2
  %67 = load i8, i8* %66, align 1, !tbaa !6
  %68 = icmp eq i8 %67, 46
  br i1 %68, label %69, label %70

; <label>:69:                                     ; preds = %65
  br label %70

; <label>:70:                                     ; preds = %69, %65
  %71 = getelementptr inbounds [14 x i8], [14 x i8]* %10, i64 0, i64 1
  %72 = load i8, i8* %71, align 1, !tbaa !6
  %73 = icmp eq i8 %72, 46
  br i1 %73, label %74, label %75

; <label>:74:                                     ; preds = %70
  br label %75

; <label>:75:                                     ; preds = %74, %70
  store i32 16384, i32* %7, align 4, !tbaa !2
  %76 = getelementptr inbounds [3 x double], [3 x double]* %6, i64 0, i64 0
  %77 = getelementptr inbounds [3 x double], [3 x double]* %6, i64 0, i64 1
  %78 = getelementptr inbounds [3 x double], [3 x double]* %6, i64 0, i64 2
  call void @vranlc(i32 0, double* nonnull %76, double 1.000000e+00, double* nonnull %78) #4
  %79 = load double, double* %78, align 16, !tbaa !7
  %80 = call double @randlc(double* nonnull %77, double %79) #4
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*)) #4
  call void @timer_clear(i32 1) #4
  call void @timer_clear(i32 2) #4
  call void @timer_clear(i32 3) #4
  call void @timer_start(i32 1) #4
  call void @vranlc(i32 0, double* nonnull %3, double 0x41D2309CE5400000, double* getelementptr inbounds ([131072 x double], [131072 x double]* @x, i64 0, i64 0)) #4
  store double 0x41D2309CE5400000, double* %3, align 8, !tbaa !7
  %81 = call double @randlc(double* nonnull %3, double 0x41D2309CE5400000) #4
  %82 = call double @randlc(double* nonnull %3, double undef) #4
  %83 = call double @randlc(double* nonnull %3, double undef) #4
  %84 = call double @randlc(double* nonnull %3, double undef) #4
  %85 = call double @randlc(double* nonnull %3, double undef) #4
  %86 = call double @randlc(double* nonnull %3, double undef) #4
  %87 = call double @randlc(double* nonnull %3, double undef) #4
  %88 = call double @randlc(double* nonnull %3, double undef) #4
  %89 = call double @randlc(double* nonnull %3, double undef) #4
  %90 = call double @randlc(double* nonnull %3, double undef) #4
  %91 = call double @randlc(double* nonnull %3, double undef) #4
  %92 = call double @randlc(double* nonnull %3, double undef) #4
  %93 = call double @randlc(double* nonnull %3, double undef) #4
  %94 = call double @randlc(double* nonnull %3, double undef) #4
  %95 = call double @randlc(double* nonnull %3, double undef) #4
  %96 = call double @randlc(double* nonnull %3, double undef) #4
  %97 = call double @randlc(double* nonnull %3, double undef) #4
  store double 0.000000e+00, double* %4, align 8, !tbaa !7
  store double 0.000000e+00, double* %5, align 8, !tbaa !7
  store i32 -1, i32* %8, align 4, !tbaa !2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @0, i32 8, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, double*, double*, i32*, i32*, i32*, double*, i32*, [131072 x double]*)* @.omp_outlined..4 to void (i32*, i32*, ...)*), double* nonnull %4, double* nonnull %5, i32* nonnull undef, i32* nonnull %7, i32* nonnull %8, double* nonnull undef, i32* nonnull %9, [131072 x double]* nonnull @x) #4
  call void @timer_stop(i32 1) #4
  %98 = call double @timer_read(i32 1) #4
  ret i32 undef
}

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly, i32* noalias nocapture readnone) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, i32* %3, align 4, !tbaa !2
  store i32 131071, i32* %4, align 4, !tbaa !2
  store i32 1, i32* %5, align 4, !tbaa !2
  store i32 0, i32* %6, align 4, !tbaa !2
  %7 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @2, i32 %7, i32 34, i32* nonnull %6, i32* nonnull %3, i32* nonnull %4, i32* nonnull %5, i32 1, i32 1) #4
  %8 = load i32, i32* %4, align 4, !tbaa !2
  %9 = icmp slt i32 %8, 131071
  %10 = select i1 %9, i32 %8, i32 131071
  %11 = load i32, i32* %3, align 4, !tbaa !2
  %12 = icmp sgt i32 %11, %10
  br i1 %12, label %49, label %13

; <label>:13:                                     ; preds = %2
  %14 = sext i32 %11 to i64
  %15 = sext i32 %10 to i64
  %16 = icmp sgt i64 %15, %14
  %17 = select i1 %16, i64 %15, i64 %14
  %18 = add nsw i64 %17, 1
  %19 = sub nsw i64 %18, %14
  %20 = icmp ult i64 %19, 4
  br i1 %20, label %43, label %21

; <label>:21:                                     ; preds = %13
  %22 = and i64 %19, -4
  %23 = add nsw i64 %22, -4
  %24 = lshr exact i64 %23, 2
  %25 = add nuw nsw i64 %24, 1
  %26 = and i64 %25, 3
  %27 = icmp ult i64 %23, 12
  br i1 %27, label %34, label %28

; <label>:28:                                     ; preds = %21
  %29 = sub nsw i64 %25, %26
  br label %30

; <label>:30:                                     ; preds = %30, %28
  %31 = phi i64 [ %29, %28 ], [ %32, %30 ]
  %32 = add i64 %31, -4
  %33 = icmp eq i64 %32, 0
  br i1 %33, label %34, label %30, !llvm.loop !9

; <label>:34:                                     ; preds = %30, %21
  %35 = icmp eq i64 %26, 0
  br i1 %35, label %41, label %36

; <label>:36:                                     ; preds = %34
  br label %37

; <label>:37:                                     ; preds = %37, %36
  %38 = phi i64 [ %26, %36 ], [ %39, %37 ]
  %39 = add i64 %38, -1
  %40 = icmp eq i64 %39, 0
  br i1 %40, label %41, label %37, !llvm.loop !11

; <label>:41:                                     ; preds = %37, %34
  %42 = icmp eq i64 %19, %22
  br i1 %42, label %49, label %43

; <label>:43:                                     ; preds = %41, %13
  %44 = phi i64 [ %14, %13 ], [ undef, %41 ]
  br label %45

; <label>:45:                                     ; preds = %45, %43
  %46 = phi i64 [ %47, %45 ], [ %44, %43 ]
  %47 = add nsw i64 %46, 1
  %48 = icmp slt i64 %46, %15
  br i1 %48, label %45, label %49, !llvm.loop !13

; <label>:49:                                     ; preds = %45, %41, %2
  call void @__kmpc_for_static_fini(%ident_t* nonnull @2, i32 %7) #4
  ret void
}

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined..4(i32* noalias nocapture readonly, i32* noalias nocapture readnone, double* nocapture dereferenceable(8), double* nocapture dereferenceable(8), i32* nocapture readnone dereferenceable(4), i32* nocapture readonly dereferenceable(4), i32* nocapture readonly dereferenceable(4), double* nocapture readonly dereferenceable(8), i32* nocapture dereferenceable(4), [131072 x double]* readonly dereferenceable(1048576)) #0 {
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  %17 = icmp eq [131072 x double]* %9, @x
  br i1 %17, label %19, label %18

; <label>:18:                                     ; preds = %10
  br label %19

; <label>:19:                                     ; preds = %18, %10
  %20 = load i32, i32* %0, align 4, !tbaa !2
  tail call void @__kmpc_barrier(%ident_t* nonnull @1, i32 %20) #4
  %21 = load i32, i32* %5, align 4, !tbaa !2
  %22 = add nsw i32 %21, -1
  %23 = icmp sgt i32 %21, 0
  br i1 %23, label %25, label %24

; <label>:24:                                     ; preds = %19
  br label %113

; <label>:25:                                     ; preds = %19
  store i32 0, i32* %13, align 4, !tbaa !2
  store i32 %22, i32* %14, align 4, !tbaa !2
  store double 0.000000e+00, double* %15, align 8, !tbaa !7
  store double 0.000000e+00, double* %16, align 8, !tbaa !7
  %MengHao = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0))
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @2, i32 %20, i32 34, i32* nonnull undef, i32* nonnull %13, i32* nonnull %14, i32* nonnull undef, i32 1, i32 1) #4
  %26 = load i32, i32* %14, align 4, !tbaa !2
  %27 = icmp sgt i32 %26, %22
  %28 = select i1 %27, i32 %22, i32 %26
  %29 = load i32, i32* %13, align 4, !tbaa !2
  %30 = icmp sgt i32 %29, %28
  br i1 %30, label %84, label %31

; <label>:31:                                     ; preds = %25
  br label %32

; <label>:32:                                     ; preds = %82, %31
  %33 = phi i32 [ %29, %31 ], [ %34, %82 ]
  %34 = add nsw i32 %33, 1
  %35 = load i32, i32* %6, align 4, !tbaa !2
  %36 = add nsw i32 %35, %34
  store double 0x41B033C4D7000000, double* %11, align 8, !tbaa !7
  br label %37

; <label>:37:                                     ; preds = %48, %32
  %38 = phi i32 [ %36, %32 ], [ %40, %48 ]
  %39 = phi i32 [ 1, %32 ], [ %50, %48 ]
  %40 = sdiv i32 %38, 2
  %41 = shl nsw i32 %40, 1
  %42 = icmp eq i32 %41, %38
  br i1 %42, label %45, label %43

; <label>:43:                                     ; preds = %37
  %44 = call double @randlc(double* nonnull %11, double undef) #4
  br label %45

; <label>:45:                                     ; preds = %43, %37
  %46 = add i32 %38, 1
  %47 = icmp ult i32 %46, 3
  br i1 %47, label %52, label %48

; <label>:48:                                     ; preds = %45
  %49 = call double @randlc(double* nonnull %12, double undef) #4
  %50 = add nuw nsw i32 %39, 1
  %51 = icmp ult i32 %50, 101
  br i1 %51, label %37, label %52

; <label>:52:                                     ; preds = %48, %45
  call void @vranlc(i32 131072, double* nonnull %11, double 0x41D2309CE5400000, double* getelementptr ([131072 x double], [131072 x double]* @x, i64 0, i64 -1)) #4
  br label %53

; <label>:53:                                     ; preds = %79, %52
  %54 = phi i64 [ 0, %52 ], [ %80, %79 ]
  %55 = shl nuw nsw i64 %54, 1
  %56 = getelementptr inbounds [131072 x double], [131072 x double]* @x, i64 0, i64 %55
  %57 = bitcast double* %56 to <2 x double>*
  %58 = load <2 x double>, <2 x double>* %57, align 16, !tbaa !7
  %59 = fmul <2 x double> %58, <double 2.000000e+00, double 2.000000e+00>
  %60 = fadd <2 x double> %59, <double -1.000000e+00, double -1.000000e+00>
  %61 = fmul <2 x double> %60, %60
  %62 = extractelement <2 x double> %61, i32 0
  %63 = extractelement <2 x double> %61, i32 1
  %64 = fadd double %62, %63
  store double %64, double* %11, align 8, !tbaa !7
  %65 = fcmp ugt double %64, 1.000000e+00
  br i1 %65, label %79, label %66

; <label>:66:                                     ; preds = %53
  %67 = call double @log(double %64) #4
  %68 = fmul double %67, -2.000000e+00
  %69 = load double, double* %11, align 8, !tbaa !7
  %70 = fdiv double %68, %69
  %71 = call double @sqrt(double %70) #4
  store double %71, double* %12, align 8, !tbaa !7
  %72 = fmul <2 x double> %60, undef
  %73 = load double, double* %15, align 8, !tbaa !7
  %74 = extractelement <2 x double> %72, i32 0
  %75 = fadd double %74, %73
  store double %75, double* %15, align 8, !tbaa !7
  %76 = load double, double* %16, align 8, !tbaa !7
  %77 = extractelement <2 x double> %72, i32 1
  %78 = fadd double %77, %76
  store double %78, double* %16, align 8, !tbaa !7
  br label %79

; <label>:79:                                     ; preds = %66, %53
  %80 = add nuw nsw i64 %54, 1
  %81 = icmp eq i64 %80, 65536
  br i1 %81, label %82, label %53

; <label>:82:                                     ; preds = %79
  %83 = icmp slt i32 %33, undef
  br i1 %83, label %32, label %84

; <label>:84:                                     ; preds = %82, %25
  call void @__kmpc_for_static_fini(%ident_t* nonnull @2, i32 %20) #4
  %85 = call i32 @__kmpc_reduce(%ident_t* nonnull @3, i32 %20, i32 2, i64 16, i8* nonnull undef, void (i8*, i8*)* nonnull @.omp.reduction.reduction_func, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #4
  switch i32 %85, label %112 [
    i32 1, label %86
    i32 2, label %87
  ]

; <label>:86:                                     ; preds = %84
  call void @__kmpc_end_reduce(%ident_t* nonnull @3, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #4
  br label %112

; <label>:87:                                     ; preds = %84
  %88 = bitcast double* %2 to i64*
  %89 = load atomic i64, i64* %88 monotonic, align 8, !tbaa !7
  %90 = load double, double* %15, align 8, !tbaa !7
  br label %91

; <label>:91:                                     ; preds = %91, %87
  %92 = phi i64 [ %89, %87 ], [ %97, %91 ]
  %93 = bitcast i64 %92 to double
  %94 = fadd double %90, %93
  %95 = bitcast double %94 to i64
  %96 = cmpxchg i64* %88, i64 %92, i64 %95 monotonic monotonic
  %97 = extractvalue { i64, i1 } %96, 0
  %98 = extractvalue { i64, i1 } %96, 1
  br i1 %98, label %99, label %91

; <label>:99:                                     ; preds = %91
  %100 = bitcast double* %3 to i64*
  %101 = load atomic i64, i64* %100 monotonic, align 8, !tbaa !7
  %102 = load double, double* %16, align 8, !tbaa !7
  br label %103

; <label>:103:                                    ; preds = %103, %99
  %104 = phi i64 [ %101, %99 ], [ %109, %103 ]
  %105 = bitcast i64 %104 to double
  %106 = fadd double %102, %105
  %107 = bitcast double %106 to i64
  %108 = cmpxchg i64* %100, i64 %104, i64 %107 monotonic monotonic
  %109 = extractvalue { i64, i1 } %108, 0
  %110 = extractvalue { i64, i1 } %108, 1
  br i1 %110, label %111, label %103

; <label>:111:                                    ; preds = %103
  call void @__kmpc_end_reduce(%ident_t* nonnull @3, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #4
  br label %112

; <label>:112:                                    ; preds = %111, %86, %84
  br label %113

; <label>:113:                                    ; preds = %112, %24
  call void @__kmpc_barrier(%ident_t* nonnull @1, i32 %20) #4
  call void @__kmpc_critical(%ident_t* nonnull @0, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.var) #4
  call void @__kmpc_end_critical(%ident_t* nonnull @0, i32 %20, [8 x i32]* nonnull @.gomp_critical_user_.var) #4
  %114 = call i32 @__kmpc_master(%ident_t* nonnull @0, i32 %20) #4
  %115 = icmp eq i32 %114, 0
  br i1 %115, label %117, label %116

; <label>:116:                                    ; preds = %113
  call void @__kmpc_end_master(%ident_t* nonnull @0, i32 %20) #4
  br label %117

; <label>:117:                                    ; preds = %116, %113
  ret void
}

declare void @__kmpc_barrier(%ident_t*, i32) local_unnamed_addr

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

; Function Attrs: nounwind
declare double @log(double) local_unnamed_addr #1

; Function Attrs: nounwind
declare double @sqrt(double) local_unnamed_addr #1

declare void @__kmpc_for_static_fini(%ident_t*, i32) local_unnamed_addr

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp.reduction.reduction_func(i8* nocapture readonly, i8* nocapture readonly) #2 {
  ret void
}

declare i32 @__kmpc_reduce(%ident_t*, i32, i32, i64, i8*, void (i8*, i8*)*, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_reduce(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_critical(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_critical(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare i32 @__kmpc_master(%ident_t*, i32) local_unnamed_addr

declare void @__kmpc_end_master(%ident_t*, i32) local_unnamed_addr

; Function Attrs: nounwind uwtable
define void @c_print_results(i8*, i8 signext, i32, i32, i32, i32, i32, double, double, i8*, i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*) local_unnamed_addr #0 {
  %21 = or i32 %4, %3
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %24

; <label>:23:                                     ; preds = %20
  br label %25

; <label>:24:                                     ; preds = %20
  br label %25

; <label>:25:                                     ; preds = %24, %23
  %26 = icmp eq i32 %10, 0
  br i1 %26, label %28, label %27

; <label>:27:                                     ; preds = %25
  br label %29

; <label>:28:                                     ; preds = %25
  br label %29

; <label>:29:                                     ; preds = %28, %27
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define double @randlc(double* nocapture, double) local_unnamed_addr #2 {
  ret double undef
}

; Function Attrs: norecurse nounwind uwtable
define void @vranlc(i32, double* nocapture, double, double* nocapture) local_unnamed_addr #2 {
  %5 = icmp slt i32 %0, 1
  br i1 %5, label %13, label %6

; <label>:6:                                      ; preds = %4
  %7 = add i32 %0, 1
  %8 = zext i32 %7 to i64
  br label %9

; <label>:9:                                      ; preds = %9, %6
  %10 = phi i64 [ %11, %9 ], [ 1, %6 ]
  %11 = add nuw nsw i64 %10, 1
  %12 = icmp eq i64 %11, %8
  br i1 %12, label %13, label %9

; <label>:13:                                     ; preds = %9, %4
  ret void
}

; Function Attrs: nounwind uwtable
define double @elapsed_time() local_unnamed_addr #0 {
  %1 = alloca double, align 8
  call void @wtime_(double* nonnull %1) #4
  ret double undef
}

; Function Attrs: norecurse nounwind uwtable
define void @timer_clear(i32) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: nounwind uwtable
define void @timer_start(i32) local_unnamed_addr #0 {
  %2 = alloca double, align 8
  call void @wtime_(double* nonnull %2) #4
  ret void
}

; Function Attrs: nounwind uwtable
define void @timer_stop(i32) local_unnamed_addr #0 {
  %2 = alloca double, align 8
  call void @wtime_(double* nonnull %2) #4
  ret void
}

; Function Attrs: norecurse nounwind readonly uwtable
define double @timer_read(i32) local_unnamed_addr #3 {
  ret double undef
}

declare i32 @printf(i8*, ...) #1
; Function Attrs: nounwind uwtable
define void @wtime_(double* nocapture) local_unnamed_addr #0 {
  %2 = load i32, i32* @wtime_.sec, align 4, !tbaa !2
  %3 = icmp slt i32 %2, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %1
  br label %5

; <label>:5:                                      ; preds = %4, %1
  ret void
}

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { norecurse nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

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
