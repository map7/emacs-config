;; Setup my mode line

(setq-default mode-line-format
              '("%e" ; print error message about full memory.
                mode-line-front-space   ; space
                                        ; mode-line-mule-info
                                        ; mode-line-client
                mode-line-modified      ; modified
                mode-line-remote
                "  "
                                        ; mode-line-frame-identification
                mode-line-buffer-identification ; filename
                                        ;"  "
                (list 'line-number-mode "(%l,") ; line number
                (list 'column-number-mode "%c) ") ; column number
                " "
                
                ;; (vc-mode basic-vc-mode-line)

                ;; "  "
                ;;mode-line-modes"  "                    ; mode-line-misc-info
                
                " "
                (display-time-string t)                ; Display the time.
                ;; mode-line-end-spaces
                ))

(require 'spaceline-config)                  ; Themes inc powerline & modeline config 
(spaceline-spacemacs-theme)

;; Turn buffer size off
(spaceline-toggle-buffer-size-off)

;; Remove the load
(setq display-time-default-load-average nil) 

;; Remove the mail
(setq display-time-mail-string "")           

;; Display the time.
(display-time-mode t)               

;; Battery format
(display-battery-mode 1)
(setq battery-mode-line-format "%b%p%%%") ; Default: "[%b%p%%]"

;; Turn ruby version off in modeline
;;(global-rbenv-mode -1)

;; Turn off buffer position 'All'
(spaceline-toggle-buffer-position-off)

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
