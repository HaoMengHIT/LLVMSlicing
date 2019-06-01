; ModuleID = 'j3d_final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%ident_t = type { i32, i32, i32, i32, i8* }
%struct.timeval = type { i64, i64 }
%struct.rusage = type { %struct.timeval, %struct.timeval, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon, %union.anon }
%union.anon = type { i64 }
%struct.timezone = type { i32, i32 }

@oos = constant double 0x3FC5555555555555, align 8
@.str = private unnamed_addr constant [18 x i8] c"Usage: %s <size>\0A\00", align 1
@0 = private unnamed_addr constant %ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.2 = private unnamed_addr constant [44 x i8] c"size: %d  time: %lf  iter: %d  MLUP/s: %lf\0A\00", align 1
@1 = private unnamed_addr constant %ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0) }, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @jacobi_line(double*, double*, double*, double*, double*, double*, double*, i32) #0 {
  %9 = alloca double*, align 8
  %10 = alloca double*, align 8
  %11 = alloca double*, align 8
  %12 = alloca double*, align 8
  %13 = alloca double*, align 8
  %14 = alloca double*, align 8
  %15 = alloca double*, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store double* %0, double** %9, align 8
  store double* %1, double** %10, align 8
  store double* %2, double** %11, align 8
  store double* %3, double** %12, align 8
  store double* %4, double** %13, align 8
  store double* %5, double** %14, align 8
  store double* %6, double** %15, align 8
  store i32 %7, i32* %16, align 4
  store i32 1, i32* %18, align 4
  store i32 1, i32* %17, align 4
  br label %19

; <label>:19:                                     ; preds = %79, %8
  %20 = load i32, i32* %17, align 4
  %21 = load i32, i32* %16, align 4
  %22 = sub nsw i32 %21, 1
  %23 = icmp slt i32 %20, %22
  br i1 %23, label %24, label %82

; <label>:24:                                     ; preds = %19
  %25 = load double*, double** %15, align 8
  %26 = load i32, i32* %17, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds double, double* %25, i64 %27
  %29 = load double, double* %28, align 8
  %30 = load double*, double** %10, align 8
  %31 = load i32, i32* %17, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds double, double* %30, i64 %32
  %34 = load double, double* %33, align 8
  %35 = fmul double %29, %34
  %36 = load double*, double** %10, align 8
  %37 = load i32, i32* %17, align 4
  %38 = sub nsw i32 %37, 1
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds double, double* %36, i64 %39
  %41 = load double, double* %40, align 8
  %42 = fadd double %35, %41
  %43 = load double*, double** %10, align 8
  %44 = load i32, i32* %17, align 4
  %45 = add nsw i32 %44, 1
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds double, double* %43, i64 %46
  %48 = load double, double* %47, align 8
  %49 = fadd double %42, %48
  %50 = load double*, double** %11, align 8
  %51 = load i32, i32* %17, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds double, double* %50, i64 %52
  %54 = load double, double* %53, align 8
  %55 = fadd double %49, %54
  %56 = load double*, double** %12, align 8
  %57 = load i32, i32* %17, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds double, double* %56, i64 %58
  %60 = load double, double* %59, align 8
  %61 = fadd double %55, %60
  %62 = load double*, double** %13, align 8
  %63 = load i32, i32* %17, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds double, double* %62, i64 %64
  %66 = load double, double* %65, align 8
  %67 = fadd double %61, %66
  %68 = load double*, double** %14, align 8
  %69 = load i32, i32* %17, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds double, double* %68, i64 %70
  %72 = load double, double* %71, align 8
  %73 = fadd double %67, %72
  %74 = fdiv double %73, 6.000000e+00
  %75 = load double*, double** %9, align 8
  %76 = load i32, i32* %17, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds double, double* %75, i64 %77
  store double %74, double* %78, align 8
  br label %79

; <label>:79:                                     ; preds = %24
  %80 = load i32, i32* %17, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %17, align 4
  br label %19

; <label>:82:                                     ; preds = %19
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca [2 x double*], align 16
  %23 = alloca double*, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %24 = load i32, i32* %4, align 4
  %25 = icmp ne i32 %24, 2
  br i1 %25, label %26, label %31

; <label>:26:                                     ; preds = %2
  %27 = load i8**, i8*** %5, align 8
  %28 = getelementptr inbounds i8*, i8** %27, i64 0
  %29 = load i8*, i8** %28, align 8
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0), i8* %29)
  call void @exit(i32 1) #5
  unreachable

