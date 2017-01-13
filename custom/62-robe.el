(use-package robe
  :init
  (add-hook 'enh-ruby-mode-hook (lambda() (robe-mode)))
  :defer 5)

