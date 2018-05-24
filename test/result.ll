; ModuleID = 'sum_serial.ll'
source_filename = "sum_serial.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sum = global [2 x i32] zeroinitializer, align 4

; Function Attrs: nounwind uwtable
define void @getsum() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

; <label>:2:                                      ; preds = %13, %0
  %3 = load i32, i32* %1, align 4
  %4 = icmp slt i32 %3, 100
  br i1 %4, label %5, label %16

; <label>:5:                                      ; preds = %2
  %6 = load i32, i32* %1, align 4
  %7 = sitofp i32 %6 to double
  %8 = call double @sqrt(double %7) #2
  %9 = load i32, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
  %10 = sitofp i32 %9 to double
  %11 = fadd double %10, %8
  %12 = fptosi double %11 to i32
  store i32 %12, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
  br label %13

; <label>:13:                                     ; preds = %5
  %14 = load i32, i32* %1, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %1, align 4
  br label %2

; <label>:16:                                     ; preds = %2
  ret void
}

; Function Attrs: nounwind
declare double @sqrt(double) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  call void @getsum()
  %1 = load i32, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @sum, i64 0, i64 0), align 4
  %2 = icmp sge i32 %1, 10000
  br i1 %2, label %3, label %4

; <label>:3:                                      ; preds = %0
  br label %5

; <label>:4:                                      ; preds = %0
  br label %5

; <label>:5:                                      ; preds = %4, %3
  ret i32 undef
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1-4ubuntu3~16.04.2 (tags/RELEASE_391/rc2)"}
