(setq inferior-lisp-program "/usr/bin/sbcl")
;; Setup Common Lisp
(require 'slime)
(slime-setup)
;; Use highlight colors
(global-font-lock-mode t)
