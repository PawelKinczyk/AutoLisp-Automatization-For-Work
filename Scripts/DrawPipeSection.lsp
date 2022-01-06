(defun c:PROFIL ( / *error* ; *error* has to be always localized !!!
		 clay cmde P1 SLOPE DIST x1 y1 z1 P2 P3 PKT P4 x4 y4 z4 P5 x5 y5 z5 P6)
  
  (defun *error* (errmsg)
    (if (not (wcmatch errmsg "Function cancelled,quit / exit abort,console break,end"))
      (princ (strcat "\nError: " errmsg)))
    (if clay (setvar 'CLAYER clay))
    (if cmde (setvar 'CMDECHO cmde))
    (princ))
  
  
  (setq clay (getvar 'clayer)
	cmde (getvar 'cmdecho)
	oldsnap (getvar 'osmode))

  (setvar 'cmdecho 0)
  (command "_.-layer" "_t" "IS_inst ks pod plyta" "_m" "IS_inst ks pod plyta" "_c" 30 "" "_u" "IS_inst ks pod plyta" "") ;!!!! change name of layer for more "international" without special text :p
  
  (if (and(setq P1 (getpoint "\nSpecify starting point: "))
(setq P4 (getpoint "\n0 point: "))
	  (setq P5 (getpoint "\nDown level: ")))

	(while (and (or (setq SLOPE (getreal "\nSlope <new starting point or exit>: "))
		    (and (setq P1 (getpoint "\nSpecify starting point <exit>: "))
			 (setq SLOPE (getreal "\nSlope: "))))
		(setq DIST (getdist "\nMeasure distance: "))
		(setq PKT (getstring "\nPoint_or_45degree: "))
		)	

      (setq x1 (car P1)
	    y1 (cadr P1)
	    z1 (caddr P1))

      (setq x4 (car P4)
	    y4 (cadr P4)
	    z4 (caddr P4))
      (setq x5 (car P5)
	    y5 (cadr P5)
	    z5 (caddr P5))
      
      (setq P2 (list (- x1 DIST)
		     (- y1 (* DIST (/ SLOPE 100.)))  ; be carefull with integers - always at least one must be real to get real as result. (/ 5 2) see what result is. (but SLOPE is always real so you are good in this)
		     z1))
      
      (setq P3 (list (- x1 DIST)
		     y5
		     z1))
(setq P6 (list (- x1 DIST)
		     y4
		     z1))
  (command "_.-layer" "_t" "IS_inst ks pod plyta" "_m" "IS_inst ks pod plyta" "_c" 30 "" "_u" "IS_inst ks pod plyta" "") ;!!!! change name of layer for more "international" without special text :p
      
      (command "pline" "non" P1 "non" P2 "") ;my instalation
      (command "pline" "non" P2 "non" P3 "") ;draw line down
(command "_.-layer" "_t" "Liczby" "_m" "Liczby" "_c" "white" "" "_u" "Liczby" "")
      (command "_.text" "BC" "_none" P3 50. 0 PKT) ;write text of sanitary point
(command "_.-layer" "_t" "IS_ramka" "_m" "IS_ramka" "_c" "white" "" "_u" "IS_ramka" "")
      (command "_.dimaligned" P2 P3 P3)
(command "_.dimaligned" P2 P6 P6)
	    (setq P1 P2)
      ))
  (*error* "end")
  (setvar 'osmode oldsnap)
  )