(use-package yafolding
  :init
  (add-hook 'prog-mode-hook
            (lambda () (yafolding-mode)))
  :defer 2)

