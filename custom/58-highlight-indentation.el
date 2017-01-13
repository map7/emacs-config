(use-package highlight-indentation
  :init
  (add-hook 'enh-ruby-mode-hook (lambda () (highlight-indentation-current-column-mode)))
  (add-hook 'coffee-mode-hook (lambda () (highlight-indentation-current-column-mode)))
  :defer)
