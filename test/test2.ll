; ModuleID = 'test.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"Sum = %d\0A\00", align 1
@str = private unnamed_addr constant [6 x i8] c"Error\00"

; Function Attrs: nounwind uwtable
define i32 @sumFunc(i32 %num) #0 {
entry:
  %cmp5 = icmp sgt i32 %num, 0
  br i1 %cmp5, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.07 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %sum.06 = phi i32 [ %conv3, %for.body ], [ 0, %for.body.preheader ]
  %conv = sitofp i32 %i.07 to double
  %call = tail call double @sqrt(double %conv) #2
  %mul = fmul double %conv, %call
  %conv2 = sitofp i32 %sum.06 to double
  %add = fadd double %conv2, %mul
  %conv3 = fptosi double %add to i32
  %inc = add nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %inc, %num
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  %conv3.lcssa = phi i32 [ %conv3, %for.body ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %sum.0.lcssa = phi i32 [ 0, %entry ], [ %conv3.lcssa, %for.end.loopexit ]
  ret i32 %sum.0.lcssa
}

; Function Attrs: nounwind
declare double @sqrt(double) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %entry
  %i.07.i = phi i32 [ %inc.i, %for.body.i ], [ 0, %entry ]
  %sum.06.i = phi i32 [ %conv3.i, %for.body.i ], [ 0, %entry ]
  %conv.i = sitofp i32 %i.07.i to double
  %call.i = tail call double @sqrt(double %conv.i) #2
  %mul.i = fmul double %conv.i, %call.i
  %conv2.i = sitofp i32 %sum.06.i to double
  %add.i = fadd double %conv2.i, %mul.i
  %conv3.i = fptosi double %add.i to i32
  %inc.i = add nsw i32 %i.07.i, 1
  %exitcond.i = icmp eq i32 %inc.i, 100
  br i1 %exitcond.i, label %sumFunc.exit, label %for.body.i

sumFunc.exit:                                     ; preds = %for.body.i
  %conv3.i.lcssa = phi i32 [ %conv3.i, %for.body.i ]
  %cmp = icmp sgt i32 %conv3.i.lcssa, 10000
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %sumFunc.exit
  %call1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), i32 %conv3.i.lcssa) #2
  br label %if.end

if.else:                                          ; preds = %sumFunc.exit
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str, i64 0, i64 0))
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5.0 (https://github.com/clang-omp/clang a5dbd16db2515a5b2fa82c7dd416d370968646b1) (https://github.com/clang-omp/llvm 1c313aa94183e765c450be6bda3913e22abc3073)"}
