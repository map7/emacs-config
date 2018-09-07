;; Modeline --- Creates custom modeline
;;; Commentary:
;;; Code:

(setq-default mode-line-format
      (list
       ""
       ;; == Buffer coding system ==
       '(:eval mode-line-mule-info)

       ;; Buffer modified?
       ;; Simple
       ;; 'mode-line-modified
       
       ;; == Buffer modified or Saved? ==
       ;; If modified, Icon = floppy, else (saved) Icon = check
       '(:eval (if (buffer-modified-p (current-buffer))
                   (concat " " (propertize (format "%s " (all-the-icons-faicon "floppy-o"))
                                           'face `(:foreground "red" :height 1.0 :family ,(all-the-icons-faicon-family))
                                           'display '(raise -0.1) 'help-echo "Buffer has been modified"))
                   (concat " " (propertize (format "%s " (all-the-icons-faicon "check"))
                                           'face `(:foreground "green" :height 1.0 :family ,(all-the-icons-faicon-family))
                                           'display '(raise -0.1) 'help-echo "Buffer has been modified"))))
       "  "
       ;; == Buffer name ==
       ;; gray & bold as set by font mode-line-buffer-id
       '(:eval (propertize "%b" 'face `(:weight bold)
                           'help-echo (buffer-file-name)))

       ;; == Buffer read-only? ==
       '(:eval (when buffer-read-only
                 (concat " "  (propertize (format "  %s" (all-the-icons-faicon "eye"))
                                          'face `(:height 1.0 :family ,(all-the-icons-faicon-family))
                                          'display '(raise -0.1) 'help-echo "Buffer os read only"))))
       "  "

       ;; == Current Major Mode ==
       '(:eval (propertize "%m" 'face 'font-lock-string-face
                           'help-echo buffer-file-coding-system))

       "  "

       ;; == Line numbers ==
       ;; grey & normal as set by font mode-line
       ;; '%03' to set to 3 chars at least; prevents flickering
       "L:"
      
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
       ;; 
       '(:eval (when vc-mode
         (cond ((string-match "Git[:-]" vc-mode)
                (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
                  (concat
                   " "
                   (propertize (format "%s" (all-the-icons-octicon "git-branch"))
                               'face `(:height 1.0 :family ,(all-the-icons-octicon-family))
                               'display '(raise -0.1))
                   (propertize (format " %s" branch) 'face `(:height 1.0)))))
               (t (format "%s" vc-mode)))))


       ;; == ERC ==
       ;; change header line face if disconnected
       (defface erc-header-line-disconnected
         '((t (:foreground "black" :background "indianred")))
         "Face to use when ERC has been disconnected.")
       
       ;; ERC
	     'mode-line-misc-info
       
       ;; == Window ==
       ;; '(:eval (window-parameter (selected-window) 'ace-window-path))

       ;; == Org-timer-set-timer ==
       '(:eval (propertize "  %M  " 'face 'font-lock-type-face))

       " "
       ;; == Date & Time ==
       ;; Simple date (day-month), time (24hr)
       ;; '(:eval (propertize (format-time-string "%d-%b %H:%M")))

       ;; Date, clock icon with correct hour hand, time in 24hr format
       '(:eval (let* ((hour (string-to-number (format-time-string "%I")))
                      (icon (all-the-icons-wicon (format "time-%s" hour) :height 1.3 :v-adjust 0.0)))
                 (concat
                  (propertize (format-time-string " %d-%b "))
                  (propertize (format "%s" icon)
                              'face `(:height 1.0 :family ,(all-the-icons-wicon-family))
                              'display '(raise -0.0))
                  (propertize (format-time-string " %H:%M ")
                              'face `(:height 1.0)))))
       
       ))
;;; 101-modeline ends here
