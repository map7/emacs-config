(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.3.1/elpa/auto-complete-20141103.105/dict")
(ac-config-default)

(setq ac-use-quick-help nil)
(setq ac-ignore-case nil)

(add-hook 'rhtml-mode-hook
          (lambda ()
            (yas/minor-mode-on)
            ))

(add-to-list 'ac-modes 'scala-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'haml-mode)
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'sass-mode)
(add-to-list 'ac-modes 'tpl-mode)
(add-to-list 'ac-modes 'rhtml-mode)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

