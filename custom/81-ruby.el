(use-package ruby-end
  :init
  ;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
  (add-to-list 'auto-mode-alist
               '("\\(?:\\.rb\\|ru\\|rabl\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  (add-hook 'enh-ruby-mode-hook (lambda () (ruby-end-mode)))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  :defer
  :config
  (require 'cl) ; If you don't have it already
  (add-hook 'enh-ruby-mode-hook #'whitespace-cleanup)
  (setq ruby-bounce-deep-indent t)
  (setq ruby-hanging-brace-indent-level 2))

;; Hide system ruby version from modeline
(setq rbenv-show-active-ruby-in-modeline nil)


(use-package rubocopfmt
  :hook
  (ruby-mode . rubocopfmt-mode))
