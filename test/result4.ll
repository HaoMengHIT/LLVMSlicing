; ModuleID = 'sum_readfile_O3.ll'
source_filename = "sum_readfile.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@sum = local_unnamed_addr global i32 0, align 4
@.str = private unnamed_addr constant [8 x i8] c"num.txt\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"r\00", align 1

; Function Attrs: nounwind uwtable
define void @_Z6getsumii(i32, i32) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %1, %0
  br i1 %3, label %.lr.ph, label %10

.lr.ph:                                           ; preds = %2
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
  %niter = phi i32 [ %unroll_iter, %.lr.ph.new ], [ %niter.nsub.3, %8 ]
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %._crit_edge.unr-lcssa.loopexit, label %8

._crit_edge.unr-lcssa.loopexit:                   ; preds = %8
  br label %._crit_edge.unr-lcssa

._crit_edge.unr-lcssa:                            ; preds = %._crit_edge.unr-lcssa.loopexit, %.lr.ph
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %._crit_edge, label %.epil.preheader

.epil.preheader:                                  ; preds = %._crit_edge.unr-lcssa
  br label %9

; <label>:9:                                      ; preds = %9, %.epil.preheader
  %epil.iter = phi i32 [ %xtraiter, %.epil.preheader ], [ %epil.iter.sub, %9 ]
  %epil.iter.sub = add i32 %epil.iter, -1
  %epil.iter.cmp = icmp eq i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %._crit_edge.epilog-lcssa, label %9, !llvm.loop !1

._crit_edge.epilog-lcssa:                         ; preds = %9
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.epilog-lcssa, %._crit_edge.unr-lcssa
  br label %10

; <label>:10:                                     ; preds = %._crit_edge, %2
  ret void
}

; Function Attrs: nounwind uwtable
define void @_Z8readFileRiS_(i32* dereferenceable(4), i32* dereferenceable(4)) local_unnamed_addr #0 {
  %3 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #1

; Function Attrs: norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #2 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)) #3
  %4 = load i32, i32* %1, align 4
  %5 = load i32, i32* %2, align 4
  %6 = icmp sgt i32 %5, %4
  br i1 %6, label %.lr.ph.i.preheader, label %_Z6getsumii.exit

.lr.ph.i.preheader:                               ; preds = %0
  %7 = sub i32 %5, %4
  %8 = add i32 %5, -1
  %9 = sub i32 %8, %4
  %xtraiter = and i32 %7, 3
  %10 = icmp ult i32 %9, 3
  br i1 %10, label %._crit_edge.i.unr-lcssa, label %.lr.ph.i.preheader.new

.lr.ph.i.preheader.new:                           ; preds = %.lr.ph.i.preheader
  %unroll_iter = sub i32 %7, %xtraiter
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %.lr.ph.i.preheader.new
  %niter = phi i32 [ %unroll_iter, %.lr.ph.i.preheader.new ], [ %niter.nsub.3, %.lr.ph.i ]
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %._crit_edge.i.unr-lcssa.loopexit, label %.lr.ph.i

._crit_edge.i.unr-lcssa.loopexit:                 ; preds = %.lr.ph.i
  br label %._crit_edge.i.unr-lcssa

._crit_edge.i.unr-lcssa:                          ; preds = %._crit_edge.i.unr-lcssa.loopexit, %.lr.ph.i.preheader
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %._crit_edge.i, label %.lr.ph.i.epil.preheader

.lr.ph.i.epil.preheader:                          ; preds = %._crit_edge.i.unr-lcssa
  br label %.lr.ph.i.epil

.lr.ph.i.epil:                                    ; preds = %.lr.ph.i.epil, %.lr.ph.i.epil.preheader
  %epil.iter = phi i32 [ %epil.iter.sub, %.lr.ph.i.epil ], [ %xtraiter, %.lr.ph.i.epil.preheader ]
  %epil.iter.sub = add i32 %epil.iter, -1
  %epil.iter.cmp = icmp eq i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %._crit_edge.i.epilog-lcssa, label %.lr.ph.i.epil, !llvm.loop !3

._crit_edge.i.epilog-lcssa:                       ; preds = %.lr.ph.i.epil
  br label %._crit_edge.i

._crit_edge.i:                                    ; preds = %._crit_edge.i.epilog-lcssa, %._crit_edge.i.unr-lcssa
  br label %_Z6getsumii.exit

_Z6getsumii.exit:                                 ; preds = %._crit_edge.i, %0
  ret i32 undef
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1-17ubuntu1 (tags/RELEASE_391/rc2)"}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
