(defun c:CZYSZCZ  (/ aDoc name)
     (setvar 'Clayer "0")
     (repeat 4
           (vla-purgeall
                 (setq aDoc (vla-get-ActiveDocument
                                  (vlax-get-acad-object)))))
     (vlax-for
            itm
                 (vla-get-layers aDoc)
           (if (and
                     (not (wcmatch
                                (setq name (vla-get-name itm))
                                "*|*"))
                     (not (eq name "0"))
                     (not (member name
                                  '("IS_Armatura_pod³¹czeniowa_grz._dolnozas."
"IS_Armatura_Therm"
"IS_Text_Odbiornikow_Therm" 
"IS_Grzejniki_Plan_rzutlayer1"
"IS_Grzejniki_Plan_rzut"
                                    ))))
                 (progn
                       (vla-put-lock itm :vlax-false)
                       (vl-cmdf "_.-laydel" "_N" name "" "_Y"))
                 )
           )
     (repeat 4 (vla-purgeall aDoc))
     (princ)
     )