(use-package ruby-end
  :init
  ;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
  (add-to-list 'auto-mode-alist
               '("\\(?:\\.rb\\|ru\\|rabl\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  (add-hook 'enh-ruby-mode-hook (lambda () (ruby-end-mode)))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  :defer
  :config
  (require 'cl-lib)
  (add-hook 'enh-ruby-mode-hook #'whitespace-cleanup)
  (setq ruby-bounce-deep-indent t)
  (setq ruby-hanging-brace-indent-level 2))

;; Hide system ruby version from modeline
(setq rbenv-show-active-ruby-in-modeline nil)


(use-package rubocopfmt
  :hook
  (ruby-mode . rubocopfmt-mode))

(use-package inf-ruby
  :ensure t
  :hook ((enh-ruby-mode . inf-ruby-minor-mode)
         (ruby-mode . inf-ruby-minor-mode)
         (compilation-filter . inf-ruby-auto-enter)))

(use-package rubocop
  :ensure t
  :hook ((enh-ruby-mode . rubocop-mode)
         (ruby-mode . rubocop-mode)))

(use-package rake
  :ensure t
  :config
  (setq rake-completion-system 'ivy))

(use-package rails-routes
  :ensure t)
