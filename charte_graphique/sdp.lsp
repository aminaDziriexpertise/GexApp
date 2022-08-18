;===================================================
CALCUL DES SUPERFICIES SDP
;===================================================

(defun c:sdp( / sel1 ind surftotal surfad nm cal surf entite ind1 totx toty x y xmoyen ymoyen )

(setq os (getvar "osmode"))
(setvar "osmode" 0)
;(setvar "HPISLANDDETECTION" 0)
(if (=  (tblsearch "layer" "GEX_EDS_sdp_1-SDP") nil)(command "_layer" "_new" "GEX_EDS_sdp_1-SDP" "C" "U" "255,0,0" "GEX_EDS_sdp_1-SDP" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_2-tremie") nil)(command "_layer" "_new" "GEX_EDS_sdp_2-tremie" "C" "U" "255,255,127" "GEX_EDS_sdp_2-tremie" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_8-cave") nil)(command "_layer" "_new" "GEX_EDS_sdp_8-cave" "C" "U" "255,191,127" "GEX_EDS_sdp_8-cave" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_3-h-180") nil)(command "_layer" "_new" "GEX_EDS_sdp_3-h-180" "C" "U" "165,82,82" "GEX_EDS_sdp_3-h-180" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_7-lt") nil)(command "_layer" "_new" "GEX_EDS_sdp_7-lt" "C" "U" "0,127,255" "GEX_EDS_sdp_7-LT" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_5-pk") nil)(command "_layer" "_new" "GEX_EDS_sdp_5-pk" "C" "U" "153,153,153" "GEX_EDS_sdp_5-PK" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_6-combles") nil)(command "_layer" "_new" "GEX_EDS_sdp_6-combles" "C" "U" "82,0,165" "GEX_EDS_sdp_6-combles" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_teinte_contour") nil)(command "_layer" "_new" "GEX_EDS_sdp_teinte_contour" "C" "U" "255,127,127" "GEX_EDS_sdp_teinte_contour" ""))
    
(if (=  (tblsearch "layer" "GEX_EDS_sdp_1-SDP_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_1-SDP_su" "C" "U" "255,0,0" "GEX_EDS_sdp_1-SDP_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_2-tremie_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_2-tremie_su" "_color" "7" "GEX_EDS_sdp_2-tremie_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_8-cave_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_8-cave_su" "_color" "7" "GEX_EDS_sdp_8-cave_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_3-h-180_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_3-h-180_su" "_color" "7" "GEX_EDS_sdp_3-h-180_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_7-lt_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_7-lt_su" "_color" "7" "GEX_EDS_sdp_7-LT_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_5-pk_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_5-pk_su" "_color" "7" "GEX_EDS_sdp_5-PK_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_sdp_6-combles_su") nil)(command "_layer" "_new" "GEX_EDS_sdp_6-combles_su" "_color" "7" "GEX_EDS_sdp_6-combles_su" ""))

(if (=  (tblsearch "style" "SURF") nil)(command "_STYLE" "SURF" "swissl.ttf" "0.000" "" "" "" "" ""))

;;; Planchers avant déductions 
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_1-SDP" "l" "GEX_EDS_sdp_teinte_contour" "l" "GEX_EDS_sdp_1-SDP_su" "")

(setq sel (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_1-SDP") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_1-SDP") (-4 . "and>") (-4 . "or>"))))
  
