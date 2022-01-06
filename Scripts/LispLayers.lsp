(defun c:Layers (/ AcObj ActDoc
	 Cntr Pnt0 
	 e l
	 Pnt1 Pnt2 LyrName LyrLType LyrClr)
 (vl-load-com)

 (setq AcObj (vlax-get-Acad-Object))
 (setq ActDoc (vla-get-ActiveDocument AcObj))
 (vla-EndUndoMark ActDoc)
 (vla-StartUndoMark ActDoc)

 (setq Cntr -1)
 (setq Pnt0 (trans (getpoint "\nBase point")1 0))
 
 (command "_.-style" "LyrNameTxt" "romans.shx" 110 0.8 0 "n" "n" "n") 
 
 (while
   (and
     (setq Lyr (tblnext "LAYER" (null Lyr)))
     (setq LyrName (cdr (assoc 2 Lyr)))
     (setq LyrLType (cdr (assoc 6 Lyr)))
     (setq LyrClr (cdr (assoc 62 Lyr)))
     )

   (if
     (and
  (setq Pnt1 (list (+ (car pnt0) 8000) (cadr pnt0) (caddr pnt0)))
  (setq Pnt2 (list (+ (car pnt0) 8200) (+ (cadr pnt0) 0) (caddr pnt0)))
  )
     (progn
(LyrLnType LyrLType LyrName Pnt0 Pnt1 Pnt2 LyrClr)
(setq Pnt0 (list (car pnt0) (+ (cadr pnt0) -600) (caddr pnt0)))
)
     )

 (vla-EndUndoMark ActDoc)
 )
(princ "\n  RFTRec.lsp ~ Copyright © by HasanCAD")
(princ "\n     ...Type LAYERS to Invoke...   ")
(princ)
 )
;     q_|_|| _\|| q_|| _\|     ;
;       Mainroutine End        ;

;     q_|_|| _\|| q_|| _\|     ;
;       Subroutine Start       ;

(defun LyrLnType (LyrLType LyrName Pnt0 Pnt1 Pnt2 LyrClr / )

 (entmakex (list
      (cons 0  "LINE")
      (cons 6  LyrLType)
             (cons 8  LyrName)
      (cons 10 Pnt0)
             (cons 11 Pnt1)
      (cons 62 LyrClr)
      ))
 (entmakex (list
      (cons 0  "TEXT")
      (cons 1  LyrName)
      (cons 7  "LyrNameTxt")
      (cons 8  LyrName)
      (cons 10 Pnt2)
      (cons 11 Pnt2)
             (cons 40 220)
      (cons 41 0.
      (cons 62 LyrClr)
      (cons 72 0)
      (cons 73 2)
      ))
 )
;     q_|_|| _\|| q_|| _\|     ;
;        Subroutine End        ;