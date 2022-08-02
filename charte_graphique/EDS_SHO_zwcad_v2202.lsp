;===================================================
CALCUL DES SUPERFICIES SHOB /SHON
;===================================================
(setq launchShoCounter 1)
(defun c:sho( / sel1 ind surftotal surfad nm cal surf entite ind1 totx toty x y xmoyen ymoyen )
	(setq os (getvar "osmode"))
	(setvar "osmode" 0)
	(setvar "HPISLANDDETECTIONMODE" 0)

	(if (= (= launchShoCounter 1) T)(
				
					
			(setq launchShoCounter (+ launchShoCounter 1))	
			(if (=  (tblsearch "layer" "GEX_EDS_shob_contour") nil)(command "-layer" "n" "GEX_EDS_shob_contour" "CO" "U" "255,0,0" "GEX_EDS_shob_contour" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shob_tremie") nil)(command "-layer" "n" "GEX_EDS_shob_tremie" "CO" "U" "255,255,127" "GEX_EDS_shob_tremie" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_cave") nil)(command "-layer" "n" "GEX_EDS_shon_cave" "CO" "U" "255,191,127" "GEX_EDS_shon_cave" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_h-180") nil)(command "-layer" "n" "GEX_EDS_shon_h-180" "CO" "U" "165,82,82" "GEX_EDS_shon_h-180" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_ltg") nil)(command "-layer" "n" "GEX_EDS_shon_lTG" "CO" "U" "0,127,255" "GEX_EDS_shon_LTG" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_pk") nil)(command "-layer" "n" "GEX_EDS_shon_pk" "CO" "U" "153,153,153" "GEX_EDS_shon_PK" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_snc") nil)(command "-layer" "n" "GEX_EDS_shon_snc" "CO" "U" "191,255,127" "GEX_EDS_shon_SNC" ""))
			(if (=  (tblsearch "layer" "GEX_EDS_shob_teinte_contour") nil)(command "-layer" "n" "GEX_EDS_shob_teinte_contour" "CO" "U" "255,127,127" "GEX_EDS_shob_teinte_contour" "")"")
				
			(if (=  (tblsearch "layer" "GEX_EDS_shob_contour_su") nil)(command "-layer" "n" "GEX_EDS_shob_contour_su" "CO" "U" "255,0,0" "GEX_EDS_shob_contour_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shob_tremie_su") nil)(command "-layer" "n" "GEX_EDS_shob_tremie_su" "_color" "7" "GEX_EDS_shob_tremie_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_cave_su") nil)(command "-layer" "n" "GEX_EDS_shon_cave_su" "_color" "7" "GEX_EDS_shon_cave_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_h-180_su") nil)(command "-layer" "n" "GEX_EDS_shon_h-180_su" "_color" "7" "GEX_EDS_shon_h-180_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_ltg_su") nil)(command "-layer" "n" "GEX_EDS_shon_ltg_su" "_color" "7" "GEX_EDS_shon_LTG_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_pk_su") nil)(command "-layer" "n" "GEX_EDS_shon_pk_su" "_color" "7" "GEX_EDS_shon_PK_su" "")"")
			(if (=  (tblsearch "layer" "GEX_EDS_shon_snc_su") nil)(command "-layer" "n" "GEX_EDS_shon_snc_su" "_color" "7" "GEX_EDS_shon_SNC_su" "")"")

			(if (=  (tblsearch "style" "SURF") nil)(command "-STYLER" "SURF" "swissl.ttf" "0.000" "" "" "" "" "")"")

			;;; Contour bâti 	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shob_contour" "l" "GEX_EDS_shob_teinte_contour" "l" "GEX_EDS_shob_contour_su" "")""

			(setq sel (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shob_contour") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shob_contour") (-4 . "and>") (-4 . "or>"))))
			
			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shob_teinte_contour")  
			(command "-hachures" "s" sel "" "")  
			(command "_clayer" "GEX_EDS_shob_contour_su")
			
			(getCalqueAppliqueApplat "GEX_EDS_shob_teinte_contour" 1)


			;;; Tremie ;;;  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shob_tremie" "l" "GEX_EDS_shob_tremie_su" "")

			(setq sel-T (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shob_tremie") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shob_tremie") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shob_tremie") 
			(command "-hachures" "s" sel-T "" "")  
			(command "_clayer" "GEX_EDS_shob_tremie_su")
			(getCalqueAppliqueApplat "GEX_EDS_shob_tremie" 0)
		

			;;; caves ;;; 
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shon_cave" "l" "GEX_EDS_shon_cave_su" "")

			(setq sel-C (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_cave") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_cave") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shon_cave") 
			(command "-hachures" "s" sel-C "" "")  
			(command "_clayer" "GEX_EDS_shon_cave_su")
			(getCalqueAppliqueApplat "GEX_EDS_shon_cave" 0)
			

			;;; H-180 ;;;  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shon_h-180" "l" "GEX_EDS_shon_h-180_su" "")

			(setq sel-H (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_h-180") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_h-180") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shon_h-180") 
			(command "-hachures" "s" sel-H "" "")  
			(command "_clayer" "GEX_EDS_shon_h-180_su")
			(getCalqueAppliqueApplat "GEX_EDS_shon_h-180" 0)

			;;; LTG ;;;  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shon_LTG" "l" "GEX_EDS_shon_LTG_su" "")

			(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_LTG") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_LTG") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shon_LTG") 
			(command "-hachures" "s" sel-L "" "")  
			(command "_clayer" "GEX_EDS_shon_LTG_su")
			(getCalqueAppliqueApplat "GEX_EDS_shon_LTG" 0)


			;;; Parking ;;;  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shon_PK" "l" "GEX_EDS_shon_PK_su" "")

			(setq sel-P (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_PK") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_PK") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shon_PK") 
			(command "-hachures" "s" sel-P "" "")  
			(command "_clayer" "GEX_EDS_shon_PK_su")
			(getCalqueAppliqueApplat "GEX_EDS_shon_PK" 0)


			;;; surface non close ;;;	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_shon_SNC" "l" "GEX_EDS_shon_SNC_su" "")

			(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_shon_SNC") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_shon_SNC") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_shon_SNC") 
			(command "-hachures" "s" sel-S "" "")  
			(command "_clayer" "GEX_EDS_shon_SNC_su")
			(getCalqueAppliqueApplat "GEX_EDS_shon_SNC" 0)

		
			(command "-layer" "l" "*" "E" 0  "g" "GEX_EDS_shob_teinte_contour" "")
			(alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
			(setvar "osmode" os)
			(princ "\n")
			(princ)

	))		
		(if (= (/= launchShoCounter 1) T) ( boxMessagesho ))
	
)



;====================================init plan========================
(defun boxMessagesho() 

     	(lspOkCancel "Commande lancer 2 fois " "appuyer sur cancel pour annuler" "Ou appuyer sur ok pour continuer" "warning !")
  		(if (= result T) (
		 	 (prompt "annuler les commandes precedente \n")
		 	 (command "annuler" "90" )
			 (alert "         *********  commande Annuler veuillez relancer vos calculs SHO  *********        ")
			 (setq launchShoCounter 1)
			 
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




;;; fonction de recuperation du Calque et de calcul la surface à afficher
(defun getCalqueAppliqueApplat(calqueC iscontour)
	;(princ "\n calque courant\n")
	;(princ calqueC)
	(setq sel1 (ssget "X" (list (cons 0 "HATCH")(cons 8 calqueC))))
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
				;(princ entite)
			)
			;fin du while
			(setq xmoyen (/ totx ind1))
			(setq ymoyen (/ toty ind1))
			(setq cxyz (list xmoyen ymoyen))
			(setq cxyz (trans cxyz 0 1))
			(command "_area" "_o" s1)
			(setq surfpoly (getvar "area"))
			(setq surf1 surfpoly)
			(setq surfpoly (rtos surfpoly 2 1))
			(setq surfpoly (strcat surfpoly " m\\U+00B2"))
				;; calcul du centre 
			(princ s1) (princ " entity name  \n")
			(command "-EDITHACH" s1 "c" "r" "o")				 
			(setq centroidPointsho (centreInersho s1))
			(if (= iscontour 1) 
				(command "_TEXT" "S" "surf" "_justify" "MC" centroidPointsho 0.5 100 surfpoly)
				(command "_TEXT" "S" "surf" "_justify" "MC" centroidPointsho 0.15 100 surfpoly))
				
			(setq ind (1+ ind))
		)							;fin du while
	)      ;fin de if
)

;==================================centre Inert =====================

(defun centreInersho (s1)
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




;===================================================
;                    SDT :: TABLEAU SHOB 
;===================================================
(defun c:sht ()
	;===================================== CONTOUR BATI ======================================
	(setq total_val_text_cb (getDesignationEtAfficheValeurSHO "GEX_EDS_shob_contour_su" "CB"))

	;======================================== VIDE ===========================================
	(setq total_val_text_V (getDesignationEtAfficheValeurSHO "GEX_EDS_shob_tremie_su" "V"))

	;====================================== TOTAL SHOB =======================================
	(setq total_val_text_shob (- (atof (rtos total_val_text_cb 2 0)) (atof (rtos total_val_text_v 2 0)) ))
	(setq total_val_text_shob (rtos total_val_text_shob 2 0))
	(command "-attedit" "N" "N" "SHON" "SHOB" "0" "0" total_val_text_shob)
	
	;==================================== LOCAUX TECHNIQUE ===================================
	(setq total_val_text_lt (getDesignationEtAfficheValeurSHO "GEX_EDS_shon_LTG_su" "LT"))
	
	;======================================= CAVE ==========================================
	(setq total_val_text_c (getDesignationEtAfficheValeurSHO "GEX_EDS_shon_cave_su" "C"))
	
	;======================================= H 180 =========================================
	(setq total_val_text_180 (getDesignationEtAfficheValeurSHO "GEX_EDS_shon_h-180_su" "180"))

	;======================================== SNC ==========================================
	(setq total_val_text_snc (getDesignationEtAfficheValeurSHO "GEX_EDS_shon_SNC_su" "SNC"))
	
	;====================================== STATIONEMENT ========================================
	(setq total_val_text_s (getDesignationEtAfficheValeurSHO "GEX_EDS_shon_PK_su" "S"))
	

	;====================================== ISOLATION ========================================
	(setq choix "L")
	(initget "L H M" )
	(setq choix (getkword "\n Locaux(L), Habitation(H), Mixte(M) : <Locaux> ")) ; valeur par defaut si Nature vide == Locaux 
	(if (= choix nil)(setq choix "L"))
	(if (= choix "M")  ;deduction de 5% sur la surface d'habitation en cas de locaux de type mixte
		(setq total_val_text_i (*(getint "\n Entrer la superficie de locaux d'habitation : ")0.05))	)
		
	(if (= choix "L")
		(setq total_val_text_i 0))
		
	(if (= choix "H") ;deduction de 5% sur la surface totale en cas de locaux de type habitation
		(setq total_val_text_i (* (- (atof total_val_text_shob) total_val_text_lt total_val_text_c total_val_text_180 total_val_text_snc total_val_text_s )0.05)) 	)
		
	(command "-attedit" "N" "N" "SHON" "I" "0" "0" (rtos total_val_text_i 2 0))
	
	;===================================== Calcul du total SHON ===========================================
	(setq total_val_text_shon (- (atof total_val_text_shob) (atof (rtos total_val_text_lt 2 0)) (atof (rtos total_val_text_c 2 0)) 
	(atof (rtos total_val_text_180 2 0)) (atof (rtos total_val_text_snc 2 0)) (atof (rtos total_val_text_s 2 0)) (atof (rtos total_val_text_i 2 0)) ))
	(setq total_val_text_shon (atoi (rtos total_val_text_shon 2 0)))
	
	(command "-attedit" "N" "N" "SHON" "SHON" "0" "0" total_val_text_shon)
	(alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
	(setvar "osmode" os)
	(princ "\n")
	(princ)
)
(princ)

;;; fonction qui recupere le texte des hachures et calcule les elements de la legende puis les affiche
(defun getDesignationEtAfficheValeurSHO(calqueC texte)
	(print calqueC)
	(setq ind 0 total_val 0 total 0)
	(setq sel_SP (ssget "x" (list (cons 8 calqueC) (cons 0 "TEXT"))))	
	
	(if (/= sel_SP nil)	
		(progn
			(while (setq nm (ssname sel_SP ind))
				(setq val_text_SP (assoc 1 (entget nm))
					val_text_SP (atof (cdr val_text_SP))
					total_val (+ total val_text_SP)
					total total_val
					ind (1+ ind)) 
			)
			(command "-attedit" "N" "N" "SHON" texte "0" "0" (rtos total_val 2 0))
			(princ total_val)	
		)
		(princ total_val)
	)
)
;=================================== FIN SDT =====================================

;================================== CMD : SH0 ====================================
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