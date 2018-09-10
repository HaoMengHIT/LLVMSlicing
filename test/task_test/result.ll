; ModuleID = 'test.ll'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct..kmp_privates.t = type { i32 }
%struct.kmp_task_t_with_privates = type { %struct.kmp_task_t, %struct..kmp_privates.t }
%struct.kmp_task_t = type { i8*, i32 (i32, i8*)*, i32, %union.kmp_cmplrdata_t, %union.kmp_cmplrdata_t }
%union.kmp_cmplrdata_t = type { i32 (i32, i8*)* }
%struct.anon = type { [50 x i32]*, i32* }

@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant %ident_t { i32 0, i32 322, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8

; Function Attrs: noinline nounwind optnone uwtable
define void @task(i32) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* %3, align 4
  br label %4

; <label>:4:                                      ; preds = %10, %1
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %2, align 4
  %7 = mul nsw i32 %6, 100000000
  %8 = icmp slt i32 %5, %7
  br i1 %8, label %9, label %13

; <label>:9:                                      ; preds = %4
  br label %10

; <label>:10:                                     ; preds = %9
  %11 = load i32, i32* %3, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* %3, align 4
  br label %4

; <label>:13:                                     ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @init(i32*) #0 {
  %2 = alloca i32, align 4
  store i32 0, i32* %2, align 4
  br label %3

; <label>:3:                                      ; preds = %7, %1
  %4 = load i32, i32* %2, align 4
  %5 = icmp slt i32 %4, 50
  br i1 %5, label %6, label %10

; <label>:6:                                      ; preds = %3
  br label %7

; <label>:7:                                      ; preds = %6
  %8 = load i32, i32* %2, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, i32* %2, align 4
  br label %3

; <label>:10:                                     ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca [50 x i32], align 16
  %4 = call i32 @__kmpc_global_thread_num(%ident_t* @0)
  %5 = getelementptr inbounds [50 x i32], [50 x i32]* %3, i32 0, i32 0
  call void @init(i32* %5)
  call void @__kmpc_push_num_threads(%ident_t* @0, i32 %4, i32 2)
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 1, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, [50 x i32]*)* @.omp_outlined. to void (i32*, i32*, ...)*), [50 x i32]* %3)
  ret i32 undef
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias, [50 x i32]* dereferenceable(200)) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca [50 x i32]*, align 8
  %6 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  store [50 x i32]* %2, [50 x i32]** %5, align 8
  %7 = load [50 x i32]*, [50 x i32]** %5, align 8
  %8 = load i32*, i32** %4, align 8
  %9 = load i32, i32* %8, align 4
  %10 = call i32 @__kmpc_single(%ident_t* @0, i32 %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %27

; <label>:12:                                     ; preds = %3
  store i32 0, i32* %6, align 4
  br label %13

; <label>:13:                                     ; preds = %19, %12
  %14 = load i32, i32* %6, align 4
  %15 = icmp slt i32 %14, 50
  br i1 %15, label %16, label %26

; <label>:16:                                     ; preds = %13
  %17 = call i8* @__kmpc_omp_task_alloc(%ident_t* @0, i32 %9, i32 1, i64 48, i64 16, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*))
  %18 = call i32 @__kmpc_omp_task(%ident_t* @0, i32 %9, i8* %17)
  br label %19

; <label>:19:                                     ; preds = %16
  %20 = load i32, i32* %6, align 4
  %21 = load i32, i32* %6, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [50 x i32], [50 x i32]* %7, i64 0, i64 %22
  %24 = load i32, i32* %23, align 4
  %25 = add nsw i32 %20, %24
  store i32 %25, i32* %6, align 4
  br label %13

; <label>:26:                                     ; preds = %13
  call void @__kmpc_end_single(%ident_t* @0, i32 %9)
  br label %27

; <label>:27:                                     ; preds = %26, %3
  call void @__kmpc_barrier(%ident_t* @1, i32 %9)
  ret void
}

