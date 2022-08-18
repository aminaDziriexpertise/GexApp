(defun C:CHANGESTYLE (/ len count ent ent_data ent_name new_style_name)
 (c:TXTSTY)
 (c:BRSTBLK)
 (c:CHGTXT)
 (c:CHGMLD)
 )
 
(defun c:TXTSTY ()
(command "-STYLE" "iso" "isocp.shx" "0" "1" "0" "NO" "NO" "" "")
)


(defun c:BRSTBLK ( / ssAllBlocks drwordr)
  (setq ssAllBlocks (ssget "X" '((0 . "INSERT")))
	   drwordr (getvar "draworderctl")
  )
  (setvar "draworderctl" 0);supress warnings
  (sssetfirst nil ssAllBlocks) ;makes ssAllBlocks both gripped and selected. 
  ;(c:burst)
  (setvar "draworderctl" drwordr)
)


(defun c:CHGTXT ()
(setq ssAllTxt (ssget "X" '((0 . "TEXT,MTEXT,RTEXT,ATTDEF")))
      len      (sslength ssAllTxt)
      count 0)
 
(while (< count len)
       (setq ent      (ssname ssAllTxt count) 
             ent_data (entget ent)
             ent_name (cdr (assoc 7 ent_data))
       );setq
 
(setq new_style_name (cons 7 "Arial"))
(setq ent_data (subst new_style_name (assoc 7 ent_data) ent_data))
(entmod ent_data)
 
(setq count (+ count 1))
);while
)


(defun c:CHGMLD ()
(if (setq ssetMLeaders (ssget "_:S" '((0 . "MULTILEADER"))))
 (progn
 (command "_EXPLODE" (ssname ssetMLeaders 0))
 (setq ssetItems (ssget "_P"))
 (repeat (setq index (sslength ssetItems))
 (setq assocItem (entget (ssname ssetItems (setq index (1- index)))))
 (if (/= (cdr (assoc 0 assocItem))
 "MTEXT")
 (entdel (cdr (assoc -1 assocItem)))
 ) ;if
 ) ;repeat
 ) ;progn
 ) ;if
 ) ;defun
(princ)
