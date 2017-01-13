(use-package slime
  :init
  (slime-setup)
  :defer 2
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (global-font-lock-mode t))
