(defun C:KSANITARNA ()

  (setvar 'plinewid (GETREAL "PODAJ SREDNICE") )

  (setvar 'clayer "NEWLAYER")

  (command "_pline")
  (while (> (getvar "CMDACTIVE") 0) (command pause))
   (setvar 'plinewid 0)
(princ)
 )
