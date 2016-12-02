(use-package ruby-end)

;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rabl\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 
(setq ruby-bounce-deep-indent t)
(setq ruby-hanging-brace-indent-level 2)
 
(require 'cl) ; If you don't have it already

;; Add ruby-end
(require 'ruby-end)
(add-hook 'enh-ruby-mode-hook (lambda () (ruby-end-mode)))


