(defun MyHTTPRequest  (/ url data http_object)
 (setq
  url   "http://127.0.0.1:5000"
  ;;data "username=billythekid&email=thekid@billythekid.com" ;; this data is not XML, it's a plain http type of data string
  http_object (vlax-create-object "WinHTTP.WinHTTPRequest.5.1") ;; so we need to use this, not the XML lib
  )
 (vlax-invoke-method http_object 'open "GET" url :vlax-false)
 (vlax-invoke-method http_object 'SetRequestHeader "Content-type" "application/x-www-form-urlencoded")
 ;; not sure about below, maybe API handles string length for you??
 ;; (vlax-invoke-method http_object 'SetRequestHeader "Content-length" (strlen data))
 (vlax-invoke-method http_object 'send data)
 
 (print (vlax-get-property http_object "ResponseText"))
 (if http_object (vlax-release-object http_object))
 (princ)
 )

(defun MyRequest  (/ url data http_object)
 (setq
  url   "http://127.0.0.1:5000/test"
  data "username=billythekid&email=thekid@billythekid.com" ;; this data is not XML, it's a plain http type of data string
  inserted   (get_tile "insert") 
  http_object (vlax-create-object "WinHTTP.WinHTTPRequest.5.1") ;; so we need to use this, not the XML lib
  )
 ;(vlax-invoke-method http_object 'open "GET" url :vlax-false)
 (vlax-invoke-method http_object 'open "POST" url :vlax-false)
 (vlax-invoke-method http_object 'SetRequestHeader "Content-type" "application/x-www-form-urlencoded")
 ;; not sure about below, maybe API handles string length for you??
 ;; (vlax-invoke-method http_object 'SetRequestHeader "Content-length" (strlen data))
 (vlax-invoke-method http_object 'send inserted)
 (print http_object)
 (print inserted)
 (print (vlax-get-property http_object "ResponseText"))
 (if http_object (vlax-release-object http_object))
 (princ)
 )
 

(defun PostRequest  (/ url data http_object) 
 (setq url_inserted   (strcat(setq URL (get_tile "insert") )))
 (print URL)
 (setq
  url   "http://127.0.0.1:5000/endpoint"
  Amina  "Amina DZIRI"
  ;;data "username=billythekid&email=thekid@billythekid.com" ;; this data is not XML, it's a plain http type of data string
  URL_Input(get_tile "insert")
  http_object (vlax-create-object "WinHTTP.WinHTTPRequest.5.1") ;; so we need to use this, not the XML lib
  )
 (vlax-invoke-method http_object 'open "POST" url :vlax-false)
 (vlax-invoke-method http_object 'SetRequestHeader "Content-type" "application/x-www-form-urlencoded")
 ;; (vlax-invoke-method http_object 'SetRequestHeader "Content-length" (strlen data))
 (vlax-invoke-method http_object 'send url_inserted) ;envoyer lien du ticket ODOO
 
 (print (vlax-get-property http_object "ResponseText"))
 (if http_object (vlax-release-object http_object))
 (princ)
)

(defun GetFromWeb (strUrl / webObj stat res errobj)
  ;Code posted by user: BazzaCAD, 2010/03/29, from site:
  ;http://opendcl.com/forum/index.php?topic=1244.0
  (vl-load-com)
  ;; Set up variables
  (setq webObj nil stat nil res nil)
  ;; Create a new reference to the WinHttp object
  (setq webObj (vlax-invoke-method (vlax-get-acad-object) 'GetInterfaceObject "WinHttp.WinHttpRequest.5.1"))
  ;; Fetch web page
  (vlax-invoke-method webObj 'Open "GET" strUrl :vlax-false)
  (setq errobj (vl-catch-all-apply 'vlax-invoke-method (list webObj 'Send)))
  (if (null (vl-catch-all-error-p errobj))
    (progn
      (setq stat (vlax-get-property webObj 'Status))
      (if (= stat 200)
        (progn
          (setq res (vlax-get-property webObj 'ResponseText));_ Return the response value // 'ResponseText
        )
        (princ (strcat "\n!!! WEB server error: " (vlax-get-property webObj 'StatusText) "!!!"))
      )
    );_ progn
    (princ (strcat "\n!!! WEB server error:\n" (vl-catch-all-error-message errobj)))
  )
  res 
);defun

(defun JSON->LIST (json / )
;json - string, as json data
;returns - list, converted from json
(if (eq 'STR (type json)) (read (vl-string-translate "[]{}:," "()()  " json)))
);defun

(defun LIST->PAIRS (lst / ret tmp)
;this function is recursive
;lst - list, the list returned by "JSON->LIST", or similar
;returns - dotted pair lists or, in the case of nested lists, lists similar to points found in entities (item val1 val2 ...)
(setq ret '())
(if (listp lst)
  (foreach i lst
    (if (listp i)
      (setq ret (cons (list (LIST->PAIRS i)) ret))
      (if (eq 0 (rem (length (member i lst)) 2))
        (setq ret (cons (cons i (if (listp (setq tmp (cadr (member i lst)))) (LIST->PAIRS tmp) tmp)) ret))
      );if
    );if
  );foreach
;else
  (setq ret "")
);if
(reverse ret)
);defun

(defun CALL ( / url data)
(extract_nom_livrable)
(princ"\n")
(extract_nom_client)
(princ "\n")
(extract_address)
(princ "\n")
(extract_Cree__par)
(princ "\n")
(extract_Cree__le)
(princ "\n")
(extract_Cadastre)


);defun
;=========================================================================
  ;; get les champs qu'on doit les exporter apartir de URL odoo:
;=========================================================================  
(defun extract_nom_livrable (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/livrable")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
  (setvar 'cecolor "0")
  (setq x 1653948.6979)
  (setq y 8210384.5234)
  (setq z 0)
  (setq ans data)
  (command "Texte" (list x y z) 0.8 90 ans)
(princ)
)


(defun extract_nom_client (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/client")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
(princ)
)
(defun extract_address (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/address")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
  (setvar 'cecolor "0")
  (setq x 1653949.2493)
  (setq y 8210374.7985)
  (setq z 0)
  (setq ans data)
  (command "Texte" (list x y z) 0.3 90 ans)
  
(princ)
)

(defun extract_Cree__par (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/Cree__par")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
(princ)
)

(defun extract_Cree__le (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/Cree__le")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
(princ)
)
(defun extract_Cadastre (/ url data)
(vl-load-com)
;this url is open to everybody, it contains example data for anybody to test
 
(setq url "http://127.0.0.1:5000/Cadastre")
(if (and (setq data (GetFromWeb url))
    )
  (progn
    (princ data)
  )
)
  (setvar 'cecolor "0")
  (setq x 1653944.6071)
  (setq y 8210368.5850)
  (setq z 0)
  (setq ans data)
  (command "Texte" (list x y z) 0.9 90 ans)
(princ)
)



;=========================================================================
  ;; get HTTP :
;=========================================================================  
(defun Get-Http  (URL / util fn f txt)
  (setq util (vla-get-Utility (vla-get-ActiveDocument (vlax-get-acad-object))))
  (if (and (vla-IsURL util URL)
           (not (vl-catch-all-error-p
                  (vl-catch-all-apply 'vla-GetRemoteFile (list util URL 'fn :vlax-true))))
           (setq f (open fn "r")))
    (progn (while (setq fn (read-line f)) (setq txt (cons (strcat fn "\n") txt)))
           (close f)
           (apply 'strcat (reverse txt)))))
 
(defun c:GetExternalDATA  (/ data)
  (if (setq data (Get-Http "http://127.0.0.1:5000"))
    (vl-string-trim " \t\n" data)
  (princ data))
)
      
      
;=========================================================================
  ;; get file DWG :
;=========================================================================  


(defun openDWG ( target / rtn shl )
    (if (and (or (= 'int (type target)) (setq target (findfile target)))
             (setq shl (vla-getinterfaceobject (vlax-get-acad-object) "shell.application"))
        )
        (progn
            (setq rtn (vl-catch-all-apply 'vlax-invoke (list shl 'open target)))
            (vlax-release-object shl)
            (if (vl-catch-all-error-p rtn)
                (prompt (vl-catch-all-error-message rtn))
                t
            )
        )
    )
)

;=========================================================================
; Motif HASH Solid
;=========================================================================
(defun hsolid ( / acdc)
    (setq acdc (vla-get-activedocument (vlax-get-acad-object)))
    (vlax-for obj (vla-get-modelspace acdc)
        (if (= (vla-get-ObjectName obj) "AcDbHatch")
          (progn
            (vla-SetPattern obj acHatchPatternTypePreDefined "SOLID")
            (vla-Evaluate obj)
          )
        )
    )
    (vla-Regen acdc :vlax-true)
    (princ)
) 
(defun hsolid1()
 (command "-hachures" "p" "s" "" "") 
 (command "-hachures"  "" "") 
)
(vl-load-com) (princ)
;=========================================================================
; Motif HASH Angle
;=========================================================================
(defun hangle ( / acdc)
    (setq acdc (vla-get-activedocument (vlax-get-acad-object)))
    (vlax-for obj (vla-get-modelspace acdc)
        (if (= (vla-get-ObjectName obj) "AcDbHatch")
          (progn
            (vla-SetPattern obj acHatchPatternTypePreDefined "ANGLE")
            (vla-Evaluate obj)
          )
        )
    )
    (vla-Regen acdc :vlax-true)
    (princ)
) 
(defun hangle1()
 (command "-hachures" "p" "ANGLE" "" "" "") 
 (command "-hachures"  "" "") 
)
(vl-load-com) (princ)
;=========================================================================
; Motif HASH AnSI32
;=========================================================================
(defun hAnsi32 ( / acdc)
    (setq acdc (vla-get-activedocument (vlax-get-acad-object)))
    (vlax-for obj (vla-get-modelspace acdc)
        (if (= (vla-get-ObjectName obj) "AcDbHatch")
          (progn
            (vla-SetPattern obj acHatchPatternTypePreDefined "ANSI32")
            (vla-Evaluate obj)
          )
        )
    )
    (vla-Regen acdc :vlax-true)
    (princ)
) 
(defun hansi321()
 (command "-hachures" "p" "ANSI32" "" "" "") 
 (command "-hachures"  "" "") 
)
(vl-load-com) (princ)

;=========================================================================
; type Predeterminé
;========================================================================= 
 
(defun Predetermine()
 (command "-hachures" "p"  "" "" "") 
 ;(command "-hachures"  "" "") 
)
;=========================================================================
; type definieparUser
;========================================================================= 
 
(defun definieparUser()
 (command "-hachures" "U"  "" "" "") 
 ;(command "-hachures"  "" "") 
)
;=========================================================================
; ChangeStyleArial
;========================================================================= 
   
(defun ChangeStyleArial (/ new)
  (setq new (strcat (getenv "systemroot") "\\Fonts\\arial.ttf"))
  (vlax-map-collection
  (vla-get-textstyles
  (vla-get-activedocument
  (vlax-get-acad-object)))
  '(lambda (x / font)
  (setq font (strcase (vla-get-fontfile x)))
  (if (wcmatch font "ROMANS.SHX,SIMPLEX.SHX,TXT.SHX")
  (vla-put-fontfile x new)))
  )
  (princ)
) 
(vl-load-com) (princ)
;=========================================================================
; ChangeStyleSWISSBLACK
;========================================================================= 
   
(defun ChangeStyleSwiss (/ new)
  (setq new (strcat (getenv "systemroot") "\\Fonts\\SwissBlack.ttf"))
  (vlax-map-collection
  (vla-get-textstyles
  (vla-get-activedocument
  (vlax-get-acad-object)))
  '(lambda (x / font)
  (setq font (strcase (vla-get-fontfile x)))
  (if (wcmatch font "ROMANS.SHX,SIMPLEX.SHX,TXT.SHX")
  (vla-put-fontfile x new)))
  )
  (princ)
)
(vl-load-com) (princ)

;=========================================================================
; ChangeStyleRoman
;========================================================================= 
   
(defun ChangeStyleRoman (/ new)
  (setq new (strcat (getenv "systemroot") "\\Fonts\\RomanRegular.ttf"))
  (vlax-map-collection
  (vla-get-textstyles
  (vla-get-activedocument
  (vlax-get-acad-object)))
  '(lambda (x / font)
  (setq font (strcase (vla-get-fontfile x)))
  (if (wcmatch font "ROMANS.SHX,SIMPLEX.SHX,TXT.SHX")
  (vla-put-fontfile x new)))
  )
  (princ)
)
(vl-load-com) (princ)

 (defun test__getfile()
 
  (getfiled "Select a Lisp File" "C:/Users/adziri/OneDrive - GEXPERTISE SYSTEMS/Bureau/Process_auto/Fonts" "ttf" 8)
 
 )
(defun alert_style_roman (/ wss)
    
        ;Chargement de la boite de dialogue
        (setq id (load_dialog "plugin_v01.dcl"))
        (new_dialog "Diag1" id)
        (action_tile "Search"  "(test__getfile)")
        ; actions en fonction des choix dans la boite de dialogue
        ;(action_tile "Roman" "(Roman_Styler)")
        (action_tile "cancel" "(done_dialog)")
        (action_tile "accept" "(Roman_Styler) (done_dialog)")
        (start_dialog)
        )
        (defun Roman_Styler ()
          (progn
          (setq url (get_tile "URL"))
          (setq H (get_tile "H"))
          (setq L (get_tile "L"))
          (setq A (get_tile "A"))
          (command "-STYLER" "INT_Roman" url H L A  "" "")
          )

)

 (defun alert_style_arial (/ wss)
    
        ;Chargement de la boite de dialogue
        (setq id (load_dialog "plugin_v01.dcl"))
        (new_dialog "Diag1" id)
        (action_tile "Search"  "(test__getfile)")
        ; actions en fonction des choix dans la boite de dialogue
       
        (action_tile "cancel" "(done_dialog)")
        (action_tile "accept" "(Arial_Styler) (done_dialog)")
        (start_dialog)
        )
        (defun Arial_Styler ()
          (progn
          (setq url (get_tile "URL"))
          (setq H (get_tile "H"))
          (setq L (get_tile "L"))
          (setq A (get_tile "A"))
          (command "-STYLER" "arial" url H L A  "" "")
          )

)


 (defun alert_style_Swiss_black (/ wss)
    
        ;Chargement de la boite de dialogue
        (setq id (load_dialog "plugin_v01.dcl"))
        (new_dialog "Diag1" id)
        (action_tile "Search"  "(test__getfile)")
        ; actions en fonction des choix dans la boite de dialogue
        ;(action_tile "Roman" "(Roman_Styler)")
        (action_tile "cancel" "(done_dialog)")
        (action_tile "accept" "(Swiss_black) (done_dialog)")
        (start_dialog)
        )
        (defun Swiss_black ()
          (progn
          (setq url (get_tile "URL"))
          (setq H (get_tile "H"))
          (setq L (get_tile "L"))
          (setq A (get_tile "A"))
          (command "-STYLER" "Swiss" url H L A  "" "")
          )

)



 

(defun CHANGESTYLEArial1 ()
   (command "-STYLER" "INT_Roman" "C:/Users/adziri/Desktop/PluginZwcad_v01/Fonts/arial.ttf" "2.500" "" "" "" "" ))
 


(defun CHANGESTYLESwiss1 ()
   (command "-STYLER" "INT_Roman" "C:/Users/adziri/Desktop/PluginZwcad_v01/Fonts/SwissBlack.ttf" "2.500" "" "" "" "" ))
  
 

 

(defun tremie()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_2-tremie") nil)(command "-layer" "n" "GEX_EDS_sdp_2-tremie" "CO" "U" "255,255,127" "GEX_EDS_sdp_2-tremie" ""))
)

(defun h-180()
	(if (=  (tblsearch "layer" "GEX_EDS_sdp_3-h-180") nil)(command "-layer" "n" "GEX_EDS_sdp_3-h-180" "CO" "U" "165,82,82" "GEX_EDS_sdp_3-h-180" ""))
)

(defun 5-pk()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_5-pk") nil)(command "-layer" "n" "GEX_EDS_sdp_5-pk" "CO" "U" "153,153,153" "GEX_EDS_sdp_5-PK" ""))
)

(defun 6-combles()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_6-combles") nil)(command "-layer" "n" "GEX_EDS_sdp_6-combles" "CO" "U" "82,0,165" "GEX_EDS_sdp_6-combles" ""))
)	
(defun 7-lt()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_7-lt") nil)(command "-layer" "n" "GEX_EDS_sdp_7-lt" "CO" "U" "0,127,255" "GEX_EDS_sdp_7-LT" ""))
)		

(defun 8-cave()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_8-cave") nil)(command "-layer" "n" "GEX_EDS_sdp_8-cave" "CO" "U" "255,191,127" "GEX_EDS_sdp_8-cave"  "")"")
)

(defun teinte-contours()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_teinte_contour") nil)(command "-layer" "n" "GEX_EDS_sdp_teinte_contour" "CO" "U" "255,127,127" "GEX_EDS_sdp_teinte_contour" ""))
)
		
(defun sdp_SDP_su()	
   (if (=  (tblsearch "layer" "GEX_EDS_sdp_SDP_su") nil)(command "-layer" "n" "GEX_EDS_sdp_SDP_su" "CO" "U" "255,0,0" "GEX_EDS_sdp_SDP_su"  "")"")
)		
  
(defun tremie-su()	  
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_2-tremie_su") nil)(command "-layer" "n" "GEX_EDS_sdp_2-tremie_su" "_color" "7" "GEX_EDS_sdp_2-tremie_su" "")))

(defun h-180_su()	
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_3-h-180_su") nil)(command "-layer" "n" "GEX_EDS_sdp_3-h-180_su" "_color" "7" "GEX_EDS_sdp_3-h-180_su"  "")))
  
(defun 5-pk_su()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_5-pk_su") nil)(command "-layer" "n" "GEX_EDS_sdp_5-pk_su" "_color" "7" "GEX_EDS_sdp_5-PK_su" "")))  

(defun 6-combles_su()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_6-combles_su") nil)(command "-layer" "n" "GEX_EDS_sdp_6-combles_su" "_color" "7" "GEX_EDS_sdp_6-combles_su"  "")))  

(defun 7-lt_su()
  (if (=  (tblsearch "layer" "GEX_EDS_sdp_7-lt_su") nil)(command "-layer" "n" "GEX_EDS_sdp_7-lt_su" "_color" "7" "GEX_EDS_sdp_7-LT_su" "")))  

(defun 8-cave_su()
(if (=  (tblsearch "layer" "GEX_EDS_sdp_8-cave_su") nil)(command "-layer" "n" "GEX_EDS_sdp_8-cave_su" "_color" "7" "GEX_EDS_sdp_8-cave_su" "")""))
		



(setq launchSdpCounter 1)
(defun c:sdp( )
	;(setq os (getvar "osmode"))
	;(setvar "osmode" 0)
	;(setvar "HPISLANDDETECTIONMODE" 0)
	
	
		(if (= (= launchSdpCounter 1) T)(
				
			
			(setq launchSdpCounter (+ launchSdpCounter 1))	
			; check de tous les calques utilisés dans le programme (TODO : Verifier la cohérence des noms de calques avec charte)
	
			;;; Planchers avant déductions 	

			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_teinte_contour" "l" "GEX_EDS_sdp_SDP_su" "")""
			
			(foreach element liste	
				(command "-calque" "ch" "0" "" "")
				(command "-calque" "l" element "")
				
				(setq sel (ssget "X" (list (cons -4 "<or")(cons -4 "<and") (cons 0 "LWPOLYLINE")(cons 8 element) 
											(cons -4 "and>")(cons -4 "<and") (cons 0 "CIRCLE")(cons 8 element)
											(cons -4 "and>") (cons -4 "or>"))))
				
				(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
				(command "_clayer" "GEX_EDS_sdp_teinte_contour")  
				(command "-hachures" "s" sel "" "")
				(command "_clayer" "GEX_EDS_sdp_SDP_su")
			)
			
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_teinte_contour" 1)
			
			;;; Vides ;;;  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_2-tremie" "l" "GEX_EDS_sdp_2-tremie_su" "")

			(setq sel-T (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_2-tremie") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
			(command "_clayer" "GEX_EDS_sdp_2-tremie")
			(command "-hachures" "s" sel-T "" "") 
			(command "_clayer" "GEX_EDS_sdp_2-tremie_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_2-tremie" 0)
			

			;;; Surfaces dont h < 1.80 m ;;;
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_3-h-180" "l" "GEX_EDS_sdp_3-h-180_su" "")

			(setq sel-C (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_3-h-180") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "") 
			(command "_clayer" "GEX_EDS_sdp_3-h-180") 
			(command "-hachures" "s" sel-C "" "")  
			(command "_clayer" "GEX_EDS_sdp_3-h-180_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_3-h-180" 0)


			;;; Stationnement ;;;	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_5-PK" "l" "GEX_EDS_sdp_5-PK_su" "")

			(setq sel-H (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_5-PK") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_5-PK") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
			(command "_clayer" "GEX_EDS_sdp_5-PK") 
			(command "-hachures" "s" sel-H "" "") 
			(command "_clayer" "GEX_EDS_sdp_5-PK_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_5-PK" 0)

			;;; Combles ;;;	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_6-combles" "l" "GEX_EDS_sdp_6-combles_su" "")

			(setq sel-L (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_6-combles") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
			(command "_clayer" "GEX_EDS_sdp_6-combles")
			(command "-hachures" "s" sel-L "" "") 
			(command "_clayer" "GEX_EDS_sdp_6-combles_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_6-combles" 0)


			;;; Locaux techniques ;;;	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_7-LT" "l" "GEX_EDS_sdp_7-LT_su" "")

			(setq sel-P (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_7-LT") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_7-LT") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
			(command "_clayer" "GEX_EDS_sdp_7-LT") 
			(command "-hachures" "s" sel-P "" "")
			(command "_clayer" "GEX_EDS_sdp_7-LT_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_7-LT" 0)


			;;; Caves ;;;	  
			(command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_8-cave" "l" "GEX_EDS_sdp_8-cave_su" "")

			(setq sel-S (ssget "X" '((-4 . "<or")(-4 . "<and") (0 . "LWPOLYLINE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>")
								(-4 . "<and") (0 . "CIRCLE")(8 . "GEX_EDS_sdp_8-cave") (-4 . "and>") (-4 . "or>"))))

			(command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" "")
			(command "_clayer" "GEX_EDS_sdp_8-cave")
			(command "-hachures" "s" sel-S "" "") 
			(command "_clayer" "GEX_EDS_sdp_8-cave_su")
			(getCalqueAppliqueApplatSDP "GEX_EDS_sdp_8-cave" 0)
		
			(command "-layer" "l" "*" "E" "0" "g" "GEX_EDS_sdp_teinte_contour" "")
			(alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
			(setvar "osmode" os)
			(princ "\n")
			(princ)
		)
	)

		(if (= (/= launchSdpCounter 1) T) ( boxMessagesdp ))


)
;==================================centre Inert =====================

(defun centreInersdp (s1)
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
;====================================init plan========================
(defun boxMessagesdp() 

     	(lspOkCancel "Commande lancer 2 fois " "appuyer sur cancel pour annuler" "Ou appuyer sur ok pour continuer" "warning !")
  		(if (= result T) (
		 	 (prompt "annuler les commandes precedente \n")
		 	 (command "annuler" "90" )
			 (alert "    *********  commande Annuler veuillez relancer vos calcul SDP  *********        ")
			 (setq launchSdpCounter 1)
		  )
		  )
        (if (= result nil) (prompt "annuler la commande actuelle \n"))
)

;;; fonction de recuperation du Calque et de calcul la surface à afficher
(defun getCalqueAppliqueApplatSDP(calqueC iscontour)
	;;; de l'ensemble des contours du calque passé en parametre 
	(princ calqueC)
	(princ "\n")
	
	(setq sel1 (ssget "X" (list (cons 0 "HATCH")(cons 8 calqueC))))
	(command "_draworder" "p" "" "_back")	
	(setq ind 0 surftotal 0 surfad 0 somme 0)

	(if (/= sel1 nil)						;si l'ensemble des elements du calque n'est pas vide 
		(while (setq nm (ssname sel1 ind))			;Recuperartion de chaque elemment de la liste issue de ssget (calque)
			(setq s1 (cdr (assoc -1 (entget nm))))	;recupere l'entité à partir de son nom 
			(setq entite (entget nm))
			(setq ind1 0 totx 0 toty 0)
			
			(setq entite (entget s1))
			(setq entite (member (assoc 72 entite) entite))
			
			(while (= (car(assoc 11 entite)) 11)	; recuperation du text designation et calcul de la position du texte à afficher
				(setq x (nth 1 (assoc 11 entite)))
				(setq y (nth 2 (assoc 11 entite)))
				(setq totx (+ totx x))
				(setq toty (+ toty y))
				(setq entite (member (assoc 72 entite) entite))
				(setq entite (member (assoc 11 entite) entite))
				(setq ind1 (1+ ind1)))							;fin du while 2

			(setq xmoyen (/ totx ind1))
			(setq ymoyen (/ toty ind1))
			(setq cxyz (list xmoyen ymoyen))
			(setq cxyz (trans cxyz 0 1))
			(command "_area" "_o" s1)			; calcul de l'aire de la polyligne 
			
			(setq surfpoly (getvar "area"))
			(setq surfpoly (rtos surfpoly 2 1))
			(setq surfpoly (strcat surfpoly " m\\U+00B2"))  ; valeur à afficher et mettre carré
				;; calcul du centre 
			(princ s1) (princ " entity name  \n")
			(command "-EDITHACH" s1 "c" "r" "o")				 
			(setq centroidPointsdp (centreInersdp s1))

			(if (= iscontour 1) (command "_TEXT" "S" "surf" "j" "MC" centroidPointsdp 0.5 100 surfpoly))
			(if (= iscontour 0) (command "_TEXT" "S" "surf" "j" "MC" centroidPointsdp 0.15 100 surfpoly))
		
			(setq ind (1+ ind)) )							   ;fin du while 1
    )                                                          ;fin de if
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

;===============================================
;;; search all layers with certain cracter
(defun getLayersdp (searchparamtext)
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


(vl-load-com)
;; Write CSV  -  Lee Mac
;; Writes a matrix list of cell values to a CSV file.
;; lst - [lst] list of lists, sublist is row of cell values
;; csv - [str] filename of CSV file to write
;; Returns T if successful, else nil
(defun WriteCSV ( lst csv / des sep )
    (if (setq des (open csv "w"))
        (progn
            (setq sep (cond ((vl-registry-read "HKEY_CURRENT_USER\\Control Panel\\International" "sList")) (",")))
            (foreach row lst (write-line (lst->csv row sep) des))
            (close des)
            t
        )
    )
)

;; List -> CSV 
;; Concatenates a row of cell values to be written to a CSV file.
;; lst - [lst] list containing row of CSV cell values
;; sep - [str] CSV separator token
(defun lst->csv ( lst sep )
    (if (cdr lst)
        (strcat (csv-addquotes (car lst) sep) sep (lst->csv (cdr lst) sep))
        (csv-addquotes (car lst) sep)
    )
)

(defun csv-addquotes ( str sep / pos )
    (cond
        (   (wcmatch str (strcat "*[`" sep "\"]*"))
            (setq pos 0)    
            (while (setq pos (vl-string-position 34 str pos))
                (setq str (vl-string-subst "\"\"" "\"" str pos)
                      pos (+ pos 2)
                )
            )
            (strcat "\"" str "\"")
        )
        (   str   )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Command ET, for Extract Text
(defun  EXPORT ( / ss i rows ent filepath)
 
  ;; Select the text objects
  (setq ss (ssget "X" '((0 . "TEXT") )))
 
    ;;;; Or maybe you also want MTEXT, then you uncomment this next line
    ;;;; notice: Mtext encodes "new line" as "\P", and may also contain code for style (like color, bold...)
    ;; (setq ss (ssget "X" '((0 . "TEXT,MTEXT") )))
    
  ;; the head (column titles) of the CSV.  You coule leave this blank, like this: (setq rows (list))
  (setq rows (list (list "LAYER" "X" "Y" "ROTATION" "TEXT" "SURFACE")))
 
  ;; read the data, put it in a list (in variable rows)
  (setq i 0)
  (repeat (sslength ss)
    
    (setq ent (entget (ssname ss i)))  ;; extract the properties
    
    ;; add the data to rows
    (setq rows (append rows (list (list
      (cdr (assoc 8 ent))                                   ;; Layer
      (rtos (nth 0 (cdr (assoc 10 ent))) 2 16)              ;; X value, notice: numbers must be converted to text, that's what the rtos does.  Feel free to change the precision (the 16)
      (rtos (nth 1 (cdr (assoc 10 ent))) 2 16)              ;; Y value
      (rtos (/ (* (cdr (assoc 50 ent)) 180) pi ) 2 16)      ;; rotation  - ("angle in rad" * 180 / pi) = angle in 360 degrees
      (cdr (assoc 1 ent))                                   ;; Text contents
    ))))
    
    (setq i (+ i 1))
  )

  
  (setq filepath (strcat (getvar "dwgprefix") (vl-filename-base (getvar "dwgname")) ".csv"))
  ;; save to csv
  (if
    (WriteCSV  rows filepath)
   ;; (WriteCSV total_val_text_sdp filepath)  ; input doit etre liste mais pas un seul valeur 

    (progn (princ "\nSaved as: ") (princ  filepath))
    (progn (princ "\nSomething went wrong"))
  )
 
  (princ)
 
)
;===================================================
; 				SDT  :  TABLEAU SDP
;===================================================
(defun sdt ()
  (récup_val)
)
;=============== FIN SDT =========================== 

;;; fonction qui recupere le texte des hachures et calcule les elements de la legende puis les affiche
(defun getDesignationEtAfficheValeursdp(calqueC texte)
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
			(command "-attedit" "N" "N" "SDP" texte "0" "0" (rtos total_val 2 0))
			(princ total_val)	
		)
		(princ total_val)
	)
)

;========================================= Fonction fait la récupération des valeurs ===========================================
(defun récup_val(/ total_val_text_SP total_val_text_V total_val_text_180 total_val_text_TA total_val_text_ST total_val_text_CO total_val_text_LT total_val_text_c )
  	;===================================== Planchers avant déductions =========================
	(setq total_val_text_SP (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_SDP_su" "SP"))

	;======================================== VIDES ===========================================
	(setq total_val_text_V (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_2-tremie_su" "V"))

	;======================================= H 180 ============================================
	(setq total_val_text_180 (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_3-h-180_su" "180"))

	;====================================== TOTAL TA ==========================================
	(setq total_val_text_TA (- (atof (rtos total_val_text_SP 2 0)) (atof (rtos total_val_text_V 2 0)) (atof (rtos total_val_text_180 2 0)) ))
	(setq total_val_text_TA (rtos total_val_text_TA 2 0))
	
	(command "-attedit" "N" "N" "SDP" "TA" "0" "0" total_val_text_TA)

	;====================================== STATIONEMENT ======================================	
	(setq total_val_text_ST (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_5-PK_su" "ST"))

	;======================================== COMBLES =========================================
	(setq total_val_text_CO (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_6-combles_su" "CO"))

	;==================================== LOCAUX TECHNIQUE ====================================
	(setq total_val_text_LT (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_7-LT_su" "LT"))

	;======================================= CAVE =============================================
	(setq total_val_text_c (getDesignationEtAfficheValeursdp "GEX_EDS_sdp_8-cave_su" "C"))
	(test_alert) ; choix des catégories de batiments
)

 (defun test_alert (/ wss)
  (setq wss (vlax-get-or-create-object "WScript.Shell"))
  ;(vlax-invoke wss 'popup "Foo" 2 "Les categories de Batiments" 0)
     (setq dcl_id (load_dialog "plugin_v01.dcl"))
      (if (not (new_dialog "diag_alert" dcl_id))
      (exit)
      )
      (action_tile "M" "(mixte)")
      (action_tile "L" "(locaux)")
      (action_tile "H" "(habitation)")
      (action_tile "cancel" "(done_dialog) (setq result nil)")
      (action_tile "accept" "(done_dialog) (setq result T)" )
      (start_dialog)
      (unload_dialog dcl_id)
      (princ)
      (vlax-release-object wss)
)



(defun mixte()
    ;(setq wss (vlax-get-or-create-object "WScript.Shell"))
    (setq dcl_id (load_dialog "plugin_v01.dcl"))
      (if (not (new_dialog "input_superficie" dcl_id))
          (exit)
      )
    
    (setq superficie (get_tile "superficie"))
    (action_tile "cancel" "(done_dialog) (setq result nil)")
    (action_tile "accept" "(done_dialog) (setq result superficie)" )
    (start_dialog)
    (unload_dialog dcl_id)
    
    (setq total_val_text_i (* (superficie) 0.10))
    (command "-attedit" "N" "N" "SDP" "ISOL" "0" "0" (rtos total_val_text_i 2 0))
    ;========================================= SDP ===========================================
    (setq total_val_text_sdp (- (atof total_val_text_TA) (atof (rtos total_val_text_ST 2 0)) (atof (rtos total_val_text_CO 2 0)) (atof (rtos total_val_text_LT 2 0))
    (atof (rtos total_val_text_c 2 0)) (atof (rtos total_val_text_i 2 0)) ))
    (setq total_val_text_sdp (atoi (rtos total_val_text_sdp 2 0)))
    (princ total_val_text_sdp)
    (command "-attedit" "N" "N" "SDP" "SDP" "0" "0" total_val_text_sdp)
    (alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
 
 ; (vlax-release-object wss)
)
(defun locaux()
    (setq total_val_text_i 0.0)
    (command "-attedit" "N" "N" "SDP" "ISOL" "0" "0" (rtos total_val_text_i 2 0))
	
    ;========================================= SDP ===========================================
    (setq total_val_text_sdp (- (atof total_val_text_TA) (atof (rtos total_val_text_ST 2 0)) (atof (rtos total_val_text_CO 2 0)) (atof (rtos total_val_text_LT 2 0))
    (atof (rtos total_val_text_c 2 0)) (atof (rtos total_val_text_i 2 0)) ))
    
    (setq total_val_text_sdp (atoi (rtos total_val_text_sdp 2 0)))
    (princ total_val_text_sdp)
    (princ "\n")
    
    (command "-attedit" "N" "N" "SDP" "SDP" "0" "0" total_val_text_sdp)
    (alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
    (setvar "osmode" os)
    (princ "\n")
    (princ)

)     

(defun habitation()
    (setq total_val_text_i (* (- (atof total_val_text_TA) total_val_text_LT total_val_text_c total_val_text_CO total_val_text_ST ) 0.10))
    (command "-attedit" "N" "N" "SDP" "ISOL" "0" "0" (rtos total_val_text_i 2 0))
	
    ;========================================= SDP ===========================================
    (setq total_val_text_sdp (- (atof total_val_text_TA) (atof (rtos total_val_text_ST 2 0)) (atof (rtos total_val_text_CO 2 0)) (atof (rtos total_val_text_LT 2 0))
    (atof (rtos total_val_text_c 2 0)) (atof (rtos total_val_text_i 2 0)) ))
    
    (setq total_val_text_sdp (atoi (rtos total_val_text_sdp 2 0)))
    (princ total_val_text_sdp)
    (princ "\n")
    
    (command "-attedit" "N" "N" "SDP" "SDP" "0" "0" total_val_text_sdp)
    (alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")
    (setvar "osmode" os)
    (princ "\n")
    (princ)

)
	
   


;===================================================
; MISE A ZERO DE TOUTES LES VALEURS DU TABLEAU SDP 
;===================================================
(defun sd0 ()
	; edition de la légende et remettre toutes les valeurs à 0
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


;======= FIN SD0 ===================================
(defun c:SDP_PluginZwcad_v01 ()
;define the function

  (setq dcl_id (load_dialog "plugin_v01.dcl"))
  ;load the DCL file

  (if (not (new_dialog "Justification" dcl_id))
  ;load the dialogue box

    (exit)
    ;if not loaded exit

  )
       
;=========================================================================
  ;; Get the current values from each toggle tile calques :
;=========================================================================    
    (setq 2-tremieVar (get_tile "2-tremie"))
    (setq 3-h-180Var (get_tile "3-h-180"))
    (setq 5-pkVar (get_tile "5-pk"))
    (setq 6-comblesVar (get_tile "6-combles"))
    (setq 7-ltVar (get_tile "7-lt"))
    (setq 8-caveVar (get_tile "8-cave"))
    (setq teinte_contourVar (get_tile "teinte_contour"))
  
    (setq sdp_SDP_suVar (get_tile "sdp_SDP_su"))
    (setq 2-tremie_suVar (get_tile "2-tremie_su"))
    (setq 3-h-180_suVar (get_tile "3-h-180_su"))
    (setq 5-pk_suVar (get_tile "5-pk_su"))
    (setq 6-combles_suVar (get_tile "6-combles_su"))
    (setq 7-lt_suVar (get_tile "7-lt_su"))
    (setq 8-cave_suVar (get_tile "8-cave_su"))
    
      
    (action_tile "2-tremie" "(setq 2-tremieVar $value) (tremie)")
    (action_tile "3-h-180" "(setq 3-h-180Var $value)(h-180)")
    (action_tile "5-pk" "(setq 5-pkVar $value)(5-pk)")
    (action_tile "6-combles" "(setq 6-comblesVar $value)(6-combles)")
    (action_tile "7-lt" "(setq 7-ltVar $value)(7-lt)")
    (action_tile "8-cave" "(setq 8-caveVar $value)(8-cave)")
    (action_tile "teinte_contour" "(setq teinte_contourVar $value)(teinte-contours)")
    
    (action_tile "sdp_SDP_su" "(setq sdp_SDP_suVar $value)(sdp_SDP_su)")
    (action_tile "2-tremie_su" "(setq 2-tremie_suVar $value) (tremie-su)")
    (action_tile "3-h-180_su" "(setq 3-h-180_suVar $value)(h-180_su)")
    (action_tile "5-pk_su" "(setq 5-pk_suVar $value)(5-pk_su)")
    (action_tile "6-combles_su" "(setq 6-combles_suVar $value)(6-combles_su)")
    (action_tile "7-lt_su" "(setq 7-lt_suVar $value)(7-lt_su)")
    (action_tile "8-cave_su" "(setq 8-cave_suVar $value)(8-cave_su)")
    
      
     ;; Lookup table converts "0/1″ strings to the correct integers:
    (if (= 2-tremieVar "1") (setq 2-tremieNum 64) (setq 2-tremieNum 0))
    (if (= 3-h-180Var "1") (setq 3-h-180Num 64) (setq 3-h-180Num 0))
    (if (= 5-pkVar "1") (setq 5-pkNum 64) (setq 5-pkNum 0))
    (if (= 7-ltVar "1") (setq 7-ltNum 64) (setq 7-ltNum 0))
    (if (= 8-caveVar "1") (setq 8-caveNum 64) (setq 8-caveNum 0))
    (if (= teinte_contourVar "1") (setq teinte_contourNum 64) (setq teinte_contourNum 0)) 
         
;; Add up the integers, and then change system variable
    (setq vars (+ 2-tremieNum 3-h-180Num 5-pkNum 7-ltNum 8-caveNum teinte_contourNum))
    (setvar "pdmode" vars)
 ;=========================================================================
  ;; Get the current values from each radio button Styles :
;=========================================================================    
    ;; See which radio button the user clicks:

    ;;(action_tile "SwissBlack" "(setq swissVar $value)(CHANGESTYLESimplex)")
  (action_tile "SwissBlack" "(alert_style_Swiss_black)")
    ;(action_tile "Arial" "(setq ArialVar $value)(CHANGESTYLEArial1)")
  (action_tile "Arial" "(alert_style_arial)")
    ;(action_tile "Roman" "(setq romanVar $value)(CHANGESTYLERoman1)")
  (action_tile "Roman" "(alert_style_roman)")

 
  
     ; Lookup table:

    (if (= swissVar "1") (setq vars 0))
    (if (= ArialVar "1") (setq vars 1))
    (if (= romanVar "1") (setq vars 2) )  
   ;=========================================================================
            ;; Get the current values from each radio button HASH :
   ;=========================================================================        
                ;; See which radio button the user clicks:

    (action_tile "SOLID" "(setq solidVar $value)(hsolid1)" )
    ;(action_tile "Motif1"  "(hsolid)")
    (action_tile "ANGLE" "(setq angleVar $value)(hangle1)" )
    ;(action_tile "Motif2"  "(hangle)")
    (action_tile "ANSI32" "(setq ansiVar $value)(hansi321)"  )
    ;action_tile "Motif3"  "(hAnsi32)") 

    ;type Hachures
    (action_tile "type1" "(setq type1 $value)(Predetermine)"  )
    (action_tile "type2" "(setq type2 $value)(definieparUser)"  ) 
    ;;(action_tile "insert" "(setq insert_url $value")
    ;(action_tile "insert1"   "(PostRequest)"
      ; (strcat   ;Récupérer insert lien 
      ; "(progn (setq URL (get_tile \"insert\") (setq userclick T))"
      ;  )
    ;)
  
  
    (action_tile "insert1"   "(MyRequest)")  
    (action_tile "cancel" "(done_dialog) (setq result nil)")
    (action_tile "accept" "(done_dialog) (setq result T)" )
 
    (action_tile "extract" "(CALL)")
    (action_tile "export" "(EXPORT)")
    (action_tile "SDP" "(sdp)" )
    (action_tile "SD0" "(sd0)" )
    (action_tile "SDT" "(sdt)")
  
    (action_tile "next"
                (vl-prin1-to-string
                   '(
                           ((lambda ( f ) (if f (openDWG f))) (getfiled "Selectionner le plan DWG" "M:/" "" 16))
                        
                    )
                )
            )
  (start_dialog)
  (unload_dialog dcl_id)
  (princ)

);defun