; <label>:31:                                     ; preds = %2
  %32 = load i8**, i8*** %5, align 8
  %33 = getelementptr inbounds i8*, i8** %32, i64 1
  %34 = load i8*, i8** %33, align 8
  %35 = call i32 @atoi(i8* %34) #6
  store i32 %35, i32* %13, align 4
  %36 = load i32, i32* %13, align 4
  %37 = sext i32 %36 to i64
  %38 = load i32, i32* %13, align 4
  %39 = sext i32 %38 to i64
  %40 = mul i64 %37, %39
  %41 = load i32, i32* %13, align 4
  %42 = sext i32 %41 to i64
  %43 = mul i64 %40, %42
  %44 = mul i64 %43, 8
  %45 = call noalias i8* @malloc(i64 %44) #7
  %46 = bitcast i8* %45 to double*
  %47 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 0
  store double* %46, double** %47, align 16
  %48 = load i32, i32* %13, align 4
  %49 = sext i32 %48 to i64
  %50 = load i32, i32* %13, align 4
  %51 = sext i32 %50 to i64
  %52 = mul i64 %49, %51
  %53 = load i32, i32* %13, align 4
  %54 = sext i32 %53 to i64
  %55 = mul i64 %52, %54
  %56 = mul i64 %55, 8
  %57 = call noalias i8* @malloc(i64 %56) #7
  %58 = bitcast i8* %57 to double*
  %59 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 1
  store double* %58, double** %59, align 8
  %60 = load i32, i32* %13, align 4
  %61 = sext i32 %60 to i64
  %62 = load i32, i32* %13, align 4
  %63 = sext i32 %62 to i64
  %64 = mul i64 %61, %63
  %65 = load i32, i32* %13, align 4
  %66 = sext i32 %65 to i64
  %67 = mul i64 %64, %66
  %68 = mul i64 %67, 8
  %69 = call noalias i8* @malloc(i64 %68) #7
  %70 = bitcast i8* %69 to double*
  store double* %70, double** %23, align 8
  store i32 0, i32* %18, align 4
  store i32 1, i32* %19, align 4
  store i32 0, i32* %14, align 4
  br label %71

; <label>:71:                                     ; preds = %132, %31
  %72 = load i32, i32* %14, align 4
  %73 = load i32, i32* %13, align 4
  %74 = icmp slt i32 %72, %73
  br i1 %74, label %75, label %135

; <label>:75:                                     ; preds = %71
  store i32 0, i32* %15, align 4
  br label %76

; <label>:76:                                     ; preds = %128, %75
  %77 = load i32, i32* %15, align 4
  %78 = load i32, i32* %13, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %131

; <label>:80:                                     ; preds = %76
  %81 = load i32, i32* %14, align 4
  %82 = load i32, i32* %13, align 4
  %83 = mul nsw i32 %81, %82
  %84 = load i32, i32* %13, align 4
  %85 = mul nsw i32 %83, %84
  %86 = load i32, i32* %15, align 4
  %87 = load i32, i32* %13, align 4
  %88 = mul nsw i32 %86, %87
  %89 = add nsw i32 %85, %88
  store i32 %89, i32* %21, align 4
  store i32 0, i32* %16, align 4
  br label %90

; <label>:90:                                     ; preds = %124, %80
  %91 = load i32, i32* %16, align 4
  %92 = load i32, i32* %13, align 4
  %93 = icmp slt i32 %91, %92
  br i1 %93, label %94, label %127

; <label>:94:                                     ; preds = %90
  %95 = load i32, i32* %14, align 4
  %96 = sitofp i32 %95 to double
  %97 = load i32, i32* %15, align 4
  %98 = sitofp i32 %97 to double
  %99 = fadd double %96, %98
  %100 = load i32, i32* %18, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 %101
  %103 = load double*, double** %102, align 8
  %104 = load i32, i32* %21, align 4
  %105 = load i32, i32* %16, align 4
  %106 = add nsw i32 %104, %105
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds double, double* %103, i64 %107
  store double %99, double* %108, align 8
  %109 = load i32, i32* %19, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 %110
  %112 = load double*, double** %111, align 8
  %113 = load i32, i32* %21, align 4
  %114 = load i32, i32* %16, align 4
  %115 = add nsw i32 %113, %114
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds double, double* %112, i64 %116
  store double %99, double* %117, align 8
  %118 = load double*, double** %23, align 8
  %119 = load i32, i32* %21, align 4
  %120 = load i32, i32* %16, align 4
  %121 = add nsw i32 %119, %120
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds double, double* %118, i64 %122
  store double %99, double* %123, align 8
  br label %124

