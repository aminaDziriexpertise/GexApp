;;;===============================================================================
;;; Walk Blocks by Some Buddy for the CAD community.
;;; This program is freeware. Use it, change it, improve it, hack it as you wish :)
;;;===============================================================================
(defun change_style (
                      /
                      acadapp
                      activedoc
                      process_styles
                      strtokens
                      write_dcl_code_to
                      tempfile
                      dclfile
                      dcl_id
                      sset
                      used_text_styles_list
                      styles
                      exist_text_styles_list
                      action_tile_used_styles
                      target_style
                      sel_styles_list
                      action_tile_existing_styles
                      action_tile_change
                      action_tile_cancel
                      what_next 
                      replace_style
                      old_cmdecho
                    )
  (vl-load-com)

  (setq acadapp (vlax-get-acad-object))
  (setq activedoc (vla-get-activedocument acadapp))

  (defun process_styles (
                          sset
                          flag
                          stylename
                          /
                          do_styles
                          style_name
                          idx
                          entity
                          enttype
                          dxfdata
                          object
                          text_styles_list
                        )

    (defun do_styles (obj flag stylename)
      (if flag
        (if (member (vla-get-stylename obj) sel_styles_list)
          (vla-put-stylename obj stylename)
        )
        (if
          (not
            (member
              (setq style_name (vla-get-stylename obj))
              text_styles_list
            )
          )
          (setq text_styles_list
            (cons style_name text_styles_list)
          )
        )
      )
    )

    (setq idx 0)
    (repeat (sslength sset)
      (setq entity (ssname sset idx))
      (setq enttype (cdr (assoc 0 (setq dxfdata (entget entity)))))
      (cond
        ( (= enttype "INSERT")
          (setq object (vlax-ename->vla-object entity))
          (if (= (vla-get-hasattributes object) :vlax-true)
            (foreach attribute
              (append
                (vlax-invoke object 'GetAttributes)
                (vlax-invoke object 'GetConstantAttributes)
              )
              (do_styles attribute flag stylename)
            )
          )
        )
        ( (= enttype "RTEXT")
          (if flag
            (if (member (cdr (assoc 7 dxfdata)) sel_styles_list)
              (progn
                (setq dxfdata
                  (subst
                    (cons 7 stylename)
                    (assoc 7 dxfdata)
                    dxfdata
                  )
                )
                (entmod dxfdata)
              )
            )
            (if
              (not
                (member
                  (setq style_name (cdr (assoc 7 dxfdata)))
                  text_styles_list
                )
              )
              (setq text_styles_list
                (cons style_name text_styles_list)
              )
            )
          )
        )
        (T
          (setq object (vlax-ename->vla-object entity))
          (do_styles object flag stylename)
        )
      )
       (setq idx (1+ idx))
    )
    (if (not flag)(acad_strlsort text_styles_list))
  )

  (defun strtokens (str sep / pos)
    (if (setq pos (vl-string-search sep str))
      (cons
        (substr str 1 pos)
        (strtokens
          (substr str (+ (strlen sep) pos 1))
          sep
        )
      )
      (list str)
    )
  )
  
  (defun write_dcl_code_to (file)
    (write-line 
      (strcat
        "listbox:dialog{"
           "label=\"Change Style\";"
        
        
           ": row {"
              ": column {"
                 "width = 26;"
                 "fixed_width=true;"
                 ": text {"
                    "label=\"Insert Odoo URL \";"
                 "}"
                "}"
            "}"
        
           ": row {"
              ": column {"
                 "width = 26;"
                 "fixed_width=true;"
                 ": text {"
                    "label=\"Used Styles\";"
                 "}"
                 ": list_box {"
                    "key=\"used_styles\";"
                    "multiple_select=true;"
                 "}"
              "}"
              ": column {"
                 "width = 26;"
                 "fixed_width=true;"
                 ": text {"
                    "label=\"Existing Styles\";"
                 "}"
                 ": list_box {"
                    "key=\"existing_styles\";"
                 "}"
              "}"
           "}"
           ": row {"
              "alignment = centered;"
              "fixed_width=true;"
              ": button{"
                 "label=\"Change\";"
                 "key=\"change\";"
                 "fixed_width=true;"
                 "is_enabled=false;"
                 "is_default=true;"
                 "width=14;"
              "}"
              ": button{"
                 "label=\"Cancel\";"
                 "key=\"cancel\";"
                 "fixed_width=true;"
                 "is_cancel=true;"
                 "width=14;"
              "}"
           "}"
        "}"
      )
      file
    )
  )

  ;(setq tempfile (vl-filename-mktemp "tempfile.dcl"))
  ;(setq dclfile (open tempfile "w"))
  ;(write_dcl_code_to dclfile)
  ; (close dclfile)
  (setq dcl_id (load_dialog "msgbox.dcl"))		;load dialog
  (if (not (new_dialog "plugin"  dcl_id)			;test for dialog
      );not
    (exit)						;exit if no dialog
  );if
 
  
  
 ; (setq dcl_id (load_dialog tempfile))
 ; (if (not (new_dialog "listbox" dcl_id "" position))
  ;  (progn
   ;   (alert "Dialog definition not found.")
    ;  (vl-file-delete tempfile)
    ;  (exit)
    ;)
 ; )
  
  

  
  

  (if
    (setq sset
      (ssget "x"
       '((-4 . "<OR")
          (0 . "*TEXT")
          (0 . "INSERT")
        (-4 . "OR>"))
      )
    )
    (setq used_text_styles_list (process_styles sset nil nil))
  )

  (vlax-for style (setq styles (vla-get-textstyles activedoc))
    (setq exist_text_styles_list
      (cons
        (vla-get-name style)
        exist_text_styles_list
      )
    )
  )
  
  (setq exist_text_styles_list (reverse exist_text_styles_list))
 
  (start_list "used_styles")
  (mapcar 'add_list used_text_styles_list)
  (end_list)

  (start_list "existing_styles")
  (mapcar 'add_list exist_text_styles_list)
  (end_list)
 
  (defun action_tile_used_styles (value)
    (setq target_style (nth (atoi value) used_text_styles_list))
    (if (/= (get_tile "existing_styles") "")
      (mode_tile "change" 0)
    )
    (foreach pos (strtokens value " ")
      (setq sel_styles_list
        (cons
          (nth (atoi pos) used_text_styles_list)
          sel_styles_list
        )
      )
    )
  )

  (defun action_tile_existing_styles (value)
    (setq replace_style (nth (atoi value) exist_text_styles_list))
    (if (/= (get_tile "used_styles") "")
      (mode_tile "change" 0)
    )
  )

  (defun action_tile_change ()
    (if (/= target_style replace_style)
      (setq position (done_dialog 1))
      (alert "The selected styles are identical.")
    )
  )

  (defun action_tile_cancel ()(setq position (done_dialog 0)))

  (action_tile "used_styles" "(action_tile_used_styles $value)")
  (action_tile "existing_styles" "(action_tile_existing_styles $value)")

  (action_tile "change" "(action_tile_change)")
  (action_tile "cancel1" "(action_tile_cancel)")
 
  (setq what_next (start_dialog))
 
  (vl-file-delete tempfile)
        
  (unload_dialog dcl_id)

  (if (= what_next 1)
    (progn
      (vla-startundomark activedoc)
      (process_styles sset T replace_style)
      (setq old_cmdecho (getvar 'cmdecho))
      (setvar 'cmdecho 0)
      (command "_.purge" "_st" "*" "_n")
      (setvar 'cmdecho old_cmdecho)
      (vla-endundomark activedoc)
    )
  )

  (princ)
)
;;;===============================================================================
(defun c:plugin ()(change_style)(princ))
;;;===============================================================================      
(prompt "\n *** Automatisation Process . Type PLUGIN to run the utility *** ")(princ)
;;;===============================================================================