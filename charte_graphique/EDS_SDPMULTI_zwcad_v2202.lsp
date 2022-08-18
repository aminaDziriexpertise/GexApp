; ========================================================================== ;
; SDPMULTIDST + TCB : Calcul de SDP pour plusieurs destintions 
;                     et insertion d'une sous-légende pauser destintionstion
; ========================================================================== ;
; ========================= CODE SDP ======================================= ;
;;; Split text suivant un delimiteur
(setq launchSdpMultiCounter 1)
(defun split ( str del / pos ) 
	; Renvoie une liste de strings d'une chaîne divisée par un espace chacun
    ; Remarque: deux espaces consécutifs seront vus comme s'il y avait une chaîne vide entre eux
    (if (setq pos (vl-string-search del str))
        (cons (substr str 1 pos) (split (substr str (+ pos 1 (strlen del))) del))
        (list str)
    )	
)

;;; Fonction qui recuperer la liste des calques préfixés par "searchparamtext"
(defun getLayer(searchparamtext)
	(setq searchparam (strcat "*" searchparamtext "*"))
	
	(while (/= (setq newelem (tblnext "layer")) nil); Start loop for remaining layers
		(if (= (wcmatch (cdr (assoc 2 newelem)) searchparam) T) (setq newelem (list (cdr (assoc 2 newelem)))) (setq newelem nil)); Check each Layer
		(if (/= nil newelem) (setq laylist (append laylist newelem)))	; Add to Layer list if appropriate
	)	
	;(setq laylist (acad_strlsort laylist))
	(setq listlength (rtos (length laylist) 2 0))
	;(alert (strcat "There are " listlength " layers that contain \"" searchparamtext "\""))
	(princ laylist)
  )

;;; Calcul d'un point interne à la polyligne  
(defun centre_gravite (liste_points)
	(setq aire 0 x 0 y 0 total_x 0.0 total_y 0.0)
	(setq ind 0 n (- (length liste_points) 1))
	
	(while (<= ind (- n 1)) 
		(setq P_i0 (nth ind liste_points) P_i1 (nth (1+ ind) liste_points))
		(setq P_i0x (nth 0 P_i0)
			  P_i0y (nth 1 P_i0)
			  P_i1x (nth 0 P_i1)
			  P_i1y (nth 1 P_i1)
			  
			  alpha_i (- (* P_i0x P_i1y) (* P_i0y P_i1x)) 
			  aire (+ aire alpha_i)
			  total_x (+ total_x (* (+ P_i0x P_i1x) alpha_i))
			  total_y (+ total_y (* (+ P_i0y P_i1y) alpha_i))
		)
		(setq aire (/ aire 2))
		(setq ind (1+ ind))
	) ;end while
	
	(setq x (/ total_x (* aire 6))
		  y (/ total_y (* aire 6))
		  point (list x y)	)
		  
	(princ point) ;point du centre de gravite
)
;;; Fonction de recuperation du Calque et de calcul la surface à afficher sur la hachure de ce calque