; <label>:124:                                    ; preds = %94
  %125 = load i32, i32* %16, align 4
  %126 = add nsw i32 %125, 1
  store i32 %126, i32* %16, align 4
  br label %90

; <label>:127:                                    ; preds = %90
  br label %128

; <label>:128:                                    ; preds = %127
  %129 = load i32, i32* %15, align 4
  %130 = add nsw i32 %129, 1
  store i32 %130, i32* %15, align 4
  br label %76

; <label>:131:                                    ; preds = %76
  br label %132

; <label>:132:                                    ; preds = %131
  %133 = load i32, i32* %14, align 4
  %134 = add nsw i32 %133, 1
  store i32 %134, i32* %14, align 4
  br label %71

; <label>:135:                                    ; preds = %71
  store i32 100, i32* %12, align 4
  store double 0.000000e+00, double* %10, align 8
  call void @timing(double* %6, double* %8)
  store i32 0, i32* %17, align 4
  br label %136

; <label>:136:                                    ; preds = %145, %135
  %137 = load i32, i32* %17, align 4
  %138 = load i32, i32* %12, align 4
  %139 = icmp slt i32 %137, %138
  br i1 %139, label %140, label %148

; <label>:140:                                    ; preds = %136
  call void (%ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%ident_t* @0, i32 6, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, i32*, [2 x double*]*, i32*, i32*, double**)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* %14, i32* %13, [2 x double*]* %22, i32* %19, i32* %18, double** %23)
  %141 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 0
  %142 = load double*, double** %141, align 16
  %143 = getelementptr inbounds [2 x double*], [2 x double*]* %22, i64 0, i64 1
  %144 = load double*, double** %143, align 8
  call void @dummy(double* %142, double* %144)
  br label %145

; <label>:145:                                    ; preds = %140
  %146 = load i32, i32* %17, align 4
  %147 = add nsw i32 %146, 1
  store i32 %147, i32* %17, align 4
  br label %136

; <label>:148:                                    ; preds = %136
  call void @timing(double* %7, double* %9)
  %149 = load double, double* %7, align 8
  %150 = load double, double* %6, align 8
  %151 = fsub double %149, %150
  store double %151, double* %10, align 8
  %152 = load i32, i32* %13, align 4
  %153 = load double, double* %10, align 8
  %154 = load i32, i32* %12, align 4
  %155 = load i32, i32* %12, align 4
  %156 = sitofp i32 %155 to double
  %157 = load i32, i32* %13, align 4
  %158 = sub nsw i32 %157, 2
  %159 = sitofp i32 %158 to double
  %160 = fmul double %156, %159
  %161 = load i32, i32* %13, align 4
  %162 = sub nsw i32 %161, 2
  %163 = sitofp i32 %162 to double
  %164 = fmul double %160, %163
  %165 = load i32, i32* %13, align 4
  %166 = sub nsw i32 %165, 2
  %167 = sitofp i32 %166 to double
  %168 = fmul double %164, %167
  %169 = load double, double* %10, align 8
  %170 = fdiv double %168, %169
  %171 = fdiv double %170, 1.000000e+06
  %172 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.2, i32 0, i32 0), i32 %152, double %153, i32 %154, double %171)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #3

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal void @.omp_outlined.(i32* noalias, i32* noalias, i32* dereferenceable(4), i32* dereferenceable(4), [2 x double*]* dereferenceable(16), i32* dereferenceable(4), i32* dereferenceable(4), double** dereferenceable(8)) #0 {
  %9 = alloca i32*, align 8
  %10 = alloca i32*, align 8
  %11 = alloca i32*, align 8
  %12 = alloca i32*, align 8
  %13 = alloca [2 x double*]*, align 8
  %14 = alloca i32*, align 8
  %15 = alloca i32*, align 8
  %16 = alloca double**, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  store i32* %0, i32** %9, align 8
  store i32* %1, i32** %10, align 8
  store i32* %2, i32** %11, align 8
  store i32* %3, i32** %12, align 8
  store [2 x double*]* %4, [2 x double*]** %13, align 8
  store i32* %5, i32** %14, align 8
  store i32* %6, i32** %15, align 8
  store double** %7, double*** %16, align 8
  %28 = load i32*, i32** %11, align 8
  %29 = load i32*, i32** %12, align 8
  %30 = load [2 x double*]*, [2 x double*]** %13, align 8
  %31 = load i32*, i32** %14, align 8
  %32 = load i32*, i32** %15, align 8
  %33 = load double**, double*** %16, align 8
  %34 = load i32, i32* %29, align 4
  %35 = sub nsw i32 %34, 1
  store i32 %35, i32* %19, align 4
  %36 = load i32, i32* %19, align 4
  %37 = sub nsw i32 %36, 1
  %38 = sub nsw i32 %37, 1
  %39 = add nsw i32 %38, 1
  %40 = sdiv i32 %39, 1
  %41 = sub nsw i32 %40, 1
  store i32 %41, i32* %20, align 4
  store i32 1, i32* %21, align 4
  %42 = load i32, i32* %19, align 4
  %43 = icmp slt i32 1, %42
  br i1 %43, label %44, label %152

