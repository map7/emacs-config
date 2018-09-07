;; Modeline --- Creates custom modeline
;;; Commentary:
;;; Code:

(setq-default mode-line-format
      (list "%e"

       'modeline-front-space
       
       ;; == Buffer coding system ==
       'mode-line-mule-info

       ;; == Buffer modified? ==
       'mode-line-modified

       "  "
       ;; == Buffer name ==
       ;; gray & bold as set by font mode-line-buffer-id
       '(:eval (propertize " %b " 'face `(:weight bold)
                           'help-echo (buffer-file-name)))

       ;; == Current Major Mode ==
       '(:eval (propertize " %m " 'face 'font-lock-string-face
                           'help-echo buffer-file-coding-system))


       ;; == Line numbers ==
       ;; grey & normal as set by font mode-line
       ;; '%03' to set to 3 chars at least; prevents flickering
       " L:"
      
       '(:eval (propertize "%03l" 'face `(:height 1.0)))

       "/"

       ;; Print total number of lines in the buffer
       ;; (Can be slow for buffers with large number of lines eg. org files)
       '(:eval (format "%s"(line-number-at-pos (point-max))))

       ;; Faster option could be to use total-lines.el
       ; the below will look like e.g. "263/947,10  26%"
       ;; '(:eval ((12 "%l" "/" (:eval (format "%d,%d" total-lines (1+ (current-column)))))
       ;;          (-3 "%p"))))

       ;; == Column numbers ==
       "  C:"

       '(:eval (propertize "%03c" 'face `(:height 1.0)))
       
       "  "
       
       ;; ;; == Buffer scroll (%) position ==
       ;; (propertize "%06p" 'face 'font-lock-constant-face) ;; % above top

       ;; " "

       ;; == Insert or Overwrite mode ==
       ;; , input-method in a tooltip
       ;; '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
       ;;                     'face 'font-lock-preprocessor-face
       ;;                     'help-echo (concat "Buffer is in "
       ;;                                        (if overwrite-mode "overwrite" "insert") " mode")))
       ;; " "
       
       ;; == Git branch status ==
       ;; Simple
       '(vc-mode vc-mode)
	     "  "

       ;; ERC
	     'mode-line-misc-info
       
       ;; == Window ==
       ;; '(:eval (window-parameter (selected-window) 'ace-window-path))

       ;; == Org-timer-set-timer ==
       '(:eval (propertize "  %M  " 'face 'font-lock-type-face))

       " "
       ;; == Date (day-month) & Time (24hr)==
       '(:eval (propertize (format-time-string "%d-%b  %H:%M")))
       ))
;;; 101-modeline ends here
