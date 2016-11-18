;;Initalise powerline mode line theme. Used with moe-theme
(require 'powerline)

;; Time & Date
(display-time-mode)
(defpowerline display-time display-time-string)
(setq display-time-format "%H:%M") 

;; Display battery
(display-battery-mode)
(defpowerline display-battery display-battery-string)
(setq battery-mode-line-format "%L %b%p%%") ; "[%L %b%p%% %t]"


;; Remove the 'git' component
;; http://www.lunaryorn.com/2014/07/26/make-your-emacs-mode-line-more-useful.html
(defvar lunaryorn-vc-mode-line
  '(" " (:propertize
         ;; Strip the backend name from the VC status information
         (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
                  (substring vc-mode (+ (length backend) 2))))
         face font-lock-variable-name-face))
  "Mode line format for VC Mode.")
(put 'lunaryorn-vc-mode-line 'risky-local-variable t)

;; Setup my mode line
(setq-default mode-line-format
  (list "%e" ; print error message about full memory.
        '(:eval (append
                 (list
                  (powerline-lcl             'left nil  )
                  (powerline-rmw             'left nil  )
                  (powerline-buffer-id       'left nil   powerline-color1                 )
                  (powerline-major-mode      'left       powerline-color1                 )
                  (powerline-minor-modes     'left       powerline-color1                 )
                  (powerline-narrow          'left       powerline-color1 powerline-color2)
                  (lunaryorn-vc-mode-line    'center     powerline-color2                 )

            (powerline-pull-right (list 
                  (powerline-row             'right     powerline-color1 powerline-color2)
                  (powerline-make-text       ":"        powerline-color1)
                  (powerline-column          'right     powerline-color1)
                  (powerline-percent         'right nil powerline-color1)
                  (powerline-display-time    'right nil )
                  (powerline-display-battery 'right nil)
                  (powerline-make-text       " "    nil)))
            )))))

;; Remove & Hide from Mode-line
;; Hide ruby version from mode line
;; You cannot use this as it will break rbenv from working.
;(global-rbenv-mode -1)

;; Remove the load
(setq display-time-default-load-average nil)

;; Remove the mail
(setq display-time-mail-string "")
(setq display-time-use-mail-icon nil)

;; Turn buffer size off
(setq size-indication-mode "")

;;Disable annoying bell & replace with visible mode-line bell only
(setq visible-bell 1)

(force-mode-line-update)
  ;; Apparently force-mode-line-update is not always enough to
  ;; redisplay the mode-line
;;(redraw-display)

