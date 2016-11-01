;; Setup my mode line

(setq-default mode-line-format
              '("%e" ; print error message about full memory.
                ;;mode-line-front-space   ; space
                                        ; mode-line-mule-info
                                        ; mode-line-client
                ;;mode-line-modified      ; modified
                ;;mode-line-remote
               ;; "  "
                                        ; mode-line-frame-identification
                mode-line-buffer-identification ; filename
                                        ;"  "
                (list 'line-number-mode "(%l,") ; line number
                (list 'column-number-mode "%c) ") ; column number
                ;;" "
                ))
;;Initalise powerline mode line theme. Used with moe-theme
(require 'powerline)

;; Turn buffer size off
(setq size-indication-mode "")

;; Remove the load
(setq display-time-default-load-average nil) 

;; Remove the mail
(setq display-time-mail-string "")           

;; Display the time.
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; Battery format
(display-battery-mode 1)
(setq battery-mode-line-format "%b%p%%%") ; Default: "[%b%p%%]"

;;Disable annoying bell & replace with visible mode-line bell only
(setq visible-bell 1)

;; Remove the 'git' component
;; http://www.lunaryorn.com/2014/07/26/make-your-emacs-mode-line-more-useful.html
(defvar basic-vc-mode-line
  '(" " (:propertize
         ;; Strip the backend name from the VC status information
         (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
                  (substring vc-mode (+ (length backend) 2))))
         ))
  "Mode line format for VC Mode.")
(put 'lunaryorn-vc-mode-line 'risky-local-variable t)
