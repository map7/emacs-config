(require 'yasnippet)

;; Snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        "~/.emacs.d/yasnippet-snippets"
        ))

;; Load rails snippets
(add-hook 'rails-minor-mode-hook '(lambda ()
			    (yas-minor-mode)
			    ))

(yas-global-mode 1)
