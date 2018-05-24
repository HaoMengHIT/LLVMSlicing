; ModuleID = 'result.ll'
source_filename = "MM_serial.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@firstParaMatrix = local_unnamed_addr global [1024 x [1024 x double]] zeroinitializer, align 16
@secondParaMatrix = local_unnamed_addr global [1024 x [1024 x double]] zeroinitializer, align 16
@matrixMultiResult = local_unnamed_addr global [1024 x [1024 x double]] zeroinitializer, align 16
@llvm.global_ctors = appending global [0 x { i32, void ()*, i8* }] zeroinitializer

; Function Attrs: norecurse nounwind readnone uwtable
define double @_Z22calcuPartOfMatrixMultiii(i32, i32) local_unnamed_addr #0 {
  ret double undef
}

; Function Attrs: norecurse nounwind readnone uwtable
define void @_Z10matrixInitv() local_unnamed_addr #0 {
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define void @_Z11matrixMultiv() local_unnamed_addr #0 {
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define i32 @main() local_unnamed_addr #0 {
  ret i32 undef
}

attributes #0 = { norecurse nounwind readnone uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1-4ubuntu3~16.04.2 (tags/RELEASE_391/rc2)"}