declare void @__kmpc_end_single(%ident_t*, i32)

declare i32 @__kmpc_single(%ident_t*, i32)

; Function Attrs: alwaysinline nounwind uwtable
define internal void @.omp_task_privates_map.(%struct..kmp_privates.t* noalias, i32** noalias) #1 {
  %3 = alloca %struct..kmp_privates.t*, align 8
  %4 = alloca i32**, align 8
  store %struct..kmp_privates.t* %0, %struct..kmp_privates.t** %3, align 8
  store i32** %1, i32*** %4, align 8
  %5 = load %struct..kmp_privates.t*, %struct..kmp_privates.t** %3, align 8
  %6 = getelementptr inbounds %struct..kmp_privates.t, %struct..kmp_privates.t* %5, i32 0, i32 0
  %7 = load i32**, i32*** %4, align 8
  store i32* %6, i32** %7, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @.omp_task_entry.(i32, %struct.kmp_task_t_with_privates* noalias) #2 {
  %3 = alloca i32, align 4
  %4 = alloca i32*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca void (i8*, ...)*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.anon*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.kmp_task_t_with_privates*, align 8
  store i32 %0, i32* %10, align 4
  store %struct.kmp_task_t_with_privates* %1, %struct.kmp_task_t_with_privates** %11, align 8
  %12 = load i32, i32* %10, align 4
  %13 = load %struct.kmp_task_t_with_privates*, %struct.kmp_task_t_with_privates** %11, align 8
  %14 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %13, i32 0, i32 0
  %15 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %14, i32 0, i32 2
  %16 = getelementptr inbounds %struct.kmp_task_t, %struct.kmp_task_t* %14, i32 0, i32 0
  %17 = load i8*, i8** %16, align 8
  %18 = bitcast i8* %17 to %struct.anon*
  %19 = getelementptr inbounds %struct.kmp_task_t_with_privates, %struct.kmp_task_t_with_privates* %13, i32 0, i32 1
  %20 = bitcast %struct..kmp_privates.t* %19 to i8*
  %21 = bitcast %struct.kmp_task_t_with_privates* %13 to i8*
  store i32 %12, i32* %3, align 4
  store i32* %15, i32** %4, align 8
  store i8* %20, i8** %5, align 8
  store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t*, i32**)* @.omp_task_privates_map. to void (i8*, ...)*), void (i8*, ...)** %6, align 8
  store i8* %21, i8** %7, align 8
  store %struct.anon* %18, %struct.anon** %8, align 8
  %22 = load %struct.anon*, %struct.anon** %8, align 8
  %23 = load void (i8*, ...)*, void (i8*, ...)** %6, align 8
  %24 = load i8*, i8** %5, align 8
  call void (i8*, ...) %23(i8* %24, i32** %9) #3
  %25 = load i32*, i32** %9, align 8
  %26 = getelementptr inbounds %struct.anon, %struct.anon* %22, i32 0, i32 0
  %27 = load [50 x i32]*, [50 x i32]** %26, align 8
  %28 = load i32, i32* %25, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [50 x i32], [50 x i32]* %27, i64 0, i64 %29
  call void @test()
  %31 = load i32, i32* %30, align 4
  call void @task(i32 %31) #3
  ret i32 0
}
@.str1111 = private unnamed_addr constant [13 x i8] c"Hello world\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @test() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str1111, i32 0, i32 0))
  ret void
}

declare i32 @printf(i8*, ...) #1

declare i8* @__kmpc_omp_task_alloc(%ident_t*, i32, i32, i64, i64, i32 (i32, i8*)*)

declare i32 @__kmpc_omp_task(%ident_t*, i32, i8*)

declare void @__kmpc_barrier(%ident_t*, i32)

declare i32 @__kmpc_global_thread_num(%ident_t*)

declare void @__kmpc_push_num_threads(%ident_t*, i32, i32)

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2~16.04.1 (tags/RELEASE_600/final)"}
