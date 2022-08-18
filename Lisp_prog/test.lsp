(vl-load-com)


(defun c:ChangeTxtStyle (/ a ts n index b1 b c d b2)
(setq a (ssget "_X" '((0 . "*TEXT,ATTDEF"))))
(setq ts "Century")
(setq n (sslength a))
(setq index 0)
 (repeat n
  (setq b1 (entget (ssname a index)))
  (setq index (1+ index))
  (setq b (assoc 0 b1))
   (if (= "TEXT" (cdr B))
    (progn
     (setq c (assoc 7 b1))
     (setq d (cons (car c) ts)))
     (setq b2 (subst d c b1))
     (entmod b2)
    );progn
   );if

 );repeat
);defun
);defun
 

 (defun c:testext ()
(setq F7 (getpoint "\nPoint d'insertion : "))
(setq StyTxName "MonStyle") ;; le nom du nouveau style de texte
(if (not (tblsearch "STYLE" StyTxName)) ;; s'il n'existe pas
   (command "_style" StyTxName "arial.ttf" "1.5" "1.00" "0.00" "_N" "_N") ;; je le crée
    (command "_textstyle" StyTxName) ;; sinon je l'active
)
;; comme ça tu maîtrise le style utilisé par la commande _text
;; et comme le disait Didier plus haut, tu sauras si le texte
;; a une hauteur définie ou non
;;
;; puis tu crées ton texte
(command "_text" "_non" F7 "0" "Mon texte") 
;; sans indiquer de hauteur, puisque le style créé ci dessus
;; a une hauteur prédéfinie
(princ)
)