(defun getCalqueAppliqueApplat(calqueC iscontour)
	;;; de l'ensemble des contours du calque passé en parametre 
	(setq sel1 (ssget "x" (list (cons 0 "HATCH")(cons 8 calqueC))))
	(command "_draworder" "p" "" "_back")	
	(setq ind 0 surftotal 0 surfad 0 somme 0)
	(princ calqueC)
	
	(if (/= sel1 nil)						;si l'ensemble des elements du calque n'est pas vide 
		(while (setq nm (ssname sel1 ind))			;Recuperartion de chaque elemment de la liste issue de ssget (calque)
			(setq s1 (cdr (assoc -1 (entget nm))))	;recupere l'entité à partir de son nom 
			
			(setq entite (entget nm))
			(setq ind1 0 totx 0 toty 0)
			(setq entite (entget s1))
			(setq entite (member (assoc 72 entite) entite))

			; construction de la liste de point pur le calcul du centre de gravite 
			;(setq ptlist (list))
			
			(while (= (car(assoc 11 entite)) 11)	; recuperation du text designation et calcul de la position du texte à afficher
				(setq x (nth 1 (assoc 11 entite)))
				(setq y (nth 2 (assoc 11 entite)))
				(setq totx (+ totx x))
				(setq toty (+ toty y))
				(setq entite (member (assoc 72 entite) entite))
				(setq entite (member (assoc 11 entite) entite))
				(setq ind1 (1+ ind1))
				
				; Contruction de la liste des points du contour 
				;(setq pt (list x y 0.0) ptlist (cons pt ptlist) )

				 ;fin du while 2
				
			)

			(setq xmoyen (/ totx ind1))
			(setq ymoyen (/ toty ind1))
			(setq cxyz (list xmoyen ymoyen))
			(setq cxyz (trans cxyz 0 1))
			; (princ "Point moyen :") (princ cxyz)
			; (setq cxyz (centre_gravite ptlist))  ; determiner le centre de gravité
			; (setq cxyz (trans cxyz 0 1))
			; (princ "\n Centre de gravite  : ") (princ cxyz)


			(command "_area" "_o" s1)			; calcul de l'aire de la polyligne 			
			(setq surfpoly (getvar "area"))
			(setq surfpoly (rtos surfpoly 2 1))
			(setq surfpoly (strcat surfpoly " m\\U+00B2"))  ; valeur à afficher et mettre carré
			;; calcul du centre 
			(princ s1) (princ " entity name  \n")
			(command "-EDITHACH" s1 "c" "r" "o")				 
			(setq centroidPoint (centreIner s1))

			(if (= iscontour 1) (command "_TEXT" "S" "surf" "_justify" "MC" centroidPoint 0.3 100 surfpoly))
			(if (= iscontour 0) (command "_TEXT" "S" "surf" "_justify" "MC" centroidPoint 0.1 100 surfpoly))
			(setq ind (1+ ind)) )							   ;fin du while 1
    )                                                          ;fin de if
)  


(defun centreIner (s1)
  (setq Last_region (entlast))
  (setq lst nil)
  (vl-load-com)
  (if entlast
    (progn
       (setq anObj (vlax-ename->vla-object (entlast)))
       (princ (strcat "\nObject Name: " (setq objName (vla-Get-ObjectName anObj))))
        (if (equal objName "AcDbRegion")
        (progn
          (setq vCentroid (vla-Get-Centroid anObj))
          (setq strCentroidProp (vl-princ-to-string (setq CentroidLst
          (vlax-safearray->list (vlax-variant-value vCentroid)))))
          (if (< (length CentroidLst) 3)
           (setq CentroidLst (append CentroidLst (list 0.0)))
          )
          (princ CentroidLst)
          (princ (strcat "\nRegion Centroid: " strCentroidProp))
          (setvar "PDMODE" 3)
          (setq *MS* (vla-Get-ModelSpace (setq acadDoc
          (vla-Get-ActiveDocument (setq acadApp (vlax-get-acad-object))))))
          (setq ptObj (vla-AddPoint *MS* (vlax-3d-Point CentroidLst)))
          (vla-Put-Color ptObj acYellow)
        )
        (princ "\nRegion was not selected !")
       )
    )
  )
 (princ CentroidLst)

)


;;; Fonction de selection des elements dans un calque
(defun SWC (contour calqdeduction select_type / pac add ss i temp i2)
  (vl-load-com)
  (defun _pac (e / l v d lst)
    (setq d (- (setq v (/ (setq l (vlax-curve-getDistAtParam e (vlax-curve-getEndParam e))) 100.))))
    (while (< (setq d (+ d v)) l)
      (setq lst (cons (trans (vlax-curve-getPointAtDist e d) 0 1) lst))
    ))
	
  (setq filtre_point (list (cons 0 "TEXT") (cons 8 calqdeduction)))
  
  (if (setq add (ssadd)  ss  (ssget "X" (list (cons 8 contour) )))
    (progn (repeat (setq i (sslength ss))
				(if (= select_type "in")
					(if (setq temp (ssget "_WP" (_pac (ssname ss (setq i (1- i)))) filtre_point))
						(repeat (setq i2 (sslength temp)) (ssadd (ssname temp (setq i2 (1- i2))) add)))
					
					(if (setq temp (ssget "F" (_pac (ssname ss (setq i (1- i)))) filtre_point))
						(repeat (setq i2 (sslength temp)) (ssadd (ssname temp (setq i2 (1- i2))) add)))
				)
           )
           (princ add)  )
	(princ add) )
)


