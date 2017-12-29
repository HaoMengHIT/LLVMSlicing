; ModuleID = 'MM.cpp'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type { i32 (...)**, i32 }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type { %"class.std::locale::facet.base", %struct.__locale_struct*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%struct.anon = type { i8 }
%struct.anon.0 = type { i8 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@firstParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@secondParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@matrixMultiResult = global [1024 x [1024 x double]] zeroinitializer, align 16
@.omp.default.loc. = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00"
@.omp.default.loc.2. = private unnamed_addr constant { i32, i32, i32, i32, i8* } { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8]* @.omp.default.loc., i32 0, i32 0) }
@.omp.default.loc.64. = private unnamed_addr constant { i32, i32, i32, i32, i8* } { i32 0, i32 64, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8]* @.omp.default.loc., i32 0, i32 0) }
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str = private unnamed_addr constant [7 x i8] c"time: \00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_MM.cpp, i8* null }]

define internal void @__cxx_global_var_init() section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #1
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind uwtable
define double @_Z22calcuPartOfMatrixMultiii(i32 %row, i32 %col) #2 {
entry:
  %row.addr = alloca i32, align 4
  %col.addr = alloca i32, align 4
  %resultValue = alloca double, align 8
  %transNumber = alloca i32, align 4
  store i32 %row, i32* %row.addr, align 4
  store i32 %col, i32* %col.addr, align 4
  store double 0.000000e+00, double* %resultValue, align 8
  store i32 0, i32* %transNumber, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %transNumber, align 4
  %cmp = icmp slt i32 %0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %transNumber, align 4
  %idxprom = sext i32 %1 to i64
  %2 = load i32* %row.addr, align 4
  %idxprom1 = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds [1024 x [1024 x double]]* @firstParaMatrix, i32 0, i64 %idxprom1
  %arrayidx2 = getelementptr inbounds [1024 x double]* %arrayidx, i32 0, i64 %idxprom
  %3 = load double* %arrayidx2, align 8
  %4 = load i32* %col.addr, align 4
  %idxprom3 = sext i32 %4 to i64
  %5 = load i32* %transNumber, align 4
  %idxprom4 = sext i32 %5 to i64
  %arrayidx5 = getelementptr inbounds [1024 x [1024 x double]]* @secondParaMatrix, i32 0, i64 %idxprom4
  %arrayidx6 = getelementptr inbounds [1024 x double]* %arrayidx5, i32 0, i64 %idxprom3
  %6 = load double* %arrayidx6, align 8
  %mul = fmul double %3, %6
  %7 = load double* %resultValue, align 8
  %add = fadd double %7, %mul
  store double %add, double* %resultValue, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32* %transNumber, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %transNumber, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %9 = load double* %resultValue, align 8
  ret double %9
}

