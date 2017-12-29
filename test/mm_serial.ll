; ModuleID = 'MM_serial.cpp'
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

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@firstParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@secondParaMatrix = global [1024 x [1024 x double]] zeroinitializer, align 16
@matrixMultiResult = global [1024 x [1024 x double]] zeroinitializer, align 16
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str = private unnamed_addr constant [7 x i8] c"time: \00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_MM_serial.cpp, i8* null }]

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

; Function Attrs: nounwind uwtable
define void @_Z10matrixInitv() #2 {
entry:
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  store i32 0, i32* %row, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc14, %entry
  %0 = load i32* %row, align 4
  %cmp = icmp slt i32 %0, 1024
  br i1 %cmp, label %for.body, label %for.end16

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %col, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32* %col, align 4
  %cmp2 = icmp slt i32 %1, 1024
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32* %row, align 4
  %3 = load i32* %col, align 4
  %add = add nsw i32 %2, %3
  call void @srand(i32 %add) #1
  %call = call i32 @rand() #1
  %rem = srem i32 %call, 10
  %conv = sitofp i32 %rem to double
  %mul = fmul double %conv, 1.100000e+00
  %4 = load i32* %col, align 4
  %idxprom = sext i32 %4 to i64
  %5 = load i32* %row, align 4
  %idxprom4 = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [1024 x [1024 x double]]* @firstParaMatrix, i32 0, i64 %idxprom4
  %arrayidx5 = getelementptr inbounds [1024 x double]* %arrayidx, i32 0, i64 %idxprom
  store double %mul, double* %arrayidx5, align 8
  %call6 = call i32 @rand() #1
  %rem7 = srem i32 %call6, 10
  %conv8 = sitofp i32 %rem7 to double
  %mul9 = fmul double %conv8, 1.100000e+00
  %6 = load i32* %col, align 4
  %idxprom10 = sext i32 %6 to i64
  %7 = load i32* %row, align 4
  %idxprom11 = sext i32 %7 to i64
  %arrayidx12 = getelementptr inbounds [1024 x [1024 x double]]* @secondParaMatrix, i32 0, i64 %idxprom11
  %arrayidx13 = getelementptr inbounds [1024 x double]* %arrayidx12, i32 0, i64 %idxprom10
  store double %mul9, double* %arrayidx13, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %8 = load i32* %col, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc14

for.inc14:                                        ; preds = %for.end
  %9 = load i32* %row, align 4
  %inc15 = add nsw i32 %9, 1
  store i32 %inc15, i32* %row, align 4
  br label %for.cond

for.end16:                                        ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind
declare void @srand(i32) #3

; Function Attrs: nounwind
declare i32 @rand() #3

; Function Attrs: nounwind uwtable
define void @_Z11matrixMultiv() #2 {
entry:
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  store i32 0, i32* %row, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc6, %entry
  %0 = load i32* %row, align 4
  %cmp = icmp slt i32 %0, 1024
  br i1 %cmp, label %for.body, label %for.end8

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %col, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32* %col, align 4
  %cmp2 = icmp slt i32 %1, 1024
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32* %row, align 4
  %3 = load i32* %col, align 4
  %call = call double @_Z22calcuPartOfMatrixMultiii(i32 %2, i32 %3)
  %4 = load i32* %col, align 4
  %idxprom = sext i32 %4 to i64
  %5 = load i32* %row, align 4
  %idxprom4 = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [1024 x [1024 x double]]* @matrixMultiResult, i32 0, i64 %idxprom4
  %arrayidx5 = getelementptr inbounds [1024 x double]* %arrayidx, i32 0, i64 %idxprom
  store double %call, double* %arrayidx5, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %6 = load i32* %col, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc6

for.inc6:                                         ; preds = %for.end
  %7 = load i32* %row, align 4
  %inc7 = add nsw i32 %7, 1
  store i32 %inc7, i32* %row, align 4
  br label %for.cond

for.end8:                                         ; preds = %for.cond
  ret void
}

; Function Attrs: uwtable
define i32 @main() #4 {
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
declare i64 @clock() #3

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"class.std::basic_ostream"* dereferenceable(272), i8*) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEl(%"class.std::basic_ostream"*, i64) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEPFRSoS_E(%"class.std::basic_ostream"*, %"class.std::basic_ostream"* (%"class.std::basic_ostream"*)*) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"class.std::basic_ostream"* dereferenceable(272)) #0

define internal void @_GLOBAL__sub_I_MM_serial.cpp() section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5.0 (https://github.com/clang-omp/clang a5dbd16db2515a5b2fa82c7dd416d370968646b1) (https://github.com/clang-omp/llvm 1c313aa94183e765c450be6bda3913e22abc3073)"}
