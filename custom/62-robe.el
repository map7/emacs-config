(use-package robe
  :init
  (add-hook 'enh-ruby-mode-hook (lambda() (robe-mode)))
  :defer 5)

;; M-. jump to definition without TAGS (uses rg/ag/grep)
(use-package dumb-jump
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

