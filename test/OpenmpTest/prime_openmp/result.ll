; ModuleID = 'prime_openmp.bc'
source_filename = "prime_openmp.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@.str.10 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@.gomp_critical_user_.reduction.var = common global [8 x i32] zeroinitializer
@1 = private unnamed_addr constant %ident_t { i32 0, i32 18, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@2 = private unnamed_addr constant %ident_t { i32 0, i32 66, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i32 0, i32 0) }, align 8

; Function Attrs: nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  tail call void @prime_number_sweep(i32 1, i32 131072, i32 2)
  tail call void @prime_number_sweep(i32 5, i32 500000, i32 10)
  ret i32 undef
}

; Function Attrs: nounwind uwtable
define void @prime_number_sweep(i32, i32, i32) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %0, %1
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  br label %6

; <label>:6:                                      ; preds = %5, %6
  %7 = phi i32 [ %9, %6 ], [ %0, %5 ]
  %8 = tail call i32 @prime_number(i32 %7)
  %9 = mul nsw i32 %7, %2
  %10 = icmp sgt i32 %9, %1
  br i1 %10, label %11, label %6

; <label>:11:                                     ; preds = %6, %3
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @prime_number(i32) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4, !tbaa !2
  store i32 0, i32* %3, align 4, !tbaa !2
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* nonnull @3, i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* nonnull %3, i32* nonnull %2) #2
  ret i32 undef
}

; Function Attrs: nounwind uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly, i32* noalias nocapture readnone, i32* nocapture dereferenceable(4), i32* nocapture readonly dereferenceable(4)) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [1 x i8*], align 8
  %10 = load i32, i32* %3, align 4, !tbaa !2
  %11 = add nsw i32 %10, -2
  %12 = icmp sgt i32 %10, 1
  br i1 %12, label %13, label %43

; <label>:13:                                     ; preds = %4
  store i32 0, i32* %5, align 4, !tbaa !2
  store i32 %11, i32* %6, align 4, !tbaa !2
  store i32 1, i32* %7, align 4, !tbaa !2
  store i32 0, i32* %8, align 4, !tbaa !2
  %14 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_for_static_init_4(%ident_t* nonnull @0, i32 %14, i32 34, i32* nonnull %8, i32* nonnull %5, i32* nonnull %6, i32* nonnull %7, i32 1, i32 1) #2
  %15 = load i32, i32* %6, align 4, !tbaa !2
  %16 = icmp sgt i32 %15, %11
  %17 = select i1 %16, i32 %11, i32 %15
  %18 = load i32, i32* %5, align 4, !tbaa !2
  %19 = icmp sgt i32 %18, %17
  br i1 %19, label %37, label %20

; <label>:20:                                     ; preds = %13
  br label %21

; <label>:21:                                     ; preds = %33, %20
  %22 = phi i32 [ %18, %20 ], [ %34, %33 ]
  %23 = add nsw i32 %22, 2
  %24 = icmp sgt i32 %22, 0
  br i1 %24, label %25, label %33

; <label>:25:                                     ; preds = %21
  br label %28

; <label>:26:                                     ; preds = %28
  %27 = icmp slt i32 %32, %23
  br i1 %27, label %28, label %33

; <label>:28:                                     ; preds = %25, %26
  %29 = phi i32 [ %32, %26 ], [ 2, %25 ]
  %30 = srem i32 %23, %29
  %31 = icmp eq i32 %30, 0
  %32 = add nuw nsw i32 %29, 1
  br i1 %31, label %33, label %26

; <label>:33:                                     ; preds = %26, %28, %21
  %34 = add nsw i32 %22, 1
  %35 = icmp slt i32 %22, %17
  br i1 %35, label %21, label %36

; <label>:36:                                     ; preds = %33
  br label %37

; <label>:37:                                     ; preds = %36, %13
  call void @__kmpc_for_static_fini(%ident_t* nonnull @0, i32 %14) #2
  %38 = bitcast [1 x i8*]* %9 to i8*
  %39 = call i32 @__kmpc_reduce(%ident_t* nonnull @1, i32 %14, i32 1, i64 8, i8* nonnull %38, void (i8*, i8*)* nonnull @.omp.reduction.reduction_func, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  switch i32 %39, label %42 [
    i32 1, label %40
    i32 2, label %41
  ]

; <label>:40:                                     ; preds = %37
  call void @__kmpc_end_reduce(%ident_t* nonnull @1, i32 %14, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  br label %42

; <label>:41:                                     ; preds = %37
  call void @__kmpc_end_reduce(%ident_t* nonnull @1, i32 %14, [8 x i32]* nonnull @.gomp_critical_user_.reduction.var) #2
  br label %42

; <label>:42:                                     ; preds = %41, %40, %37
  br label %43

; <label>:43:                                     ; preds = %42, %4
  %44 = load i32, i32* %0, align 4, !tbaa !2
  call void @__kmpc_barrier(%ident_t* nonnull @2, i32 %44) #2
  ret void
}

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

declare void @__kmpc_for_static_fini(%ident_t*, i32) local_unnamed_addr

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp.reduction.reduction_func(i8* nocapture readonly, i8* nocapture readonly) #1 {
  ret void
}

declare i32 @__kmpc_reduce(%ident_t*, i32, i32, i64, i8*, void (i8*, i8*)*, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_end_reduce(%ident_t*, i32, [8 x i32]*) local_unnamed_addr

declare void @__kmpc_barrier(%ident_t*, i32) local_unnamed_addr

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2~16.04.1 (tags/RELEASE_600/final)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}