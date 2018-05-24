; ModuleID = 'sum_readfile.ll'
source_filename = "sum_readfile.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@sum = local_unnamed_addr global i32 0, align 4
@.str = private unnamed_addr constant [8 x i8] c"num.txt\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.3 = private unnamed_addr constant [22 x i8] c"start = %d, end = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Init sum = %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"Final sum = %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z6getsumii(i32, i32) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %1, %0
  br i1 %3, label %.lr.ph, label %42

.lr.ph:                                           ; preds = %2
  %sum.promoted = load i32, i32* @sum, align 4
  %4 = sub i32 %1, %0
  %5 = add i32 %1, -1
  %6 = sub i32 %5, %0
  %xtraiter = and i32 %4, 3
  %7 = icmp ult i32 %6, 3
  br i1 %7, label %._crit_edge.unr-lcssa, label %.lr.ph.new

.lr.ph.new:                                       ; preds = %.lr.ph
  %unroll_iter = sub i32 %4, %xtraiter
  br label %8

; <label>:8:                                      ; preds = %8, %.lr.ph.new
  %9 = phi i32 [ %sum.promoted, %.lr.ph.new ], [ %32, %8 ]
  %.05 = phi i32 [ %0, %.lr.ph.new ], [ %33, %8 ]
  %niter = phi i32 [ %unroll_iter, %.lr.ph.new ], [ %niter.nsub.3, %8 ]
  %10 = sitofp i32 %.05 to double
  %11 = tail call double @sqrt(double %10) #4
  %12 = sitofp i32 %9 to double
  %13 = fadd double %11, %12
  %14 = fptosi double %13 to i32
  %15 = add nsw i32 %.05, 1
  %16 = sitofp i32 %15 to double
  %17 = tail call double @sqrt(double %16) #4
  %18 = sitofp i32 %14 to double
  %19 = fadd double %17, %18
  %20 = fptosi double %19 to i32
  %21 = add nsw i32 %.05, 2
  %22 = sitofp i32 %21 to double
  %23 = tail call double @sqrt(double %22) #4
  %24 = sitofp i32 %20 to double
  %25 = fadd double %23, %24
  %26 = fptosi double %25 to i32
  %27 = add nsw i32 %.05, 3
  %28 = sitofp i32 %27 to double
  %29 = tail call double @sqrt(double %28) #4
  %30 = sitofp i32 %26 to double
  %31 = fadd double %29, %30
  %32 = fptosi double %31 to i32
  %33 = add nsw i32 %.05, 4
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %._crit_edge.unr-lcssa.loopexit, label %8

._crit_edge.unr-lcssa.loopexit:                   ; preds = %8
  br label %._crit_edge.unr-lcssa

._crit_edge.unr-lcssa:                            ; preds = %._crit_edge.unr-lcssa.loopexit, %.lr.ph
  %.lcssa.ph = phi i32 [ undef, %.lr.ph ], [ %32, %._crit_edge.unr-lcssa.loopexit ]
  %.unr = phi i32 [ %sum.promoted, %.lr.ph ], [ %32, %._crit_edge.unr-lcssa.loopexit ]
  %.05.unr = phi i32 [ %0, %.lr.ph ], [ %33, %._crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %._crit_edge, label %.epil.preheader

.epil.preheader:                                  ; preds = %._crit_edge.unr-lcssa
  br label %34

; <label>:34:                                     ; preds = %34, %.epil.preheader
  %35 = phi i32 [ %.unr, %.epil.preheader ], [ %40, %34 ]
  %.05.epil = phi i32 [ %.05.unr, %.epil.preheader ], [ %41, %34 ]
  %epil.iter = phi i32 [ %xtraiter, %.epil.preheader ], [ %epil.iter.sub, %34 ]
  %36 = sitofp i32 %.05.epil to double
  %37 = tail call double @sqrt(double %36) #4
  %38 = sitofp i32 %35 to double
  %39 = fadd double %37, %38
  %40 = fptosi double %39 to i32
  %41 = add nsw i32 %.05.epil, 1
  %epil.iter.sub = add i32 %epil.iter, -1
  %epil.iter.cmp = icmp eq i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %._crit_edge.epilog-lcssa, label %34, !llvm.loop !1

._crit_edge.epilog-lcssa:                         ; preds = %34
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.unr-lcssa, %._crit_edge.epilog-lcssa
  %.lcssa = phi i32 [ %.lcssa.ph, %._crit_edge.unr-lcssa ], [ %40, %._crit_edge.epilog-lcssa ]
  store i32 %.lcssa, i32* @sum, align 4
  br label %42

; <label>:42:                                     ; preds = %._crit_edge, %2
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z8readFileRiS_(i32* dereferenceable(4), i32* dereferenceable(4)) local_unnamed_addr #0 {
  %3 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  %4 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fscanf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32* nonnull %0, i32* nonnull %1)
  %5 = load i32, i32* %0, align 4
  %6 = load i32, i32* %1, align 4
  %7 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i64 0, i64 0), i32 %5, i32 %6)
  %8 = tail call i32 @fclose(%struct._IO_FILE* %3)
  ret void
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @fscanf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #1

; Function Attrs: norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #2 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)) #5
  %4 = call i32 (%struct._IO_FILE*, i8*, ...) @fscanf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32* nonnull %1, i32* nonnull %2) #5
  %5 = load i32, i32* %1, align 4
  %6 = load i32, i32* %2, align 4
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.3, i64 0, i64 0), i32 %5, i32 %6) #5
  %8 = call i32 @fclose(%struct._IO_FILE* %3) #5
  %9 = load i32, i32* @sum, align 4
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.4, i64 0, i64 0), i32 %9)
  %11 = load i32, i32* %1, align 4
  %12 = load i32, i32* %2, align 4
  %13 = icmp sgt i32 %12, %11
  %sum.promoted.i = load i32, i32* @sum, align 4
  br i1 %13, label %.lr.ph.i.preheader, label %_Z6getsumii.exit

