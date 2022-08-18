;;(defun c:test (/newFontFile style styleGet styleName)
;;(setq newFontFile "romand.shx")
;;(setq styleName (getvar "textstyle")) 
;;(setq style (tblobjname "style" styleName))
;;(setq styleGet (entget style))
;;(setq styleGet (subst (cons 3 newFontFile) (assoc 3 styleGet) styleGet))
;;(entmod styleGet)
;;(entupd style)
;;(princ)

;;(defun C:CGSTYLE (/ len count ent ent_data ent_name new_style_name)
;; (c:TXTSTY)
 ;;(c:CHGMTEXT)
 ;;)

;;(defun c:TXTSTY ()
;;(commande "-style" "NEWSTYLE" "ROMANS.SHX" "3/32" "1" "0" "N" "N" "N")
;;)
;;(defun C:CHGMTEXT ( / ss )
;;(setq ss (ssget "X" (liste (contre 0 "MTEXT"))))
;;(si ss
;;(prog
;;(setq C 0)
;;(répéter (sslongueur ss)
;;(setq entx (ssname ss C))
;;(setq ent (entget entx))
;;(setq ent (subst (cons 7 "NEWSTYLE") (assoc 7 ent) ent))
;;(entmod ent)
;;(setq C (+ C 1))
;;); répéter
;;); prog
;;); si
;;(princ)
;;); fonction



;;(vl-load-com)
;;(defun ChangeMtextStyle (mtxt)
;;(setq ntxt   "fCentury" )
;;(setq oldtxts '("fArial Narrow" "Fromans"));list of text styles to search
;;(setq mcont (cdr (assoc 1 mtxt)))

;;(foreach n oldtxts
;;(if (vl-string-search n mcont)
;;(progn
;;(setq nwtxt (vl-string-subst ntxt n mcont))
;;(setq mtxt (subst (cons 1 nwtxt) (assoc 1 mtxt) mtxt ))
;;(entmod mtxt)
;;(princ)
;;);progn
;;);if
;;);for

;;);defun


(defun c:ChangeTxtStyle (/ a ts n index b1 b c d b2)
 (setq a (ssget "_X" '((0 . "*TEXT,ATTDEF"))))
 (setq ts "ArialN")
 (setq n (sslength a))
 (setq index 0)
  (repeat n
   (setq b1 (entget (ssname a index)))
   (setq index (1+ index))
   (setq b (assoc 0 b1))
    (if (= "TEXT" (cdr b))
     (progn
      (setq c (assoc 7 b1))
      (setq d (cons (car c) ts)))
      (setq b2 (subst d c b1))
      (entmod b2)
     );progn
    );if
	(if ( = "MTEXT" (cdr b))
	(ChangeMtextStyle b1)
	);if
  );repeat
;;);defun
;;);defun