; <label>:44:                                     ; preds = %8
  store i32 0, i32* %22, align 4
  %45 = load i32, i32* %20, align 4
  store i32 %45, i32* %23, align 4
  store i32 1, i32* %24, align 4
  store i32 0, i32* %25, align 4
  %46 = load i32*, i32** %9, align 8
  %47 = load i32, i32* %46, align 4
  call void @__kmpc_for_static_init_4(%ident_t* @1, i32 %47, i32 34, i32* %25, i32* %22, i32* %23, i32* %24, i32 1, i32 1)
  %48 = load i32, i32* %23, align 4
  %49 = load i32, i32* %20, align 4
  %50 = icmp sgt i32 %48, %49
  br i1 %50, label %51, label %53

; <label>:51:                                     ; preds = %44
  %52 = load i32, i32* %20, align 4
  br label %55

; <label>:53:                                     ; preds = %44
  %54 = load i32, i32* %23, align 4
  br label %55

; <label>:55:                                     ; preds = %53, %51
  %56 = phi i32 [ %52, %51 ], [ %54, %53 ]
  store i32 %56, i32* %23, align 4
  %57 = load i32, i32* %22, align 4
  store i32 %57, i32* %17, align 4
  br label %58

; <label>:58:                                     ; preds = %145, %55
  %59 = load i32, i32* %17, align 4
  %60 = load i32, i32* %23, align 4
  %61 = icmp sle i32 %59, %60
  br i1 %61, label %62, label %148

; <label>:62:                                     ; preds = %58
  %63 = load i32, i32* %17, align 4
  %64 = mul nsw i32 %63, 1
  %65 = add nsw i32 1, %64
  store i32 %65, i32* %21, align 4
  store i32 1, i32* %26, align 4
  br label %66

; <label>:66:                                     ; preds = %140, %62
  %67 = load i32, i32* %26, align 4
  %68 = load i32, i32* %29, align 4
  %69 = sub nsw i32 %68, 1
  %70 = icmp slt i32 %67, %69
  br i1 %70, label %71, label %143

; <label>:71:                                     ; preds = %66
  %72 = load i32, i32* %21, align 4
  %73 = load i32, i32* %29, align 4
  %74 = mul nsw i32 %72, %73
  %75 = load i32, i32* %29, align 4
  %76 = mul nsw i32 %74, %75
  %77 = load i32, i32* %26, align 4
  %78 = load i32, i32* %29, align 4
  %79 = mul nsw i32 %77, %78
  %80 = add nsw i32 %76, %79
  store i32 %80, i32* %27, align 4
  %81 = load i32, i32* %31, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %82
  %84 = load double*, double** %83, align 8
  %85 = load i32, i32* %27, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds double, double* %84, i64 %86
  %88 = load i32, i32* %32, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %89
  %91 = load double*, double** %90, align 8
  %92 = load i32, i32* %27, align 4
  %93 = sext i32 %92 to i64
  %94 = getelementptr inbounds double, double* %91, i64 %93
  %95 = load i32, i32* %32, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %96
  %98 = load double*, double** %97, align 8
  %99 = load i32, i32* %27, align 4
  %100 = load i32, i32* %29, align 4
  %101 = add nsw i32 %99, %100
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds double, double* %98, i64 %102
  %104 = load i32, i32* %32, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %105
  %107 = load double*, double** %106, align 8
  %108 = load i32, i32* %27, align 4
  %109 = load i32, i32* %29, align 4
  %110 = sub nsw i32 %108, %109
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds double, double* %107, i64 %111
  %113 = load i32, i32* %32, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %114
  %116 = load double*, double** %115, align 8
  %117 = load i32, i32* %27, align 4
  %118 = load i32, i32* %29, align 4
  %119 = load i32, i32* %29, align 4
  %120 = mul nsw i32 %118, %119
  %121 = add nsw i32 %117, %120
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds double, double* %116, i64 %122
  %124 = load i32, i32* %32, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [2 x double*], [2 x double*]* %30, i64 0, i64 %125
  %127 = load double*, double** %126, align 8
  %128 = load i32, i32* %27, align 4
  %129 = load i32, i32* %29, align 4
  %130 = load i32, i32* %29, align 4
  %131 = mul nsw i32 %129, %130
  %132 = sub nsw i32 %128, %131
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds double, double* %127, i64 %133
  %135 = load double*, double** %33, align 8
  %136 = load i32, i32* %27, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds double, double* %135, i64 %137
  %139 = load i32, i32* %29, align 4
  call void @jacobi_line(double* %87, double* %94, double* %103, double* %112, double* %123, double* %134, double* %138, i32 %139)
  br label %140

