;; Disable yasnippets in shell so we can regain our tab autocomplete
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))
