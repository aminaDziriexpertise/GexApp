(defun C:samp8 ()					;define function	
 
  (setq lngth 50.0)					;preset slot length
 
  (setq hole "site")					;preset hole type
 
  (setq siz "M20")					;preset hole size
 
  (setq NAMES '("M6" "M8" "M10" "M12"
                "M16" "M20" "M24" "M30")		;define list
  );setq
 
  (setq dcl_id (load_dialog "msgbox.DCL"))		;load dialog
 
  (if (not (new_dialog "samp8" dcl_id)			;test for dialog
 
      );not
 
    (exit)						;exit if no dialog
 
  );if
 
  (setq w (dimx_tile "im")				;get image tile width
        h (dimy_tile "im")				;get image tile height
 
);setq
 
  (start_image "im")					;start the image
  (fill_image 0 0 w h 5)				;fill it with blue
  (end_image)						;end image
 
  (start_list "selections")				;start the list box
  (mapcar 'add_list NAMES)				;fill the list box
  (end_list)						;end list
 
  (set_tile "eb1" "50")					;put dat into edit box
  (mode_tile "eb1" 1)					;disable edit box
  (mode_tile "myslider" 1)				;disable slider
 
  (setq orth (itoa (getvar "orthomode")))		;get orthomode value
  (set_tile "tog1" orth)				;switch toggle on or off
 
  (setq sna (itoa (getvar "snapmode")))			;get snap value
  (set_tile "tog2" sna)					;switch toggle on or off
 
  (action_tile "myslider"				;if user moves slider
	 "(slider_action $value $reason)")		;pass arguments to slider_action
 
  (action_tile "eb1" 					;is user enters slot length
	 "(ebox_action $value $reason)")		;pass arguments to ebox_action
 
  (defun slider_action (val why)			;define function
      (if (or (= why 2) (= why 1))			;check values
      (set_tile "eb1" val)))				;update edit box
 
  (defun ebox_action (val why)				;define function
      (if (or (= why 2) (= why 1))			;check values
      (set_tile "myslider" val)))			;update slider
 
  (action_tile "tog1" "(setq orth $value)")		;get ortho toggle value
  (action_tile "tog2" "(setq sna $value)")		;get snap toggle value
 
  (action_tile "rb1" "(setq hole \"site\")")		;store hole type
  (action_tile "rb2" "(setq hole \"shop\")")		;store hole type
  (action_tile "rb3" "(setq hole \"hid\")")		;store hole type
  (action_tile "rb4" "(setq hole \"ctsk\")")		;store hole type
  (action_tile "rb5" "(setq hole \"elev\")")		;store hole type
  (action_tile "rb6" "(setq hole \"slot\")		;store hole type
                      (mode_tile \"eb1\" 0)		;enable edit box
                      (mode_tile \"myslider\" 0)	;enable slider
                      (mode_tile \"eb1\" 2)")		;switch focus to edit box
 
    (action_tile
    "cancel"						;if cancel button pressed
    "(done_dialog) (setq userclick nil)"		;close dialog, set flag
    );action_tile
 
  (action_tile
    "accept"						;if O.K. pressed
    (strcat						;string 'em together
      "(progn 
       (setq SIZ (atof (get_tile \"selections\")))"	;get list selection
      "(setq lngth (atof (get_tile \"eb1\")))"		;get slot length
      "(setq notes (get_tile \"eb2\"))"			;get notes
      "(setvar \"orthomode\" (atoi orth))"		;ortho on/off
      "(setvar \"snapmode\" (atoi sna))"		;snap on/off
      " (done_dialog)(setq userclick T))"		;close dialog, set flag
    );strcat

  );action tile
 
  (start_dialog)					;start dialog
 
  (unload_dialog dcl_id)				;unload
 
   (if userclick					;check O.K. was selected
    (progn
 
      (setq SIZ (fix SIZ))				;convert to integer
      (setq SIZ (nth SIZ NAMES))			;get the size
 
    );progn
 
  );if userclick
 
(princ)
 
);defun C:samp
 
(princ)