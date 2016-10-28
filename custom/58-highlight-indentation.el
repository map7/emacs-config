(require 'highlight-indentation)
 (add-hook 'enh-ruby-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))

 (add-hook 'coffee-mode-hook
           (lambda () (highlight-indentation-current-column-mode)))
