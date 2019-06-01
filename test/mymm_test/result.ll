; ModuleID = 'mm.ll'
source_filename = "mm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }

@firstParaMatrix = global [3000 x [3000 x double]] zeroinitializer, align 16
@secondParaMatrix = global [3000 x [3000 x double]] zeroinitializer, align 16
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@matrixMultiResult = global [3000 x [3000 x double]] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define double @calcuPartOfMatrixMulti(i32, i32) #0 {
  %3 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  br label %4

; <label>:4:                                      ; preds = %8, %2
  %5 = load i32, i32* %3, align 4
  %6 = icmp slt i32 %5, 3000
  br i1 %6, label %7, label %11

; <label>:7:                                      ; preds = %4
  br label %8

; <label>:8:                                      ; preds = %7
  %9 = load i32, i32* %3, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, i32* %3, align 4
  br label %4

; <label>:11:                                     ; preds = %4
  ret double undef
}

; Function Attrs: noinline nounwind optnone uwtable
define void @matrixInit() #0 {
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @1, i32 0, void (i32*, i32*, ...)* bitcast (void (i32*, i32*)* @.omp_outlined. to void (i32*, i32*, ...)*))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32 0, i32* %5, align 4
  store i32 2999, i32* %6, align 4
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  %10 = load i32*, i32** %3, align 8
  %11 = load i32, i32* %10, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %11, i32 34, i32* %8, i32* %5, i32* %6, i32* %7, i32 1, i32 1)
  %12 = load i32, i32* %6, align 4
  %13 = icmp sgt i32 %12, 2999
  br i1 %13, label %14, label %15

; <label>:14:                                     ; preds = %2
  br label %17

; <label>:15:                                     ; preds = %2
  %16 = load i32, i32* %6, align 4
  br label %17

; <label>:17:                                     ; preds = %15, %14
  %18 = phi i32 [ 2999, %14 ], [ %16, %15 ]
  store i32 %18, i32* %6, align 4
  %19 = load i32, i32* %5, align 4
  store i32 %19, i32* %4, align 4
  br label %20

; <label>:20:                                     ; preds = %34, %17
  %21 = load i32, i32* %4, align 4
  %22 = load i32, i32* %6, align 4
  %23 = icmp sle i32 %21, %22
  br i1 %23, label %24, label %37

; <label>:24:                                     ; preds = %20
  store i32 0, i32* %9, align 4
  br label %25

; <label>:25:                                     ; preds = %29, %24
  %26 = load i32, i32* %9, align 4
  %27 = icmp slt i32 %26, 3000
  br i1 %27, label %28, label %32

; <label>:28:                                     ; preds = %25
  br label %29

; <label>:29:                                     ; preds = %28
  %30 = load i32, i32* %9, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %9, align 4
  br label %25

; <label>:32:                                     ; preds = %25
  br label %33

; <label>:33:                                     ; preds = %32
  br label %34

; <label>:34:                                     ; preds = %33
  %35 = load i32, i32* %4, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %4, align 4
  br label %20

; <label>:37:                                     ; preds = %20
  br label %38

; <label>:38:                                     ; preds = %37
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %11)
  ret void
}

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

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
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32 0, i32* %5, align 4
  store i32 2999, i32* %6, align 4
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  %11 = load i32*, i32** %3, align 8
  %12 = load i32, i32* %11, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @0, i32 %12, i32 34, i32* %8, i32* %5, i32* %6, i32* %7, i32 1, i32 1)
  %13 = load i32, i32* %6, align 4
  %14 = icmp sgt i32 %13, 2999
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %2
  br label %18

; <label>:16:                                     ; preds = %2
  %17 = load i32, i32* %6, align 4
  br label %18

; <label>:18:                                     ; preds = %16, %15
  %19 = phi i32 [ 2999, %15 ], [ %17, %16 ]
  store i32 %19, i32* %6, align 4
  %20 = load i32, i32* %5, align 4
  store i32 %20, i32* %4, align 4
  br label %21

; <label>:21:                                     ; preds = %41, %18
  %22 = load i32, i32* %4, align 4
  %23 = load i32, i32* %6, align 4
  %24 = icmp sle i32 %22, %23
  br i1 %24, label %25, label %44

; <label>:25:                                     ; preds = %21
  %26 = load i32, i32* %4, align 4
  %27 = mul nsw i32 %26, 1
  %28 = add nsw i32 0, %27
  store i32 %28, i32* %9, align 4
  store i32 0, i32* %10, align 4
  br label %29

; <label>:29:                                     ; preds = %36, %25
  %30 = load i32, i32* %10, align 4
  %31 = icmp slt i32 %30, 3000
  br i1 %31, label %32, label %39

; <label>:32:                                     ; preds = %29
  %33 = load i32, i32* %9, align 4
  %34 = load i32, i32* %10, align 4
  %35 = call double @calcuPartOfMatrixMulti(i32 %33, i32 %34)
  br label %36

; <label>:36:                                     ; preds = %32
  %37 = load i32, i32* %10, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, i32* %10, align 4
  br label %29

; <label>:39:                                     ; preds = %29
  br label %40

; <label>:40:                                     ; preds = %39
  br label %41

; <label>:41:                                     ; preds = %40
  %42 = load i32, i32* %4, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %4, align 4
  br label %21

; <label>:44:                                     ; preds = %21
  br label %45

; <label>:45:                                     ; preds = %44
  call void @__kmpc_for_static_fini(%ident_t* @0, i32 %12)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  call void @matrixInit()
  call void @matrixMulti()
  ret i32 undef
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