;;; Fonction qui recupere le texte des hachures et calcule les elements de la legende puis les affiche
(defun getDesignationEtAfficheValeur(contourSDP calqueD Bloc texte)
	(princ calqueD)
	(command "tilemode" "1")
	
	(setq ind 0 ind2 0 total_val 0 total 0)
	(setq sel_SP (SWC contourSDP calqueD "in"))
	;(setq sel_SP2 (SWC contourSDP calqueD "cross"))	
	(command "_draworder" "p" "" "_back")	
	
	(if (/= sel_SP nil) ;(if (or (/= sel_SP nil) (/= sel_SP2 nil))
		(progn
			(while (setq nm (ssname sel_SP ind))
				(setq val_text_SP (assoc 1 (entget nm))
					val_text_SP (atof (cdr val_text_SP))
					total_val (+ total val_text_SP)
					total total_val
					ind (1+ ind)) 
			)
			; (while (setq nm (ssname sel_SP2 ind2))
				; (setq val_text_SP (assoc 1 (entget nm))
					; val_text_SP (atof (cdr val_text_SP))
					; total_val (+ total val_text_SP)
					; total total_val
					; ind2 (1+ ind2)) 
			; )			
			(command "tilemode" "0")
			(command "-attedit" "N" "N" Bloc texte "0" "0" (rtos total_val 2 0))
			(princ total_val)
		)
		(progn 
			(command "tilemode" "0")
			(princ total_val)
		)
	)
)


;;; Construction de la liste des points du comptour à partir de ma "selection set"
(defun cons_list_de_contour (contourSDP)
	(setq li (list (list 0.0 0.0)) ind 0)
	
	(if (/= contourSDP nil)
		(progn 
			(while (setq nm (ssname contourSDP ind))			;Recuperartion de chaque elemment de la liste issue de ssget (calque)
				(setq entite (entget nm))
				(setq entite (member (assoc 91 entite) entite))
				
				(while (= (car (assoc 10 entite)) 10)
					(setq elt (assoc 10 entite))
					(setq x (nth 1 elt))
					(setq y (nth 2 elt))
					
					(setq pair_pointer (list x y))					
					(setq li (append li (list pair_pointer)))
					
					(setq entite (member (assoc 91 entite) entite))
					(setq entite (member (assoc 10 entite) entite))
				)
				(setq ind (1+ ind)) 
			) ; end while 
	
			(setq li (cdr li))
			(setq li (append li (list (nth 0 li))))
		)
	) ; end IF
	(princ li)
);fin construction de la liste des contours
	


;;; Fonction qui efface les elements du calque 0
(defun effacer_entite	()
	(setq liste_de_liste1 (ssget "x" (list (cons 8 "0"))))	
	(setq variable_decrementation 0)
	(print (sslength liste_de_liste1))
	
	(repeat (sslength liste_de_liste1)
		(setq e (ssname liste_de_liste1 variable_decrementation))
		(command "_erase" e "")
		(setq variable_decrementation (1+ variable_decrementation))
	) 
	(princ)
)



;;; Fonction SDP (hachures et texte de surfaces) -----------
(defun sdpm (calquesSDP)
	; importation du style à utiliser
	(setq lay_contour_sdp (list "GEX_EDS_sdp_1-artisanat" "GEX_EDS_sdp_1-bureau" "GEX_EDS_sdp_1-commerce" "GEX_EDS_sdp_1-entrepot" "GEX_EDS_sdp_1-exploitation"
								"GEX_EDS_sdp_1-spic" "GEX_EDS_sdp_1-industrie" "GEX_EDS_sdp_1-hotelier" "GEX_EDS_sdp_1-habitation")
		  lay_tremie "GEX_EDS_sdp_2-tremie"
		  lay_h_180 "GEX_EDS_sdp_3-h-180"
		  lay_pk "GEX_EDS_sdp_5-pk"
		  lay_combles "GEX_EDS_sdp_6-combles"
		  lay_lt "GEX_EDS_sdp_7-lt"
		  lay_caves "GEX_EDS_sdp_8-cave")
	(if (=  (tblsearch "style" "SURF") nil)(command "_STYLE" "SURF" "swissl.ttf" "0.000" "" "" "" "" ""))

	; création des calques tampons à utiliser dans le programme pour sauvegarder les texte de surfaces 
	(if (=  (tblsearch "layer" "GEX_EDS_sdp_teinte_contour") nil)(command "-layer" "n" "GEX_EDS_sdp_teinte_contour" "Co" "U" "255,127,127" "GEX_EDS_sdp_teinte_contour" ""))
	(if (=  (tblsearch "layer" "GEX_EDS_sdp_SDP_su") nil)(command "-layer" "n" "GEX_EDS_sdp_SDP_su" "Co" "U" "255,0,0" "GEX_EDS_sdp_SDP_su" ""))	
	(if (=  (tblsearch "layer" (strcat lay_tremie "_su")) nil)(command "-layer" "n" (strcat lay_tremie "_su") "_color" "7" (strcat lay_tremie "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_h_180 "_su")) nil)(command "-layer" "n" (strcat lay_h_180 "_su") "_color" "7" (strcat lay_h_180 "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_pk "_su")) nil)(command "-layer" "n" (strcat lay_pk "_su") "_color" "7" (strcat lay_pk "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_combles "_su")) nil)(command "-layer" "n" (strcat lay_combles "_su") "_color" "7" (strcat lay_combles "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_lt "_su")) nil)(command "-layer" "n" (strcat lay_lt "_su") "_color" "7" (strcat lay_lt "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_caves "_su")) nil)(command "-layer" "n" (strcat lay_caves "_su") "_color" "7" (strcat lay_caves "_su") ""))

	;;; Traitement du Planchers avant déductions 	
	(command "-calque" "l" "0" "")
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_teinte_contour" "l" "GEX_EDS_sdp_SDP_su" "")
	
	(foreach element calquesSDP	
		(command "-calque" "e" "0" "" )
		(command "-calque" "l" element "")
		
		(setq sel (ssget "X" (list (cons -4 "<or")(cons -4 "<and") (cons 0 "LWPOLYLINE")(cons 8 element) 
									(cons -4 "and>")(cons -4 "<and") (cons 0 "CIRCLE")(cons 8 element)
									(cons -4 "and>") (cons -4 "or>"))))
		
		(if (/= sel nil)
			(progn
				(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
				(command "_clayer" "GEX_EDS_sdp_teinte_contour")  
				(command "-hachures" "s" sel "" "")
			)
		)

	)
	(command "_clayer" "GEX_EDS_sdp_SDP_su")	
	(getCalqueAppliqueApplat "GEX_EDS_sdp_teinte_contour" 1)
	
	;;; Vides ;;;  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_2-tremie" "l" "GEX_EDS_sdp_2-tremie_su" "")

	(setq sel-T (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>") (-4 . "or>"))))
	
	(if (/= sel-T nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_2-tremie") 
			(command "-hachures" "s" sel-T "" "")  
			(command "_clayer" "GEX_EDS_sdp_2-tremie_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_2-tremie" 0)
		))

	;;; Surfaces dont h < 1.80 m ;;;
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_3-h-180" "l" "GEX_EDS_sdp_3-h-180_su" "")

	(setq sel-C (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>") (-4 . "or>"))))
	
	(if (/= sel-C nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_3-h-180") 
			(command "-hachures" "s" sel-C "" "")  
			(command "_clayer" "GEX_EDS_sdp_3-h-180_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_3-h-180" 0)
		)
	)


	;;; Stationnement ;;;	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_5-pk" "l" "GEX_EDS_sdp_5-pk_su" "")

	(setq sel-H (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_5-pk") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_5-pk") (-4 . "and>") (-4 . "or>"))))

	(if (/= sel-H nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_5-pk") 
			(command "-hachures" "s" sel-H "" "")  
			(command "_clayer" "GEX_EDS_sdp_5-pk_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_5-pk" 0)
	))

	;;; Combles ;;;	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_6-combles" "l" "GEX_EDS_sdp_6-combles_su" "")

	(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>") (-4 . "or>"))))

	(if (/= sel-L nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_6-combles") 
			(command "-hachures" "s" sel-L "" "")  
			(command "_clayer" "GEX_EDS_sdp_6-combles_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_6-combles" 0)
	))


	;;; Locaux techniques ;;;	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_7-lt" "l" "GEX_EDS_sdp_7-lt_su" "")

	(setq sel-P (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_7-lt") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_7-lt") (-4 . "and>") (-4 . "or>"))))

	(if (/= sel-P nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_7-lt") 
			(command "-hachures" "s" sel-P "" "")  
			(command "_clayer" "GEX_EDS_sdp_7-lt_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_7-lt" 0)
	))


	;;; Caves ;;;	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_sdp_8-cave" "l" "GEX_EDS_sdp_8-cave_su" "")

	(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>") (-4 . "or>"))))

	(if (/= sel-S nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_8-cave") 
			(command "-hachures" "s" sel-S "" "")  
			(command "_clayer" "GEX_EDS_sdp_8-cave_su")
			(getCalqueAppliqueApplat "GEX_EDS_sdp_8-cave" 0)
	))
  
	(command "-layer" "l" "*" "e" 0 "g" "GEX_EDS_sdp_teinte_contour" "")
	(setvar "osmode" os)
)
; ========================== Commande : SDPMULTIDST ========================== ; 

(defun c:SDPMULTIDST()
	;(funINIT)
	(setq os (getvar "osmode"))
	(setvar "osmode" 0)
	(setvar "HPISLANDDETECTIONMODE" 0)
	(if (= (= launchSdpMultiCounter 1) T)(
				
			
				(setq launchSdpMultiCounter (+ launchSdpMultiCounter 1))	
				; Recupérer la liste des calques des contours sdp-1 contenus dans mon dessin
				(setq calquesSDP (getLayer "GEX_EDS_sdp_1-"))
				
				; Cacul des surfaces + textes de chaque polyligne de sdp et creation des hachures 
				(sdpm calquesSDP)
		
	; Pour chaque calque C dans la liste de calques (faire) 
					(foreach C calquesSDP						
						; Recupérer dans une variable le contour SDP correspondant 
						(command "tilemode" "1")
						(setq contourSDP (ssget "X" (list (cons -4 "<or")(cons -4 "<and") (cons 0 "LWPOLYLINE")(cons 8 C) (cons -4 "and>")
														(cons -4 "<and") (cons 0 "CIRCLE")(cons 8 C) (cons -4 "and>") (cons -4 "or>"))))
														
						(if (/= contourSDP nil)
							(progn 	
								(command "tilemode" "0")	
								; recuperation du point où insérer la légende 
								(setq position_texte (getpoint "\n Pt d'insertion : "))
								(command "zoom" "ET")
								(effacer_entite)
								(setvar "clayer" "GEX_MEP_cartouche")
								(setvar "attdia" 0)
								(command "-inserer" "EDS_SDP_MULTI" position_texte "" "" "" "" "" "" "" "" "" "" "" "" "" "") 
								(setvar "attdia" 1)
								(command "changer" "dernier" "" "P" "CA" "GEX_MEP_cartouche" "" )
								
								; modifier l'entete du bloc 
								(setq destination (last (split (last (split C "_")) "-")))
								(command "-attedit" "N" "N" "EDS_SDP_MULTI" "TT" "0" "0" destination)

								; Calcul de l'aire du contour et insertion de la valeur dans ma sous-légende (note à changer le texte de la legende)
								(setq total_aire_CT (getDesignationEtAfficheValeur C "GEX_EDS_sdp_SDP_su" "EDS_SDP_MULTI" "SP"))
								(princ "after Contour SDP\n")
								
								;;================ Traitement des déductions============================================== 
								(setq total_aire_tremies (getDesignationEtAfficheValeur C "GEX_EDS_sdp_2-tremie_su" "EDS_SDP_MULTI" "V"))
								(setq total_aire_180 (getDesignationEtAfficheValeur C "GEX_EDS_sdp_3-h-180_su" "EDS_SDP_MULTI" "180"))
								(princ total_aire_180)
								
								;====================================== TOTAL TA ==========================================
								(setq total_val_TA (- (atof (rtos total_aire_CT 2 0)) (atof (rtos total_aire_tremies 2 0)) (atof (rtos total_aire_180 2 0)) ))
								(princ total_val_TA)
								(command "-attedit" "N" "N" "EDS_SDP_MULTI" "TA" "0" "0" (rtos total_val_TA 2 0))
								
								;================ Deductions supp SDP =====================================================
								(setq total_aire_pk (getDesignationEtAfficheValeur C "GEX_EDS_sdp_5-pk_su" "EDS_SDP_MULTI" "ST"))
								(setq total_aire_combles (getDesignationEtAfficheValeur C "GEX_EDS_sdp_6-combles_su" "EDS_SDP_MULTI" "CO"))
								(setq total_aire_lt (getDesignationEtAfficheValeur C "GEX_EDS_sdp_7-lt_su" "EDS_SDP_MULTI" "LT"))
								(setq total_aire_cave (getDesignationEtAfficheValeur C "GEX_EDS_sdp_8-cave_su" "EDS_SDP_MULTI" "C"))
								
								
								;====================================== ISOLATION =========================================
								; tester si C contient habitation 
								(if (= destination "habitation")
									(progn
										(setq total_val_isol (* (- (atof (rtos total_val_TA 2 0)) (atof (rtos total_aire_pk 2 0)) (atof (rtos total_aire_combles 2 0)) (atof (rtos total_aire_lt 2 0))
								(atof (rtos total_aire_cave 2 0))) 0.10))
										(command "-attedit" "N" "N" "EDS_SDP_MULTI" "ISOL" "0" "0" (rtos total_val_isol 2 0))
									)					
									(setq total_val_isol 0.0)
								)				
								(princ "apres test isol \n")
								;========================================= SDP ===========================================
								(setq total_val_sdp (- (atof (rtos total_val_TA 2 0)) (atof (rtos total_aire_pk 2 0)) (atof (rtos total_aire_combles 2 0)) (atof (rtos total_aire_lt 2 0))
								(atof (rtos total_aire_cave 2 0)) (atof (rtos total_val_isol 2 0)) ))
								
								(setq total_val_sdp (atoi (rtos total_val_sdp 2 0)))
								(princ total_val_sdp)
								(princ "\n")
								(command "-attedit" "N" "N" "EDS_SDP_MULTI" "SDP" "0" "0" (rtos total_val_sdp 2 0))
							) 
						) ;END IF
	  )	
	))
	(command "-layer" "l" "*" "e" 0 "g" "GEX_EDS_sdp_teinte_contour" "")
	;(command "tilemode" "0")
	;(command "-layer" "l" "*" "E" 0  "")
	(alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
	(setvar "osmode" os)
	(princ "\n")
	(princ)
	(if (= (/= launchSdpMultiCounter 1) T) ( boxMessagesdpMulti ))
)


;===============================counter ============================== ;; 
(defun boxMessagesdpMulti() 

     	(lspOkCancel "Commande lancer 2 fois " "appuyer sur cancel pour annuler" "Ou appuyer sur ok pour continuer" "warning !")
  		(if (= result T) (
		 	 (prompt "annuler les commandes precedente \n")
		 	 (command "annuler" "150" )
			 (alert "    *********  commande Annuler veuillez relancer vos calcul SDPMulti  *********        ")
			 (setq launchSdpMultiCounter 1)
		  )
		  )
        (if (= result nil) (prompt "annuler la commande actuelle \n"))
)


;=========================================================

(defun lspOkCancel (message1 message2 message3 main)

  (setq dcl_id (load_dialog "msgbox.dcl"))
  (if (not (new_dialog "lspOkCancel" dcl_id))
    (exit)
  )

  (set_tile "message1" message1)
  (set_tile "message2" message2)
  (set_tile "message3" message3)
  (set_tile "main" main)

  (action_tile "cancel" "(done_dialog) (setq result nil)")
  (action_tile "accept" "(done_dialog) (setq result T)" )
  (start_dialog)
  (unload_dialog dcl_id)
  (princ)
)
;;; ========================= CODE TCB ================================== ;;;
;;; Fonction TCB (hachures et texte de surfaces) 
(defun tcb_hatch()
	; Importation du style à utiliser
	(setq lay_contour_sdp (list "GEX_EDS_sdp_1-bureau" "GEX_EDS_sdp_1-commerce" "GEX_EDS_sdp_1-entrepot")
		  lay_tremie "GEX_EDS_sdp_2-tremie"
		  lay_h_180 "GEX_EDS_sdp_3-h-180"
		  lay_pk "GEX_EDS_sdp_5-pk"
		  lay_lt "GEX_EDS_sdp_7-lt"
		  lay_lc "GEX_EDS_rdv_loc_soc"
		  lay_san "GEX_EDS_rdv_sanitaires")

	(if (=  (tblsearch "style" "SURF") nil)(command "_STYLE" "SURF" "swissl.ttf" "0.000" "" "" "" "" ""))

	; Création des calques tampons à utiliser dans le programme pour sauvegarder les texte de surfaces 
	(if (=  (tblsearch "layer" "GEX_EDS_sdp_teinte_contour") nil)(command "-layer" "n" "GEX_EDS_sdp_teinte_contour" "CO" "U" "255,127,127" "GEX_EDS_sdp_teinte_contour" ""))
	(if (=  (tblsearch "layer" "GEX_EDS_sdp_SDP_su") nil)(command "-layer" "n" "GEX_EDS_sdp_SDP_su" "CO" "U" "255,0,0" "GEX_EDS_sdp_SDP_su" ""))	
	(if (=  (tblsearch "layer" (strcat lay_tremie "_su")) nil)(command "-layer" "n" (strcat lay_tremie "_su") "_color" "7" (strcat lay_tremie "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_h_180 "_su")) nil)(command "-layer" "n" (strcat lay_h_180 "_su") "_color" "7" (strcat lay_h_180 "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_pk "_su")) nil)(command "-layer" "n" (strcat lay_pk "_su") "_color" "7" (strcat lay_pk "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_lt "_su")) nil)(command "-layer" "n" (strcat lay_lt "_su") "_color" "7" (strcat lay_lt "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_lc "_su")) nil)(command "-layer" "n" (strcat lay_lc "_su") "_color" "7" (strcat lay_lc "_su") ""))
	(if (=  (tblsearch "layer" (strcat lay_san "_su")) nil)(command "-layer" "n" (strcat lay_san "_su") "_color" "7" (strcat lay_san "_su") ""))

	

	; Locaux sociaux 	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_rdv_loc_soc" "l" "GEX_EDS_rdv_loc_soc_su" "")
	(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_rdv_loc_soc") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_rdv_loc_soc") (-4 . "and>") (-4 . "or>"))))
	(if (/= sel-L nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_rdv_loc_soc") 
			(command "-hachures" "s" sel-L "" "")  
			(command "_clayer" "GEX_EDS_rdv_loc_soc_su")
			(getCalqueAppliqueApplat "GEX_EDS_rdv_loc_soc" 0)
	))

	; Sanitaires 	  
	(command "-layer" "e" 0 "g" "*" "l" "GEX_EDS_rdv_sanitaires" "l" "GEX_EDS_rdv_sanitaires_su" "")
	(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_rdv_sanitaires") (-4 . "and>")
						   (-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_rdv_sanitaires") (-4 . "and>") (-4 . "or>"))))
	(if (/= sel-S nil)
		(progn 
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_rdv_sanitaires") 
			(command "-hachures" "s" sel-S "" "")  
			(command "_clayer" "GEX_EDS_rdv_sanitaires_su")
			(getCalqueAppliqueApplat "GEX_EDS_rdv_sanitaires" 0)
	))
  
	(command "-layer" "l" "*" "e" 0 "g" "GEX_EDS_sdp_teinte_contour" "")
	(setvar "osmode" os)
)