.lr.ph.i.preheader:                               ; preds = %0
  %14 = sub i32 %12, %11
  %15 = add i32 %12, -1
  %16 = sub i32 %15, %11
  %xtraiter = and i32 %14, 3
  %17 = icmp ult i32 %16, 3
  br i1 %17, label %._crit_edge.i.unr-lcssa, label %.lr.ph.i.preheader.new

.lr.ph.i.preheader.new:                           ; preds = %.lr.ph.i.preheader
  %unroll_iter = sub i32 %14, %xtraiter
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %.lr.ph.i.preheader.new
  %18 = phi i32 [ %sum.promoted.i, %.lr.ph.i.preheader.new ], [ %41, %.lr.ph.i ]
  %.05.i = phi i32 [ %11, %.lr.ph.i.preheader.new ], [ %42, %.lr.ph.i ]
  %niter = phi i32 [ %unroll_iter, %.lr.ph.i.preheader.new ], [ %niter.nsub.3, %.lr.ph.i ]
  %19 = sitofp i32 %.05.i to double
  %20 = call double @sqrt(double %19) #4
  %21 = sitofp i32 %18 to double
  %22 = fadd double %21, %20
  %23 = fptosi double %22 to i32
  %24 = add nsw i32 %.05.i, 1
  %25 = sitofp i32 %24 to double
  %26 = call double @sqrt(double %25) #4
  %27 = sitofp i32 %23 to double
  %28 = fadd double %27, %26
  %29 = fptosi double %28 to i32
  %30 = add nsw i32 %.05.i, 2
  %31 = sitofp i32 %30 to double
  %32 = call double @sqrt(double %31) #4
  %33 = sitofp i32 %29 to double
  %34 = fadd double %33, %32
  %35 = fptosi double %34 to i32
  %36 = add nsw i32 %.05.i, 3
  %37 = sitofp i32 %36 to double
  %38 = call double @sqrt(double %37) #4
  %39 = sitofp i32 %35 to double
  %40 = fadd double %39, %38
  %41 = fptosi double %40 to i32
  %42 = add nsw i32 %.05.i, 4
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %._crit_edge.i.unr-lcssa.loopexit, label %.lr.ph.i

._crit_edge.i.unr-lcssa.loopexit:                 ; preds = %.lr.ph.i
  br label %._crit_edge.i.unr-lcssa

._crit_edge.i.unr-lcssa:                          ; preds = %._crit_edge.i.unr-lcssa.loopexit, %.lr.ph.i.preheader
  %.lcssa.ph = phi i32 [ undef, %.lr.ph.i.preheader ], [ %41, %._crit_edge.i.unr-lcssa.loopexit ]
  %.unr = phi i32 [ %sum.promoted.i, %.lr.ph.i.preheader ], [ %41, %._crit_edge.i.unr-lcssa.loopexit ]
  %.05.i.unr = phi i32 [ %11, %.lr.ph.i.preheader ], [ %42, %._crit_edge.i.unr-lcssa.loopexit ]
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %._crit_edge.i, label %.lr.ph.i.epil.preheader

.lr.ph.i.epil.preheader:                          ; preds = %._crit_edge.i.unr-lcssa
  br label %.lr.ph.i.epil

.lr.ph.i.epil:                                    ; preds = %.lr.ph.i.epil, %.lr.ph.i.epil.preheader
  %43 = phi i32 [ %48, %.lr.ph.i.epil ], [ %.unr, %.lr.ph.i.epil.preheader ]
  %.05.i.epil = phi i32 [ %49, %.lr.ph.i.epil ], [ %.05.i.unr, %.lr.ph.i.epil.preheader ]
  %epil.iter = phi i32 [ %epil.iter.sub, %.lr.ph.i.epil ], [ %xtraiter, %.lr.ph.i.epil.preheader ]
  %44 = sitofp i32 %.05.i.epil to double
  %45 = call double @sqrt(double %44) #4
  %46 = sitofp i32 %43 to double
  %47 = fadd double %46, %45
  %48 = fptosi double %47 to i32
  %49 = add nsw i32 %.05.i.epil, 1
  %epil.iter.sub = add i32 %epil.iter, -1
  %epil.iter.cmp = icmp eq i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %._crit_edge.i.epilog-lcssa, label %.lr.ph.i.epil, !llvm.loop !3

._crit_edge.i.epilog-lcssa:                       ; preds = %.lr.ph.i.epil
  br label %._crit_edge.i

._crit_edge.i:                                    ; preds = %._crit_edge.i.unr-lcssa, %._crit_edge.i.epilog-lcssa
  %.lcssa = phi i32 [ %.lcssa.ph, %._crit_edge.i.unr-lcssa ], [ %48, %._crit_edge.i.epilog-lcssa ]
  store i32 %.lcssa, i32* @sum, align 4
  br label %_Z6getsumii.exit

_Z6getsumii.exit:                                 ; preds = %0, %._crit_edge.i
  %50 = phi i32 [ %.lcssa, %._crit_edge.i ], [ %sum.promoted.i, %0 ]
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i32 %50)
  ret i32 0
}

; Function Attrs: nounwind readnone
declare double @sqrt(double) local_unnamed_addr #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1-17ubuntu1 (tags/RELEASE_391/rc2)"}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