(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_teinte_contour")  
(command "-hachures" "s" sel "" "")  
(command "clayer" "GEX_EDS_sdp_1-SDP_su")

(setq sel1 (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_teinte_contour"))))
(command "_draworder" "p" "" "_back")
(setq ind 0 surftotal 0 surfad 0 somme 0)

      (if (/= sel1 nil)						;debut du if
	(while (setq nm (ssname sel1 ind))			;debut du while
	(setq s1 (cdr (assoc -1 (entget nm))))
	(setq entite (entget nm))
	(setq ind1 0 totx 0 toty 0)
	  
	(setq entite (entget s1))
(setq entite (member (assoc 72 entite) entite))

(while (= (car(assoc 11 entite)) 11)
(setq x (nth 1 (assoc 11 entite)))
(setq y (nth 2 (assoc 11 entite)))
(setq totx (+ totx x))
(setq toty (+ toty y))
(setq entite (member (assoc 72 entite) entite))
(setq entite (member (assoc 11 entite) entite))
(setq ind1 (1+ ind1))
)								;fin du while

(setq xmoyen (/ totx ind1))
(setq ymoyen (/ toty ind1))
(setq cxyz (list xmoyen ymoyen))
(setq cxyz (trans cxyz 0 1))

	(command "_area" "_o" s1)
	(setq surfpoly (getvar "area"))
	(setq surf1 surfpoly)
	(setq surfpoly (rtos surfpoly 2 1))
	(setq surfpoly (strcat surfpoly " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz 0.5 100 surfpoly)

        (setq ind (1+ ind))

        )							;fin du while
    )                                                           ;fin de if

 ;;; Vides ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_2-tremie" "l" "GEX_EDS_sdp_2-tremie_su" "")

(setq sel-T (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_2-tremie") 
(command "-hachures" "s" sel-T "" "")  
(command "clayer" "GEX_EDS_sdp_2-tremie_su")

(setq sel1-T (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_2-tremie"))))
(command "_draworder" "p" "" "_back")
(setq ind-T 0 surftotal-T 0 surfad-T 0 somme-T 0)

      (if (/= sel1-T nil)						;debut du if
	(while (setq nm-T (ssname sel1-T ind-T))			;debut du while
	(setq s1-T (cdr (assoc -1 (entget nm-T))))
	(setq entite-T (entget nm-T))
	(setq ind1-T 0 totx-T 0 toty-T 0)
	  
	(setq entite-T (entget s1-T))
(setq entite-T (member (assoc 72 entite-T) entite-T))

(while (= (car(assoc 11 entite-T)) 11)
(setq x-T (nth 1 (assoc 11 entite-T)))
(setq y-T (nth 2 (assoc 11 entite-T)))
(setq totx-T (+ totx-T x-T))
(setq toty-T (+ toty-T y-T))
(setq entite-T (member (assoc 72 entite-T) entite-T))
(setq entite-T (member (assoc 11 entite-T) entite-T))
(setq ind1-T (1+ ind1-T))
)								;fin du while

(setq xmoyen-T (/ totx-T ind1-T))
(setq ymoyen-T (/ toty-T ind1-T))
(setq cxyz-T (list xmoyen-T ymoyen-T))
(setq cxyz-T (trans cxyz-T 0 1))

	(command "_area" "_o" s1-T)
	(setq surfpoly-T (getvar "area"))
	(setq surf1-T surfpoly-T)
	(setq surfpoly-T (rtos surfpoly-T 2 1))
	(setq surfpoly-T (strcat surfpoly-T " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-T 0.20 100 surfpoly-T)

        (setq ind-T (1+ ind-T))

        )							;fin du while
    )                                                           ;fin de if
  

 ;;; Surfaces dont h < 1.80 m ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_3-h-180" "l" "GEX_EDS_sdp_3-h-180_su" "")

(setq sel-C (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_3-h-180") 
(command "-hachures" "s" sel-C "" "")  
(command "clayer" "GEX_EDS_sdp_3-h-180_su")

(setq sel1-C (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_3-h-180"))))
(command "_draworder" "p" "" "_back")
(setq ind-C 0 surftotal-C 0 surfad-C 0 somme-C 0)

      (if (/= sel1-C nil)						;debut du if
	(while (setq nm-C (ssname sel1-C ind-C))			;debut du while
	(setq s1-C (cdr (assoc -1 (entget nm-C))))
	(setq entite-C (entget nm-C))
	(setq ind1-C 0 totx-C 0 toty-C 0)
	  
	(setq entite-C (entget s1-C))
(setq entite-C (member (assoc 72 entite-C) entite-C))

(while (= (car(assoc 11 entite-C)) 11)
(setq x-C (nth 1 (assoc 11 entite-C)))
(setq y-C (nth 2 (assoc 11 entite-C)))
(setq totx-C (+ totx-C x-C))
(setq toty-C (+ toty-C y-C))
(setq entite-C (member (assoc 72 entite-C) entite-C))
(setq entite-C (member (assoc 11 entite-C) entite-C))
(setq ind1-C (1+ ind1-C))
)								;fin du while

(setq xmoyen-C (/ totx-C ind1-C))
(setq ymoyen-C (/ toty-C ind1-C))
(setq cxyz-C (list xmoyen-C ymoyen-C))
(setq cxyz-C (trans cxyz-C 0 1))

	(command "_area" "_o" s1-C)
	(setq surfpoly-C (getvar "area"))
	(setq surf1-C surfpoly-C)
	(setq surfpoly-C (rtos surfpoly-C 2 1))
	(setq surfpoly-C (strcat surfpoly-C " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-C 0.20 100 surfpoly-C)

        (setq ind-C (1+ ind-C))

        )							;fin du while
    )                                                           ;fin de if  


;;; Stationnement ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_5-PK" "l" "GEX_EDS_sdp_5-PK_su" "")

(setq sel-H (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_5-PK") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_5-PK") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_5-PK") 
(command "-hachures" "s" sel-H "" "")  
(command "clayer" "GEX_EDS_sdp_5-PK_su")

(setq sel1-H (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_5-PK"))))
(command "_draworder" "p" "" "_back")
(setq ind-H 0 surftotal-H 0 surfad-H 0 somme-H 0)

      (if (/= sel1-H nil)						;debut du if
	(while (setq nm-H (ssname sel1-H ind-H))			;debut du while
	(setq s1-H (cdr (assoc -1 (entget nm-H))))
	(setq entite-H (entget nm-H))
	(setq ind1-H 0 totx-H 0 toty-H 0)
	  
	(setq entite-H (entget s1-H))
(setq entite-H (member (assoc 72 entite-H) entite-H))

(while (= (car(assoc 11 entite-H)) 11)
(setq x-H (nth 1 (assoc 11 entite-H)))
(setq y-H (nth 2 (assoc 11 entite-H)))
(setq totx-H (+ totx-H x-H))
(setq toty-H (+ toty-H y-H))
(setq entite-H (member (assoc 72 entite-H) entite-H))
(setq entite-H (member (assoc 11 entite-H) entite-H))
(setq ind1-H (1+ ind1-H))
)								;fin du while

(setq xmoyen-H (/ totx-H ind1-H))
(setq ymoyen-H (/ toty-H ind1-H))
(setq cxyz-H (list xmoyen-H ymoyen-H))
(setq cxyz-H (trans cxyz-H 0 1))

	(command "_area" "_o" s1-H)
	(setq surfpoly-H (getvar "area"))
	(setq surf1-H surfpoly-H)
	(setq surfpoly-H (rtos surfpoly-H 2 1))
	(setq surfpoly-H (strcat surfpoly-H " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-H 0.20 100 surfpoly-H)

        (setq ind-H (1+ ind-H))

        )							;fin du while
    )                                                           ;fin de if  


;;; Combles ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_6-combles" "l" "GEX_EDS_sdp_6-combles_su" "")

(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_6-combles") 
(command "-hachures" "s" sel-L "" "")  
(command "clayer" "GEX_EDS_sdp_6-combles_su")

(setq sel1-L (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_6-combles"))))
(command "_draworder" "p" "" "_back")
(setq ind-L 0 surftotal-L 0 surfad-L 0 somme-L 0)

      (if (/= sel1-L nil)						;debut du if
	(while (setq nm-L (ssname sel1-L ind-L))			;debut du while
	(setq s1-L (cdr (assoc -1 (entget nm-L))))
	(setq entite-L (entget nm-L))
	(setq ind1-L 0 totx-L 0 toty-L 0)
	  
	(setq entite-L (entget s1-L))
(setq entite-L (member (assoc 72 entite-L) entite-L))

(while (= (car(assoc 11 entite-L)) 11)
(setq x-L (nth 1 (assoc 11 entite-L)))
(setq y-L (nth 2 (assoc 11 entite-L)))
(setq totx-L (+ totx-L x-L))
(setq toty-L (+ toty-L y-L))
(setq entite-L (member (assoc 72 entite-L) entite-L))
(setq entite-L (member (assoc 11 entite-L) entite-L))
(setq ind1-L (1+ ind1-L))
)								;fin du while

(setq xmoyen-L (/ totx-L ind1-L))
(setq ymoyen-L (/ toty-L ind1-L))
(setq cxyz-L (list xmoyen-L ymoyen-L))
(setq cxyz-L (trans cxyz-L 0 1))

	(command "_area" "_o" s1-L)
	(setq surfpoly-L (getvar "area"))
	(setq surf1-L surfpoly-L)
	(setq surfpoly-L (rtos surfpoly-L 2 1))
	(setq surfpoly-L (strcat surfpoly-L " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-L 0.20 100 surfpoly-L)

        (setq ind-L (1+ ind-L))

        )							;fin du while
    )                                                           ;fin de if


;;; Locaux techniques ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_7-LT" "l" "GEX_EDS_sdp_7-LT_su" "")

(setq sel-P (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_7-LT") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_7-LT") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_7-LT") 
(command "-hachures" "s" sel-P "" "")  
(command "clayer" "GEX_EDS_sdp_7-LT_su")

(setq sel1-P (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_7-LT"))))
(command "_draworder" "p" "" "_back")
(setq ind-P 0 surftotal-P 0 surfad-P 0 somme-P 0)

      (if (/= sel1-P nil)						;debut du if
	(while (setq nm-P (ssname sel1-P ind-P))			;debut du while
	(setq s1-P (cdr (assoc -1 (entget nm-P))))
	(setq entite-P (entget nm-P))
	(setq ind1-P 0 totx-P 0 toty-P 0)
	  
	(setq entite-P (entget s1-P))
(setq entite-P (member (assoc 72 entite-P) entite-P))

(while (= (car(assoc 11 entite-P)) 11)
(setq x-P (nth 1 (assoc 11 entite-P)))
(setq y-P (nth 2 (assoc 11 entite-P)))
(setq totx-P (+ totx-P x-P))
(setq toty-P (+ toty-P y-P))
(setq entite-P (member (assoc 72 entite-P) entite-P))
(setq entite-P (member (assoc 11 entite-P) entite-P))
(setq ind1-P (1+ ind1-P))
)								;fin du while

(setq xmoyen-P (/ totx-P ind1-P))
(setq ymoyen-P (/ toty-P ind1-P))
(setq cxyz-P (list xmoyen-P ymoyen-P))
(setq cxyz-P (trans cxyz-P 0 1))

	(command "_area" "_o" s1-P)
	(setq surfpoly-P (getvar "area"))
	(setq surf1-P surfpoly-P)
	(setq surfpoly-P (rtos surfpoly-P 2 1))
	(setq surfpoly-P (strcat surfpoly-P " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-P 0.20 100 surfpoly-P)

        (setq ind-P (1+ ind-P))

        )							;fin du while
    )                                                           ;fin de if


;;; Caves ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_sdp_8-cave" "l" "GEX_EDS_sdp_8-cave_su" "")

(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_sdp_8-cave") 
(command "-hachures" "s" sel-S "" "")  
(command "clayer" "GEX_EDS_sdp_8-cave_su")

(setq sel1-S (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_sdp_8-cave"))))
(command "_draworder" "p" "" "_back")
(setq ind-S 0 surftotal-S 0 surfad-S 0 somme-S 0)

      (if (/= sel1-S nil)						;debut du if
	(while (setq nm-S (ssname sel1-S ind-S))			;debut du while
	(setq s1-S (cdr (assoc -1 (entget nm-S))))
	(setq entite-S (entget nm-S))
	(setq ind1-S 0 totx-S 0 toty-S 0)
	  
	(setq entite-S (entget s1-S))
(setq entite-S (member (assoc 72 entite-S) entite-S))

(while (= (car(assoc 11 entite-S)) 11)
(setq x-S (nth 1 (assoc 11 entite-S)))
(setq y-S (nth 2 (assoc 11 entite-S)))
(setq totx-S (+ totx-S x-S))
(setq toty-S (+ toty-S y-S))
(setq entite-S (member (assoc 72 entite-S) entite-S))
(setq entite-S (member (assoc 11 entite-S) entite-S))
(setq ind1-S (1+ ind1-S))
)								;fin du while

(setq xmoyen-S (/ totx-S ind1-S))
(setq ymoyen-S (/ toty-S ind1-S))
(setq cxyz-S (list xmoyen-S ymoyen-S))
(setq cxyz-S (trans cxyz-S 0 1))

	(command "_area" "_o" s1-S)
	(setq surfpoly-S (getvar "area"))
	(setq surf1-S surfpoly-S)
	(setq surfpoly-S (rtos surfpoly-S 2 1))
	(setq surfpoly-S (strcat surfpoly-S " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-S 0.20 100 surfpoly-S)

        (setq ind-S (1+ ind-S))

        )							;fin du while
    )                                                           ;fin de if    

  
(command "_layer" "_thaw" "*" "_make" 0  "_freeze" "GEX_EDS_sdp_teinte_contour" "")
(setvar "osmode" os)
    (princ "\n")
    (princ)
)

;===================================================
TABLEAU SDP
;===================================================

(defun c:sdt ()


;===================================== Planchers avant déductions ======================================

	(setq ind 0 total_val_text_SP 0 total 0)
	(setq sel_SP (ssget "x" (list (cons 8 "GEX_EDS_sdp_1-SDP_su") (cons 0 "TEXT"))))
	(while (setq nm (ssname sel_SP ind))
		(setq val_text_SP (assoc 1 (entget nm)) 
			val_text_SP (atof (cdr val_text_SP)) 
			total_val_text_SP (+ total val_text_SP) 
			total total_val_text_SP
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "SP" "0" "0" (rtos total_val_text_SP 2 0))

;======================================== VIDES ===========================================

	(setq ind 0 total_val_text_V 0 total 0)
	(setq sel_V (ssget "x" (list (cons 8 "GEX_EDS_sdp_2-tremie_su") (cons 0 "TEXT"))))
(if (/= sel_V nil)
	(progn
	(while (setq nm (ssname sel_V ind))
		(setq val_text_V (assoc 1 (entget nm)) 
			val_text_V (atof (cdr val_text_V)) 
			total_val_text_V (+ total val_text_V) 
			total total_val_text_V
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "V" "0" "0" (rtos total_val_text_V 2 0))
))

;======================================= H 180 =========================================

	(setq ind 0 total_val_text_180 0 total 0)
	(setq sel_180 (ssget "x" (list (cons 8 "GEX_EDS_sdp_3-h-180_su") (cons 0 "TEXT"))))
(if (/= sel_180 nil)
	(progn
	(while (setq nm (ssname sel_180 ind))
		(setq val_text_180 (assoc 1 (entget nm)) 
			val_text_180 (atof (cdr val_text_180)) 
			total_val_text_180 (+ total val_text_180) 
			total total_val_text_180
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "180" "0" "0" (rtos total_val_text_180 2 0))
))

;====================================== TOTAL TA =======================================

	(setq total_val_text_TA (- (atof (rtos total_val_text_SP 2 0)) (atof (rtos total_val_text_V 2 0)) (atof (rtos total_val_text_180 2 0)) ))
	(setq total_val_text_TA (rtos total_val_text_TA 2 0))

(command "-attedit" "N" "N" "SDP" "TA" "0" "0" total_val_text_TA)

;====================================== STATIONEMENT ========================================

	(setq ind 0 total_val_text_ST 0 total 0)
	(setq sel_ST (ssget "x" (list (cons 8 "GEX_EDS_sdp_5-PK_su") (cons 0 "TEXT"))))
(if (/= sel_ST nil)
	(progn
	(while (setq nm (ssname sel_ST ind))
		(setq val_text_ST (assoc 1 (entget nm)) 
			val_text_ST (atof (cdr val_text_ST)) 
			total_val_text_ST (+ total val_text_ST) 
			total total_val_text_ST
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "ST" "0" "0" (rtos total_val_text_ST 2 0))
))

;======================================== COMBLES ==========================================

	(setq ind 0 total_val_text_CO 0 total 0)
	(setq sel_CO (ssget "x" (list (cons 8 "GEX_EDS_sdp_6-combles_su") (cons 0 "TEXT"))))
(if (/= sel_CO nil)
(progn
	(while (setq nm (ssname sel_CO ind))
		(setq val_text_CO (assoc 1 (entget nm)) 
			val_text_CO (atof (cdr val_text_CO)) 
			total_val_text_CO (+ total val_text_CO) 
			total total_val_text_CO
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "CO" "0" "0" (rtos total_val_text_CO 2 0))
))

;==================================== LOCAUX TECHNIQUE ===================================

	(setq ind 0 total_val_text_LT 0 total 0)
	(setq sel_LT (ssget "x" (list (cons 8 "GEX_EDS_sdp_7-LT_su") (cons 0 "TEXT"))))
(if (/= sel_LT nil)
	(progn
	(while (setq nm (ssname sel_LT ind))
		(setq val_text_LT (assoc 1 (entget nm)) 
			val_text_LT (atof (cdr val_text_LT)) 
			total_val_text_LT (+ total val_text_LT) 
			total total_val_text_LT
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "LT" "0" "0" (rtos total_val_text_LT 2 0))
))

;======================================= CAVE ==========================================

	(setq ind 0 total_val_text_c 0 total 0)
	(setq sel_c (ssget "x" (list (cons 8 "GEX_EDS_sdp_8-cave_su") (cons 0 "TEXT"))))
(if (/= sel_c nil)
	(progn
	(while (setq nm (ssname sel_c ind))
		(setq val_text_c (assoc 1 (entget nm)) 
			val_text_c (atof (cdr val_text_c)) 
			total_val_text_c (+ total val_text_c) 
			total total_val_text_c
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SDP" "C" "0" "0" (rtos total_val_text_c 2 0))
))

;====================================== ISOLATION ========================================

(setq choix "Locaux")
(initget "Locaux Habitation Mixte" )
(setq choix (getkword "\n Locaux, Habitation, Mixte : <Locaux> "))
	(if (= choix nil)(setq choix "Locaux"))
	(if (= choix "Mixte")
	(setq total_val_text_i (*(getint "\n Entrer la superficie de locaux d'habitation : ")0.10))
	)
	(if (= choix "Locaux")
	(setq total_val_text_i 0)
	)
	(if (= choix "Habitation")
	(setq total_val_text_i (* (- (atof total_val_text_TA) total_val_text_LT total_val_text_c total_val_text_CO total_val_text_ST )0.10))
	)
(command "-attedit" "N" "N" "SDP" "ISOL" "0" "0" (rtos total_val_text_i 2 0))

;========================================= SDP ===========================================

(setq total_val_text_sdp (- (atof total_val_text_TA) (atof (rtos total_val_text_ST 2 0)) (atof (rtos total_val_text_CO 2 0)) (atof (rtos total_val_text_LT 2 0))
 (atof (rtos total_val_text_c 2 0)) (atof (rtos total_val_text_i 2 0)) ))
(setq total_val_text_sdp (atoi (rtos total_val_text_sdp 2 0)))

(command "-attedit" "N" "N" "SDP" "SDP" "0" "0" total_val_text_sdp)
)
(princ)

;=================================== FIN DE PROGRAMME =====================================



;================================== DEBUT DE PROGRAMME ====================================

;================ MISE A ZERO DE TOUTES LES VALEURS DU TABLEAU SDP ==================

(defun c:sd0 ()
	(command "-attedit" "N" "N" "SDP" "SP" (rtos total_val_text_SP 2 0) (rtos total_val_text_SP 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "V" (rtos total_val_text_V 2 0) (rtos total_val_text_V 2 0) "0" )
        (command "_regen")
        (command "-attedit" "N" "N" "SDP" "180" (rtos total_val_text_180 2 0) (rtos total_val_text_180 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "TA" total_val_text_TA total_val_text_TA "0" )
	(command "_regen")
        (command "-attedit" "N" "N" "SDP" "ST" (rtos total_val_text_ST 2 0) (rtos total_val_text_ST 2 0) "0" )
	(command "_regen")
        (command "-attedit" "N" "N" "SDP" "CO" (rtos total_val_text_CO 2 0) (rtos total_val_text_CO 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "LT" (rtos total_val_text_LT 2 0) (rtos total_val_text_LT 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "C" (rtos total_val_text_c 2 0) (rtos total_val_text_c 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "ISOL" (rtos total_val_text_i 2 0) (rtos total_val_text_i 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SDP" "SDP" (atoi (rtos total_val_text_sdp 2 0)) (atoi (rtos total_val_text_sdp 2 0)) "0" )
	(command "_regen")
	)

;=================================== FIN DE PROGRAMME =====================================

;===================================================
CALCUL DES SUPERFICIES SHOB /SHON
;===================================================

(defun c:sho( / sel1 ind surftotal surfad nm cal surf entite ind1 totx toty x y xmoyen ymoyen )

(setq os (getvar "osmode"))
(setvar "osmode" 0)
(setvar "HPISLANDDETECTION" 0)
(if (=  (tblsearch "layer" "GEX_EDS_shob_contour") nil)(command "_layer" "_new" "GEX_EDS_shob_contour" "C" "U" "255,0,0" "GEX_EDS_shob_contour" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shob_tremie") nil)(command "_layer" "_new" "GEX_EDS_shob_tremie" "C" "U" "255,255,127" "GEX_EDS_shob_tremie" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_cave") nil)(command "_layer" "_new" "GEX_EDS_shon_cave" "C" "U" "255,191,127" "GEX_EDS_shon_cave" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_h-180") nil)(command "_layer" "_new" "GEX_EDS_shon_h-180" "C" "U" "165,82,82" "GEX_EDS_shon_h-180" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_ltg") nil)(command "_layer" "_new" "GEX_EDS_shon_lTG" "C" "U" "0,127,255" "GEX_EDS_shon_LTG" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_pk") nil)(command "_layer" "_new" "GEX_EDS_shon_pk" "C" "U" "153,153,153" "GEX_EDS_shon_PK" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_snc") nil)(command "_layer" "_new" "GEX_EDS_shon_snc" "C" "U" "191,255,127" "GEX_EDS_shon_SNC" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shob_teinte_contour") nil)(command "_layer" "_new" "GEX_EDS_shob_teinte_contour" "C" "U" "255,127,127" "GEX_EDS_shob_teinte_contour" ""))
    
(if (=  (tblsearch "layer" "GEX_EDS_shob_contour_su") nil)(command "_layer" "_new" "GEX_EDS_shob_contour_su" "C" "U" "255,0,0" "GEX_EDS_shob_contour_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shob_tremie_su") nil)(command "_layer" "_new" "GEX_EDS_shob_tremie_su" "_color" "7" "GEX_EDS_shob_tremie_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_cave_su") nil)(command "_layer" "_new" "GEX_EDS_shon_cave_su" "_color" "7" "GEX_EDS_shon_cave_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_h-180_su") nil)(command "_layer" "_new" "GEX_EDS_shon_h-180_su" "_color" "7" "GEX_EDS_shon_h-180_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_ltg_su") nil)(command "_layer" "_new" "GEX_EDS_shon_ltg_su" "_color" "7" "GEX_EDS_shon_LTG_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_pk_su") nil)(command "_layer" "_new" "GEX_EDS_shon_pk_su" "_color" "7" "GEX_EDS_shon_PK_su" ""))
(if (=  (tblsearch "layer" "GEX_EDS_shon_snc_su") nil)(command "_layer" "_new" "GEX_EDS_shon_snc_su" "_color" "7" "GEX_EDS_shon_SNC_su" ""))

(if (=  (tblsearch "style" "SURF") nil)(command "_STYLE" "SURF" "swissl.ttf" "0.000" "" "" "" "" ""))

;;; Contour bÃ¢ti 
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shob_contour" "l" "GEX_EDS_shob_teinte_contour" "l" "GEX_EDS_shob_contour_su" "")

(setq sel (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shob_contour") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shob_contour") (-4 . "and>") (-4 . "or>"))))
  
(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shob_teinte_contour")  
(command "-hachures" "s" sel "" "")  
(command "clayer" "GEX_EDS_shob_contour_su")

(setq sel1 (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shob_teinte_contour"))))
(command "_draworder" "p" "" "_back")
(setq ind 0 surftotal 0 surfad 0 somme 0)

      (if (/= sel1 nil)						;debut du if
	(while (setq nm (ssname sel1 ind))			;debut du while
	(setq s1 (cdr (assoc -1 (entget nm))))
	(setq entite (entget nm))
	(setq ind1 0 totx 0 toty 0)
	  
	(setq entite (entget s1))
(setq entite (member (assoc 72 entite) entite))

(while (= (car(assoc 11 entite)) 11)
(setq x (nth 1 (assoc 11 entite)))
(setq y (nth 2 (assoc 11 entite)))
(setq totx (+ totx x))
(setq toty (+ toty y))
(setq entite (member (assoc 72 entite) entite))
(setq entite (member (assoc 11 entite) entite))
(setq ind1 (1+ ind1))
)								;fin du while

(setq xmoyen (/ totx ind1))
(setq ymoyen (/ toty ind1))
(setq cxyz (list xmoyen ymoyen))
(setq cxyz (trans cxyz 0 1))

	(command "_area" "_o" s1)
	(setq surfpoly (getvar "area"))
	(setq surf1 surfpoly)
	(setq surfpoly (rtos surfpoly 2 1))
	(setq surfpoly (strcat surfpoly " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz 0.5 100 surfpoly)

        (setq ind (1+ ind))

        )							;fin du while
    )                                                           ;fin de if

 ;;; Tremie ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shob_tremie" "l" "GEX_EDS_shob_tremie_su" "")

(setq sel-T (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shob_tremie") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shob_tremie") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shob_tremie") 
(command "-hachures" "s" sel-T "" "")  
(command "clayer" "GEX_EDS_shob_tremie_su")

(setq sel1-T (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shob_tremie"))))
(command "_draworder" "p" "" "_back")
(setq ind-T 0 surftotal-T 0 surfad-T 0 somme-T 0)

      (if (/= sel1-T nil)						;debut du if
	(while (setq nm-T (ssname sel1-T ind-T))			;debut du while
	(setq s1-T (cdr (assoc -1 (entget nm-T))))
	(setq entite-T (entget nm-T))
	(setq ind1-T 0 totx-T 0 toty-T 0)
	  
	(setq entite-T (entget s1-T))
(setq entite-T (member (assoc 72 entite-T) entite-T))

(while (= (car(assoc 11 entite-T)) 11)
(setq x-T (nth 1 (assoc 11 entite-T)))
(setq y-T (nth 2 (assoc 11 entite-T)))
(setq totx-T (+ totx-T x-T))
(setq toty-T (+ toty-T y-T))
(setq entite-T (member (assoc 72 entite-T) entite-T))
(setq entite-T (member (assoc 11 entite-T) entite-T))
(setq ind1-T (1+ ind1-T))
)								;fin du while

(setq xmoyen-T (/ totx-T ind1-T))
(setq ymoyen-T (/ toty-T ind1-T))
(setq cxyz-T (list xmoyen-T ymoyen-T))
(setq cxyz-T (trans cxyz-T 0 1))

	(command "_area" "_o" s1-T)
	(setq surfpoly-T (getvar "area"))
	(setq surf1-T surfpoly-T)
	(setq surfpoly-T (rtos surfpoly-T 2 1))
	(setq surfpoly-T (strcat surfpoly-T " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-T 0.20 100 surfpoly-T)

        (setq ind-T (1+ ind-T))

        )							;fin du while
    )                                                           ;fin de if
  

 ;;; caves ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shon_cave" "l" "GEX_EDS_shon_cave_su" "")

(setq sel-C (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_cave") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_cave") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shon_cave") 
(command "-hachures" "s" sel-C "" "")  
(command "clayer" "GEX_EDS_shon_cave_su")

(setq sel1-C (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shon_cave"))))
(command "_draworder" "p" "" "_back")
(setq ind-C 0 surftotal-C 0 surfad-C 0 somme-C 0)

      (if (/= sel1-C nil)						;debut du if
	(while (setq nm-C (ssname sel1-C ind-C))			;debut du while
	(setq s1-C (cdr (assoc -1 (entget nm-C))))
	(setq entite-C (entget nm-C))
	(setq ind1-C 0 totx-C 0 toty-C 0)
	  
	(setq entite-C (entget s1-C))
(setq entite-C (member (assoc 72 entite-C) entite-C))

(while (= (car(assoc 11 entite-C)) 11)
(setq x-C (nth 1 (assoc 11 entite-C)))
(setq y-C (nth 2 (assoc 11 entite-C)))
(setq totx-C (+ totx-C x-C))
(setq toty-C (+ toty-C y-C))
(setq entite-C (member (assoc 72 entite-C) entite-C))
(setq entite-C (member (assoc 11 entite-C) entite-C))
(setq ind1-C (1+ ind1-C))
)								;fin du while

(setq xmoyen-C (/ totx-C ind1-C))
(setq ymoyen-C (/ toty-C ind1-C))
(setq cxyz-C (list xmoyen-C ymoyen-C))
(setq cxyz-C (trans cxyz-C 0 1))

	(command "_area" "_o" s1-C)
	(setq surfpoly-C (getvar "area"))
	(setq surf1-C surfpoly-C)
	(setq surfpoly-C (rtos surfpoly-C 2 1))
	(setq surfpoly-C (strcat surfpoly-C " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-C 0.20 100 surfpoly-C)

        (setq ind-C (1+ ind-C))

        )							;fin du while
    )                                                           ;fin de if  


;;; H-180 ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shon_h-180" "l" "GEX_EDS_shon_h-180_su" "")

(setq sel-H (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_h-180") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_h-180") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shon_h-180") 
(command "-hachures" "s" sel-H "" "")  
(command "clayer" "GEX_EDS_shon_h-180_su")

(setq sel1-H (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shon_h-180"))))
(command "_draworder" "p" "" "_back")
(setq ind-H 0 surftotal-H 0 surfad-H 0 somme-H 0)

      (if (/= sel1-H nil)						;debut du if
	(while (setq nm-H (ssname sel1-H ind-H))			;debut du while
	(setq s1-H (cdr (assoc -1 (entget nm-H))))
	(setq entite-H (entget nm-H))
	(setq ind1-H 0 totx-H 0 toty-H 0)
	  
	(setq entite-H (entget s1-H))
(setq entite-H (member (assoc 72 entite-H) entite-H))

(while (= (car(assoc 11 entite-H)) 11)
(setq x-H (nth 1 (assoc 11 entite-H)))
(setq y-H (nth 2 (assoc 11 entite-H)))
(setq totx-H (+ totx-H x-H))
(setq toty-H (+ toty-H y-H))
(setq entite-H (member (assoc 72 entite-H) entite-H))
(setq entite-H (member (assoc 11 entite-H) entite-H))
(setq ind1-H (1+ ind1-H))
)								;fin du while

(setq xmoyen-H (/ totx-H ind1-H))
(setq ymoyen-H (/ toty-H ind1-H))
(setq cxyz-H (list xmoyen-H ymoyen-H))
(setq cxyz-H (trans cxyz-H 0 1))

	(command "_area" "_o" s1-H)
	(setq surfpoly-H (getvar "area"))
	(setq surf1-H surfpoly-H)
	(setq surfpoly-H (rtos surfpoly-H 2 1))
	(setq surfpoly-H (strcat surfpoly-H " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-H 0.20 100 surfpoly-H)

        (setq ind-H (1+ ind-H))

        )							;fin du while
    )                                                           ;fin de if  


;;; LTG ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shon_LTG" "l" "GEX_EDS_shon_LTG_su" "")

(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_LTG") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_LTG") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shon_LTG") 
(command "-hachures" "s" sel-L "" "")  
(command "clayer" "GEX_EDS_shon_LTG_su")

(setq sel1-L (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shon_LTG"))))
(command "_draworder" "p" "" "_back")
(setq ind-L 0 surftotal-L 0 surfad-L 0 somme-L 0)

      (if (/= sel1-L nil)						;debut du if
	(while (setq nm-L (ssname sel1-L ind-L))			;debut du while
	(setq s1-L (cdr (assoc -1 (entget nm-L))))
	(setq entite-L (entget nm-L))
	(setq ind1-L 0 totx-L 0 toty-L 0)
	  
	(setq entite-L (entget s1-L))
(setq entite-L (member (assoc 72 entite-L) entite-L))

(while (= (car(assoc 11 entite-L)) 11)
(setq x-L (nth 1 (assoc 11 entite-L)))
(setq y-L (nth 2 (assoc 11 entite-L)))
(setq totx-L (+ totx-L x-L))
(setq toty-L (+ toty-L y-L))
(setq entite-L (member (assoc 72 entite-L) entite-L))
(setq entite-L (member (assoc 11 entite-L) entite-L))
(setq ind1-L (1+ ind1-L))
)								;fin du while

(setq xmoyen-L (/ totx-L ind1-L))
(setq ymoyen-L (/ toty-L ind1-L))
(setq cxyz-L (list xmoyen-L ymoyen-L))
(setq cxyz-L (trans cxyz-L 0 1))

	(command "_area" "_o" s1-L)
	(setq surfpoly-L (getvar "area"))
	(setq surf1-L surfpoly-L)
	(setq surfpoly-L (rtos surfpoly-L 2 1))
	(setq surfpoly-L (strcat surfpoly-L " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-L 0.20 100 surfpoly-L)

        (setq ind-L (1+ ind-L))

        )							;fin du while
    )                                                           ;fin de if


;;; Parking ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shon_PK" "l" "GEX_EDS_shon_PK_su" "")

(setq sel-P (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_PK") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_PK") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shon_PK") 
(command "-hachures" "s" sel-P "" "")  
(command "clayer" "GEX_EDS_shon_PK_su")

(setq sel1-P (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shon_PK"))))
(command "_draworder" "p" "" "_back")
(setq ind-P 0 surftotal-P 0 surfad-P 0 somme-P 0)

      (if (/= sel1-P nil)						;debut du if
	(while (setq nm-P (ssname sel1-P ind-P))			;debut du while
	(setq s1-P (cdr (assoc -1 (entget nm-P))))
	(setq entite-P (entget nm-P))
	(setq ind1-P 0 totx-P 0 toty-P 0)
	  
	(setq entite-P (entget s1-P))
(setq entite-P (member (assoc 72 entite-P) entite-P))

(while (= (car(assoc 11 entite-P)) 11)
(setq x-P (nth 1 (assoc 11 entite-P)))
(setq y-P (nth 2 (assoc 11 entite-P)))
(setq totx-P (+ totx-P x-P))
(setq toty-P (+ toty-P y-P))
(setq entite-P (member (assoc 72 entite-P) entite-P))
(setq entite-P (member (assoc 11 entite-P) entite-P))
(setq ind1-P (1+ ind1-P))
)								;fin du while

(setq xmoyen-P (/ totx-P ind1-P))
(setq ymoyen-P (/ toty-P ind1-P))
(setq cxyz-P (list xmoyen-P ymoyen-P))
(setq cxyz-P (trans cxyz-P 0 1))

	(command "_area" "_o" s1-P)
	(setq surfpoly-P (getvar "area"))
	(setq surf1-P surfpoly-P)
	(setq surfpoly-P (rtos surfpoly-P 2 1))
	(setq surfpoly-P (strcat surfpoly-P " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-P 0.20 100 surfpoly-P)

        (setq ind-P (1+ ind-P))

        )							;fin du while
    )                                                           ;fin de if


;;; surface non close ;;;
  
(command "_layer" "_make" 0 "_freeze" "*" "l" "GEX_EDS_shon_SNC" "l" "GEX_EDS_shon_SNC_su" "")

(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_SNC") (-4 . "and>")
		       		   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_SNC") (-4 . "and>") (-4 . "or>"))))

(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
(command "clayer" "GEX_EDS_shon_SNC") 
(command "-hachures" "s" sel-S "" "")  
(command "clayer" "GEX_EDS_shon_SNC_su")

(setq sel1-S (ssget "X" (list (cons 0 "HATCH")(cons 8 "GEX_EDS_shon_SNC"))))
(command "_draworder" "p" "" "_back")
(setq ind-S 0 surftotal-S 0 surfad-S 0 somme-S 0)

      (if (/= sel1-S nil)						;debut du if
	(while (setq nm-S (ssname sel1-S ind-S))			;debut du while
	(setq s1-S (cdr (assoc -1 (entget nm-S))))
	(setq entite-S (entget nm-S))
	(setq ind1-S 0 totx-S 0 toty-S 0)
	  
	(setq entite-S (entget s1-S))
(setq entite-S (member (assoc 72 entite-S) entite-S))

(while (= (car(assoc 11 entite-S)) 11)
(setq x-S (nth 1 (assoc 11 entite-S)))
(setq y-S (nth 2 (assoc 11 entite-S)))
(setq totx-S (+ totx-S x-S))
(setq toty-S (+ toty-S y-S))
(setq entite-S (member (assoc 72 entite-S) entite-S))
(setq entite-S (member (assoc 11 entite-S) entite-S))
(setq ind1-S (1+ ind1-S))
)								;fin du while

(setq xmoyen-S (/ totx-S ind1-S))
(setq ymoyen-S (/ toty-S ind1-S))
(setq cxyz-S (list xmoyen-S ymoyen-S))
(setq cxyz-S (trans cxyz-S 0 1))

	(command "_area" "_o" s1-S)
	(setq surfpoly-S (getvar "area"))
	(setq surf1-S surfpoly-S)
	(setq surfpoly-S (rtos surfpoly-S 2 1))
	(setq surfpoly-S (strcat surfpoly-S " m²"))

	(command "_TEXT" "S" "surf" "_justify" "MC" cxyz-S 0.20 100 surfpoly-S)

        (setq ind-S (1+ ind-S))

        )							;fin du while
    )                                                           ;fin de if    

  
(command "_layer" "_thaw" "*" "_make" 0  "_freeze" "GEX_EDS_shob_teinte_contour" "")
(setvar "osmode" os)
    (princ "\n")
    (princ)
)

;===================================================
TABLEAU SDP
;===================================================

(defun c:sht ()


;===================================== CONTOUR BATI ======================================
	(setq ind 0 total_val_text_cb 0 total 0)
	(setq sel_cb (ssget "x" (list (cons 8 "GEX_EDS_shob_contour_su") (cons 0 "TEXT"))))
	(while (setq nm (ssname sel_cb ind))
		(setq val_text_cb (assoc 1 (entget nm)) 
			val_text_cb (atof (cdr val_text_cb)) 
			total_val_text_cb (+ total val_text_cb) 
			total total_val_text_cb
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "CB" "0" "0" (rtos total_val_text_cb 2 0))

;======================================== VIDE ===========================================

	(setq ind 0 total_val_text_v 0 total 0)
	(setq sel_v (ssget "x" (list (cons 8 "GEX_EDS_shob_tremie_su") (cons 0 "TEXT"))))
(if (/= sel_v nil)
	(progn
	(while (setq nm (ssname sel_v ind))
		(setq val_text_v (assoc 1 (entget nm)) 
			val_text_v (atof (cdr val_text_v)) 
			total_val_text_v (+ total val_text_v) 
			total total_val_text_v
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "V" "0" "0" (rtos total_val_text_v 2 0))
))


;====================================== TOTAL SHOB =======================================

	(setq total_val_text_shob (- (atof (rtos total_val_text_cb 2 0)) (atof (rtos total_val_text_v 2 0)) ))
        (setq total_val_text_shob (rtos total_val_text_shob 2 0))

(command "-attedit" "N" "N" "SHON" "SHOB" "0" "0" total_val_text_shob)


;==================================== LOCAUX TECHNIQUE ===================================

	(setq ind 0 total_val_text_lt 0 total 0)
	(setq sel_lt (ssget "x" (list (cons 8 "GEX_EDS_shon_LTG_su") (cons 0 "TEXT"))))
(if (/= sel_lt nil)
	(progn
	(while (setq nm (ssname sel_lt ind))
		(setq val_text_lt (assoc 1 (entget nm)) 
			val_text_lt (atof (cdr val_text_lt)) 
			total_val_text_lt (+ total val_text_lt) 
			total total_val_text_lt
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "LT" "0" "0" (rtos total_val_text_lt 2 0))
))

;======================================= CAVE ==========================================

	(setq ind 0 total_val_text_c 0 total 0)
	(setq sel_c (ssget "x" (list (cons 8 "GEX_EDS_shon_cave_su") (cons 0 "TEXT"))))
(if (/= sel_c nil)
	(progn
	(while (setq nm (ssname sel_c ind))
		(setq val_text_c (assoc 1 (entget nm)) 
			val_text_c (atof (cdr val_text_c)) 
			total_val_text_c (+ total val_text_c) 
			total total_val_text_c
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "C" "0" "0" (rtos total_val_text_c 2 0))
))

;======================================= H 180 =========================================

	(setq ind 0 total_val_text_180 0 total 0)
	(setq sel_180 (ssget "x" (list (cons 8 "GEX_EDS_shon_h-180_su") (cons 0 "TEXT"))))
(if (/= sel_180 nil)
	(progn
	(while (setq nm (ssname sel_180 ind))
		(setq val_text_180 (assoc 1 (entget nm)) 
			val_text_180 (atof (cdr val_text_180)) 
			total_val_text_180 (+ total val_text_180) 
			total total_val_text_180
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "180" "0" "0" (rtos total_val_text_180 2 0))
))

;======================================== SNC ==========================================

	(setq ind 0 total_val_text_snc 0 total 0)
	(setq sel_snc (ssget "x" (list (cons 8 "GEX_EDS_shon_SNC_su") (cons 0 "TEXT"))))
(if (/= sel_snc nil)
(progn
	(while (setq nm (ssname sel_snc ind))
		(setq val_text_snc (assoc 1 (entget nm)) 
			val_text_snc (atof (cdr val_text_snc)) 
			total_val_text_snc (+ total val_text_snc) 
			total total_val_text_snc
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "SNC" "0" "0" (rtos total_val_text_snc 2 0))
))

;====================================== STATIONEMENT ========================================

	(setq ind 0 total_val_text_s 0 total 0)
	(setq sel_s (ssget "x" (list (cons 8 "GEX_EDS_shon_PK_su") (cons 0 "TEXT"))))
(if (/= sel_s nil)
	(progn
	(while (setq nm (ssname sel_s ind))
		(setq val_text_s (assoc 1 (entget nm)) 
			val_text_s (atof (cdr val_text_s)) 
			total_val_text_s (+ total val_text_s) 
			total total_val_text_s
			ind (1+ ind))
	)
(command "-attedit" "N" "N" "SHON" "S" "0" "0" (rtos total_val_text_s 2 0))
))

;====================================== ISOLATION ========================================

(setq choix "Locaux")
(initget "Locaux Habitation Mixte" )
(setq choix (getkword "\n Locaux, Habitation, Mixte : <Locaux> "))
	(if (= choix nil)(setq choix "Locaux"))
	(if (= choix "Mixte")
	(setq total_val_text_i (*(getint "\n Entrer la superficie de locaux d'habitation : ")0.05))
	)
	(if (= choix "Locaux")
	(setq total_val_text_i 0)
	)
	(if (= choix "Habitation")
	(setq total_val_text_i (* (- (atof total_val_text_shob) total_val_text_lt total_val_text_c total_val_text_180 total_val_text_snc total_val_text_s )0.05))
	)
(command "-attedit" "N" "N" "SHON" "I" "0" "0" (rtos total_val_text_i 2 0))

;========================================= SHON ===========================================

      (setq total_val_text_shon (- (atof total_val_text_shob) (atof (rtos total_val_text_lt 2 0)) (atof (rtos total_val_text_c 2 0)) 
      (atof (rtos total_val_text_180 2 0)) (atof (rtos total_val_text_snc 2 0)) (atof (rtos total_val_text_s 2 0)) (atof (rtos total_val_text_i 2 0)) ))
      (setq total_val_text_shon (atoi (rtos total_val_text_shon 2 0)))
(command "-attedit" "N" "N" "SHON" "SHON" "0" "0" (rtos total_val_text_shon 2 0))
)
(princ)
;=================================== FIN DE PROGRAMME =====================================

;================================== DEBUT DE PROGRAMME ====================================
;================ MISE A ZERO DE TOUTES LES VALEURS DU TABLEAU SHOB SHON ==================

(defun c:sh0 ()
	(command "-attedit" "N" "N" "SHON" "cb" (rtos total_val_text_cb 2 0) (rtos total_val_text_cb 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "V" (rtos total_val_text_v 2 0) (rtos total_val_text_v 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "shob" total_val_text_shob total_val_text_shob "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "lt" (rtos total_val_text_lt 2 0) (rtos total_val_text_lt 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "c" (rtos total_val_text_c 2 0) (rtos total_val_text_c 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "180" (rtos total_val_text_180 2 0) (rtos total_val_text_180 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "snc" (rtos total_val_text_snc 2 0) (rtos total_val_text_snc 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "s" (rtos total_val_text_s 2 0) (rtos total_val_text_s 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "i" (rtos total_val_text_i 2 0) (rtos total_val_text_i 2 0) "0" )
	(command "_regen")
	(command "-attedit" "N" "N" "SHON" "shon" (atoi (rtos total_val_text_shon 2 0)) (atoi (rtos total_val_text_shon 2 0)) "0" )
	(command "_regen")
	)
;=================================== FIN DE PROGRAMME =====================================