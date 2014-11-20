;; Setup my mode line

(setq-default mode-line-format
              '("%e" ; print error message about full memory.
                mode-line-front-space
                ; mode-line-mule-info
                ; mode-line-client
                mode-line-modified
                mode-line-remote
                ; mode-line-frame-identification
                mode-line-buffer-identification
                ;"  "
                mode-line-position
                (vc-mode basic-vc-mode-line)

                "  "
                mode-line-modes
                "  "
                ; mode-line-misc-info
                display-time-string
                "  "
                battery-mode-line-string
                mode-line-end-spaces))

;; Time format
(display-time-mode 1)
(setq display-time-format "%t%R")

;; Battery format
(display-battery-mode 1)
(setq battery-mode-line-format "%p%%") ; Default: "[%b%p%%]"

;; Remove the listing of minor modes
(diminish 'yas-minor-mode)
(diminish 'abbrev-mode)
(diminish 'rinari-minor-mode)
(diminish 'smartparens-mode)
(diminish 'guide-key-mode)
(diminish 'auto-complete-mode)

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
