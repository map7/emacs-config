;;Initalise powerline mode line theme. Used with moe-theme
(require 'powerline)




;; Remove the 'git' component
;; http://www.lunaryorn.com/2014/07/26/make-your-emacs-mode-line-more-useful.html
  '(" " (:propertize
         ;; Strip the backend name from the VC status information
         (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
                  (substring vc-mode (+ (length backend) 2))))
  "Mode line format for VC Mode.")
(put 'lunaryorn-vc-mode-line 'risky-local-variable t)