; <label>:140:                                    ; preds = %71
  %141 = load i32, i32* %26, align 4
  %142 = add nsw i32 %141, 1
  store i32 %142, i32* %26, align 4
  br label %66

; <label>:143:                                    ; preds = %66
  br label %144

; <label>:144:                                    ; preds = %143
  br label %145

; <label>:145:                                    ; preds = %144
  %146 = load i32, i32* %17, align 4
  %147 = add nsw i32 %146, 1
  store i32 %147, i32* %17, align 4
  br label %58

; <label>:148:                                    ; preds = %58
  br label %149

; <label>:149:                                    ; preds = %148
  %150 = load i32*, i32** %9, align 8
  %151 = load i32, i32* %150, align 4
  call void @__kmpc_for_static_fini(%ident_t* @1, i32 %151)
  br label %152

; <label>:152:                                    ; preds = %149, %8
  ret void
}

declare void @__kmpc_fork_call(%ident_t*, i32, void (i32*, i32*, ...)*, ...)

declare void @__kmpc_for_static_init_4(%ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

declare void @__kmpc_for_static_fini(%ident_t*, i32)

; Function Attrs: noinline nounwind optnone uwtable
define void @timing_(double*, double*) #0 {
  %3 = alloca double*, align 8
  %4 = alloca double*, align 8
  store double* %0, double** %3, align 8
  store double* %1, double** %4, align 8
  %5 = load double*, double** %3, align 8
  %6 = load double*, double** %4, align 8
  call void @timing(double* %5, double* %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @timing(double*, double*) #0 {
  %3 = alloca double*, align 8
  %4 = alloca double*, align 8
  %5 = alloca %struct.timeval, align 8
  %6 = alloca %struct.rusage, align 8
  store double* %0, double** %3, align 8
  store double* %1, double** %4, align 8
  %7 = call i32 @gettimeofday(%struct.timeval* %5, %struct.timezone* null) #7
  %8 = getelementptr inbounds %struct.timeval, %struct.timeval* %5, i32 0, i32 0
  %9 = load i64, i64* %8, align 8
  %10 = sitofp i64 %9 to double
  %11 = getelementptr inbounds %struct.timeval, %struct.timeval* %5, i32 0, i32 1
  %12 = load i64, i64* %11, align 8
  %13 = sitofp i64 %12 to double
  %14 = fdiv double %13, 1.000000e+06
  %15 = fadd double %10, %14
  %16 = load double*, double** %3, align 8
  store double %15, double* %16, align 8
  %17 = call i32 @getrusage(i32 0, %struct.rusage* %6) #7
  %18 = getelementptr inbounds %struct.rusage, %struct.rusage* %6, i32 0, i32 0
  %19 = getelementptr inbounds %struct.timeval, %struct.timeval* %18, i32 0, i32 0
  %20 = load i64, i64* %19, align 8
  %21 = sitofp i64 %20 to double
  %22 = getelementptr inbounds %struct.rusage, %struct.rusage* %6, i32 0, i32 0
  %23 = getelementptr inbounds %struct.timeval, %struct.timeval* %22, i32 0, i32 1
  %24 = load i64, i64* %23, align 8
  %25 = sitofp i64 %24 to double
  %26 = fdiv double %25, 1.000000e+06
  %27 = fadd double %21, %26
  %28 = load double*, double** %4, align 8
  store double %27, double* %28, align 8
  ret void
}

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval*, %struct.timezone*) #4

; Function Attrs: nounwind
declare i32 @getrusage(i32, %struct.rusage*) #4

; Function Attrs: noinline nounwind optnone uwtable
define void @dummy_(double*, double*) #0 {
  %3 = alloca double*, align 8
  %4 = alloca double*, align 8
  store double* %0, double** %3, align 8
  store double* %1, double** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @dummy(double*, double*) #0 {
  %3 = alloca double*, align 8
  %4 = alloca double*, align 8
  store double* %0, double** %3, align 8
  store double* %1, double** %4, align 8
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind readonly }
attributes #7 = { nounwind }

!llvm.ident = !{!0, !0, !0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