; Function Attrs: uwtable
define void @_Z10matrixInitv() #3 {
entry:
  %agg.captured = alloca %struct.anon, align 1
  %.__kmpc_ident_t.2. = alloca { i32, i32, i32, i32, i8* }, align 8
  %0 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2. to i8*
  %1 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.2. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  %.__kmpc_global_thread_num. = alloca i32, align 4
  %2 = call i32 @__kmpc_global_thread_num({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2.)
  store i32 %2, i32* %.__kmpc_global_thread_num.
  %.gtid. = load i32* %.__kmpc_global_thread_num.
  call void @__kmpc_push_num_threads({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid., i32 64)
  %3 = bitcast %struct.anon* %agg.captured to i8*
  call void @__kmpc_fork_call({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i8*)* @.omp_microtask. to void (i32*, i32*, ...)*), i8* %3)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

declare i32 @__kmpc_global_thread_num({ i32, i32, i32, i32, i8* }*)

declare void @__kmpc_push_num_threads({ i32, i32, i32, i32, i8* }*, i32, i32)

; Function Attrs: uwtable
define internal void @.omp_microtask.(i32*, i32*, i8*) #3 {
entry:
  %.addr = alloca i32*, align 8
  %.addr1 = alloca i32*, align 8
  %.addr2 = alloca i8*, align 8
  %.__kmpc_ident_t.2. = alloca { i32, i32, i32, i32, i8* }, align 8
  %3 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2. to i8*
  %4 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.2. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  %global.ub.stack = alloca i32, align 4
  %debug.ub = alloca i32, align 4
  %last = alloca i32, align 4
  %lb = alloca i32, align 4
  %ub = alloca i32, align 4
  %st = alloca i32, align 4
  %.idx. = alloca i32, align 4
  %_ZZ10matrixInitvE3row.private. = alloca i32, align 4
  %col = alloca i32, align 4
  %.__kmpc_ident_t.64. = alloca { i32, i32, i32, i32, i8* }, align 8
  %5 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.64. to i8*
  %6 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.64. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  store i32 1, i32* %st
  store i32 1, i32* %last
  store i32* %0, i32** %.addr, align 8
  store i32* %1, i32** %.addr1, align 8
  store i8* %2, i8** %.addr2, align 8
  %.__kmpc_global_thread_num. = load i32** %.addr
  %arg3 = load i8** %.addr2
  %"(anon)arg3" = bitcast i8* %arg3 to %struct.anon*
  %.gtid. = load i32* %.__kmpc_global_thread_num.
  store i32 1023, i32* %global.ub.stack
  store i32 1023, i32* %debug.ub
  store i32 0, i32* %lb
  store i32 1023, i32* %ub
  store i32 0, i32* %_ZZ10matrixInitvE3row.private.
  %7 = load i32* %_ZZ10matrixInitvE3row.private., align 4
  %cmp = icmp slt i32 %7, 1024
  br i1 %cmp, label %omp.loop.precond, label %omp.loop.precond_end

omp.loop.precond:                                 ; preds = %entry
  call void @__kmpc_for_static_init_4({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid., i32 34, i32* %last, i32* %lb, i32* %ub, i32* %st, i32 1, i32 0)
  br label %omp.loop.begin

omp.loop.begin:                                   ; preds = %omp.loop.precond
  %8 = load i32* %lb
  store i32 %8, i32* %.idx.
  %9 = load i32* %ub
  %10 = icmp slt i32 %9, 1023
  %11 = select i1 %10, i32 %9, i32 1023
  store i32 %11, i32* %ub
  br label %omp.loop.main

omp.loop.main:                                    ; preds = %omp.cont.block, %omp.loop.begin
  %12 = load i32* %lb
  %13 = load i32* %global.ub.stack
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %omp.lb.le.global_ub., label %omp.loop.end

omp.lb.le.global_ub.:                             ; preds = %omp.loop.main
  store i32 0, i32* %_ZZ10matrixInitvE3row.private., align 4
  %15 = load i32* %.idx., align 4
  %mul = mul nsw i32 %15, 1
  %16 = load i32* %_ZZ10matrixInitvE3row.private., align 4
  %add = add nsw i32 %16, %mul
  store i32 %add, i32* %_ZZ10matrixInitvE3row.private., align 4
  %.idx.3 = load i32* %.idx.
  %17 = load i32* %ub
  %omp.idx.le.ub = icmp sle i32 %.idx.3, %17
  br i1 %omp.idx.le.ub, label %omp.lb_ub.check_pass, label %omp.loop.fini

omp.lb_ub.check_pass:                             ; preds = %omp.lb.le.global_ub.
  store i32 0, i32* %col, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %omp.lb_ub.check_pass
  %18 = load i32* %col, align 4
  %cmp4 = icmp slt i32 %18, 1024
  br i1 %cmp4, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %19 = load i32* %_ZZ10matrixInitvE3row.private., align 4
  %20 = load i32* %col, align 4
  %add5 = add nsw i32 %19, %20
  call void @srand(i32 %add5) #1
  %call = call i32 @rand() #1
  %rem = srem i32 %call, 10
  %conv = sitofp i32 %rem to double
  %mul6 = fmul double %conv, 1.100000e+00
  %21 = load i32* %col, align 4
  %idxprom = sext i32 %21 to i64
  %22 = load i32* %_ZZ10matrixInitvE3row.private., align 4
  %idxprom7 = sext i32 %22 to i64
  %arrayidx = getelementptr inbounds [1024 x [1024 x double]]* @firstParaMatrix, i32 0, i64 %idxprom7
  %arrayidx8 = getelementptr inbounds [1024 x double]* %arrayidx, i32 0, i64 %idxprom
  store double %mul6, double* %arrayidx8, align 8
  %call9 = call i32 @rand() #1
  %rem10 = srem i32 %call9, 10
  %conv11 = sitofp i32 %rem10 to double
  %mul12 = fmul double %conv11, 1.100000e+00
  %23 = load i32* %col, align 4
  %idxprom13 = sext i32 %23 to i64
  %24 = load i32* %_ZZ10matrixInitvE3row.private., align 4
  %idxprom14 = sext i32 %24 to i64
  %arrayidx15 = getelementptr inbounds [1024 x [1024 x double]]* @secondParaMatrix, i32 0, i64 %idxprom14
  %arrayidx16 = getelementptr inbounds [1024 x double]* %arrayidx15, i32 0, i64 %idxprom13
  store double %mul12, double* %arrayidx16, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %25 = load i32* %col, align 4
  %inc = add nsw i32 %25, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %omp.cont.block

omp.cont.block:                                   ; preds = %for.end
  %.idx.17 = load i32* %.idx.
  %.next.idx. = add nsw i32 %.idx.17, 1
  store i32 %.next.idx., i32* %.idx.
  br label %omp.loop.main

omp.loop.fini:                                    ; preds = %omp.lb.le.global_ub.
  br label %omp.loop.end

omp.loop.end:                                     ; preds = %omp.loop.fini, %omp.loop.main
  %.gtid.18 = load i32* %.__kmpc_global_thread_num.
  call void @__kmpc_for_static_fini({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid.18)
  %.gtid.19 = load i32* %.__kmpc_global_thread_num.
  %26 = call i32 @__kmpc_cancel_barrier({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.64., i32 %.gtid.19)
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %omp.cancel_barrier.exit, label %omp.cancel_barrier.continue

omp.cancel_barrier.exit:                          ; preds = %omp.loop.end
  br label %omp.loop.precond_end

omp.cancel_barrier.continue:                      ; preds = %omp.loop.end
  br label %omp.loop.precond_end

omp.loop.precond_end:                             ; preds = %omp.cancel_barrier.exit, %omp.cancel_barrier.continue, %entry
  ret void
}

declare void @__kmpc_for_static_init_4({ i32, i32, i32, i32, i8* }*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: nounwind
declare void @srand(i32) #4

; Function Attrs: nounwind
declare i32 @rand() #4

declare void @__kmpc_for_static_fini({ i32, i32, i32, i32, i8* }*, i32)

declare i32 @__kmpc_cancel_barrier({ i32, i32, i32, i32, i8* }*, i32)

declare void @__kmpc_fork_call({ i32, i32, i32, i32, i8* }*, i32, void (i32*, i32*, ...)*, i8*)

; Function Attrs: uwtable
define void @_Z11matrixMultiv() #3 {
entry:
  %agg.captured = alloca %struct.anon.0, align 1
  %.__kmpc_ident_t.2. = alloca { i32, i32, i32, i32, i8* }, align 8
  %0 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2. to i8*
  %1 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.2. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  %.__kmpc_global_thread_num. = alloca i32, align 4
  %2 = call i32 @__kmpc_global_thread_num({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2.)
  store i32 %2, i32* %.__kmpc_global_thread_num.
  %.gtid. = load i32* %.__kmpc_global_thread_num.
  call void @__kmpc_push_num_threads({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid., i32 64)
  %3 = bitcast %struct.anon.0* %agg.captured to i8*
  call void @__kmpc_fork_call({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 2, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i8*)* @.omp_microtask.1 to void (i32*, i32*, ...)*), i8* %3)
  ret void
}

; Function Attrs: uwtable
define internal void @.omp_microtask.1(i32*, i32*, i8*) #3 {
entry:
  %.addr = alloca i32*, align 8
  %.addr1 = alloca i32*, align 8
  %.addr2 = alloca i8*, align 8
  %.__kmpc_ident_t.2. = alloca { i32, i32, i32, i32, i8* }, align 8
  %3 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2. to i8*
  %4 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.2. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %4, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  %global.ub.stack = alloca i32, align 4
  %debug.ub = alloca i32, align 4
  %last = alloca i32, align 4
  %lb = alloca i32, align 4
  %ub = alloca i32, align 4
  %st = alloca i32, align 4
  %.idx. = alloca i32, align 4
  %_ZZ11matrixMultivE3row.private. = alloca i32, align 4
  %col = alloca i32, align 4
  %.__kmpc_ident_t.64. = alloca { i32, i32, i32, i32, i8* }, align 8
  %5 = bitcast { i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.64. to i8*
  %6 = bitcast { i32, i32, i32, i32, i8* }* @.omp.default.loc.64. to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 ptrtoint ({ i32, i32, i32, i32, i8* }* getelementptr ({ i32, i32, i32, i32, i8* }* null, i32 1) to i64), i32 8, i1 false)
  store i32 1, i32* %st
  store i32 1, i32* %last
  store i32* %0, i32** %.addr, align 8
  store i32* %1, i32** %.addr1, align 8
  store i8* %2, i8** %.addr2, align 8
  %.__kmpc_global_thread_num. = load i32** %.addr
  %arg3 = load i8** %.addr2
  %"(anon)arg3" = bitcast i8* %arg3 to %struct.anon.0*
  %.gtid. = load i32* %.__kmpc_global_thread_num.
  store i32 1023, i32* %global.ub.stack
  store i32 1023, i32* %debug.ub
  store i32 0, i32* %lb
  store i32 1023, i32* %ub
  store i32 0, i32* %_ZZ11matrixMultivE3row.private.
  %7 = load i32* %_ZZ11matrixMultivE3row.private., align 4
  %cmp = icmp slt i32 %7, 1024
  br i1 %cmp, label %omp.loop.precond, label %omp.loop.precond_end

omp.loop.precond:                                 ; preds = %entry
  call void @__kmpc_for_static_init_4({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid., i32 34, i32* %last, i32* %lb, i32* %ub, i32* %st, i32 1, i32 0)
  br label %omp.loop.begin

omp.loop.begin:                                   ; preds = %omp.loop.precond
  %8 = load i32* %lb
  store i32 %8, i32* %.idx.
  %9 = load i32* %ub
  %10 = icmp slt i32 %9, 1023
  %11 = select i1 %10, i32 %9, i32 1023
  store i32 %11, i32* %ub
  br label %omp.loop.main

omp.loop.main:                                    ; preds = %omp.cont.block, %omp.loop.begin
  %12 = load i32* %lb
  %13 = load i32* %global.ub.stack
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %omp.lb.le.global_ub., label %omp.loop.end

omp.lb.le.global_ub.:                             ; preds = %omp.loop.main
  store i32 0, i32* %_ZZ11matrixMultivE3row.private., align 4
  %15 = load i32* %.idx., align 4
  %mul = mul nsw i32 %15, 1
  %16 = load i32* %_ZZ11matrixMultivE3row.private., align 4
  %add = add nsw i32 %16, %mul
  store i32 %add, i32* %_ZZ11matrixMultivE3row.private., align 4
  %.idx.3 = load i32* %.idx.
  %17 = load i32* %ub
  %omp.idx.le.ub = icmp sle i32 %.idx.3, %17
  br i1 %omp.idx.le.ub, label %omp.lb_ub.check_pass, label %omp.loop.fini

omp.lb_ub.check_pass:                             ; preds = %omp.lb.le.global_ub.
  store i32 0, i32* %col, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %omp.lb_ub.check_pass
  %18 = load i32* %col, align 4
  %cmp4 = icmp slt i32 %18, 1024
  br i1 %cmp4, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %19 = load i32* %_ZZ11matrixMultivE3row.private., align 4
  %20 = load i32* %col, align 4
  %call = invoke double @_Z22calcuPartOfMatrixMultiii(i32 %19, i32 %20)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %for.body
  %21 = load i32* %col, align 4
  %idxprom = sext i32 %21 to i64
  %22 = load i32* %_ZZ11matrixMultivE3row.private., align 4
  %idxprom5 = sext i32 %22 to i64
  %arrayidx = getelementptr inbounds [1024 x [1024 x double]]* @matrixMultiResult, i32 0, i64 %idxprom5
  %arrayidx6 = getelementptr inbounds [1024 x double]* %arrayidx, i32 0, i64 %idxprom
  store double %call, double* %arrayidx6, align 8
  br label %for.inc

for.inc:                                          ; preds = %invoke.cont
  %23 = load i32* %col, align 4
  %inc = add nsw i32 %23, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  br label %omp.cont.block

omp.cont.block:                                   ; preds = %for.end
  %.idx.7 = load i32* %.idx.
  %.next.idx. = add nsw i32 %.idx.7, 1
  store i32 %.next.idx., i32* %.idx.
  br label %omp.loop.main

omp.loop.fini:                                    ; preds = %omp.lb.le.global_ub.
  br label %omp.loop.end

omp.loop.end:                                     ; preds = %omp.loop.fini, %omp.loop.main
  %.gtid.8 = load i32* %.__kmpc_global_thread_num.
  call void @__kmpc_for_static_fini({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.2., i32 %.gtid.8)
  %.gtid.9 = load i32* %.__kmpc_global_thread_num.
  %24 = call i32 @__kmpc_cancel_barrier({ i32, i32, i32, i32, i8* }* %.__kmpc_ident_t.64., i32 %.gtid.9)
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %omp.cancel_barrier.exit, label %omp.cancel_barrier.continue

omp.cancel_barrier.exit:                          ; preds = %omp.loop.end
  br label %omp.loop.precond_end

omp.cancel_barrier.continue:                      ; preds = %omp.loop.end
  br label %omp.loop.precond_end

omp.loop.precond_end:                             ; preds = %omp.cancel_barrier.exit, %omp.cancel_barrier.continue, %entry
  ret void

terminate.lpad:                                   ; preds = %for.body
  %26 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %27 = extractvalue { i8*, i32 } %26, 0
  call void @__clang_call_terminate(i8* %27) #6
  unreachable
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #1
  call void @_ZSt9terminatev() #6
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: uwtable
define i32 @main() #3 {
entry:
  %retval = alloca i32, align 4
  %t1 = alloca i64, align 8
  %t2 = alloca i64, align 8
  store i32 0, i32* %retval
  call void @_Z10matrixInitv()
  %call = call i64 @clock() #1
  store i64 %call, i64* %t1, align 8
  call void @_Z11matrixMultiv()
  %call1 = call i64 @clock() #1
  store i64 %call1, i64* %t2, align 8
  %call2 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272) @_ZSt4cout, i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0))
  %0 = load i64* %t2, align 8
  %1 = load i64* %t1, align 8
  %sub = sub nsw i64 %0, %1
  %call3 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEl(%"class.std::basic_ostream"* %call2, i64 %sub)
  %call4 = call dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"* %call3, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @clock() #4

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272), i8*) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEl(%"class.std::basic_ostream"*, i64) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"*, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)*) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* dereferenceable(272)) #0

define internal void @_GLOBAL__sub_I_MM.cpp() section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5.0 (https://github.com/clang-omp/clang a5dbd16db2515a5b2fa82c7dd416d370968646b1) (https://github.com/clang-omp/llvm 1c313aa94183e765c450be6bda3913e22abc3073)"}
