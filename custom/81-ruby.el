;; Add mise ruby to exec-path
(let ((dir (string-trim
            (shell-command-to-string "mise where ruby 2>/dev/null"))))
  (when (and (not (string-empty-p dir))
             (file-directory-p (expand-file-name "bin" dir)))
    (setq dir (expand-file-name "bin" dir))
    (add-to-list 'exec-path dir)
    (setenv "PATH" (concat dir ":" (getenv "PATH")))))

;; Point enh-ruby-mode to mise ruby for fontification and indentation
(let ((ruby-bin (let ((dir (string-trim (shell-command-to-string "mise where ruby 2>/dev/null"))))
                  (when (not (string-empty-p dir))
                    (let ((bin (expand-file-name "bin/ruby" dir)))
                      (when (file-exists-p bin) bin))))))
  (when ruby-bin
    (setq enh-ruby-program ruby-bin)))

(use-package ruby-end
  :init
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
  (ruby-mode . rubocopfmt-mode)
  :config
  (setq rubocopfmt-rubocop-command "rubocop"))

(use-package inf-ruby
  :ensure t
  :hook ((enh-ruby-mode . inf-ruby-minor-mode)
         (ruby-mode . inf-ruby-minor-mode)
         (compilation-filter . inf-ruby-auto-enter)))

(use-package rubocop
  :ensure t
  :hook ((enh-ruby-mode . rubocop-mode)
         (ruby-mode . rubocop-mode))
  :config
  (setq rubocop-prefer-system-executable t)
  (let ((rubocop-bin (string-trim
                      (shell-command-to-string "mise where ruby 2>/dev/null"))))
    (when (not (string-empty-p rubocop-bin))
      (setq rubocop-bin (expand-file-name "bin/rubocop" rubocop-bin))
      (when (file-exists-p rubocop-bin)
        (setq rubocop-check-command (concat rubocop-bin " --format emacs"))
        (setq rubocop-autocorrect-command (concat rubocop-bin " -a --format emacs"))
        (setq rubocop-format-command (concat rubocop-bin " -x --format emacs"))))))

(use-package rake
  :ensure t
  :config
  (setq rake-completion-system 'ivy))

(use-package rails-routes
  :ensure t)

(use-package ruby-tools
  :ensure t
  :hook ((enh-ruby-mode . ruby-tools-mode)
         (ruby-mode . ruby-tools-mode)))

(use-package ruby-hash-syntax
  :ensure t)

(use-package ruby-interpolation
  :ensure t
  :hook ((enh-ruby-mode . ruby-interpolation-mode)
         (ruby-mode . ruby-interpolation-mode)))

(use-package company-inf-ruby
  :ensure t
  :config
  (add-to-list 'company-backends 'company-inf-ruby))

;; Solargraph LSP for Ruby (go-to-definition, completion, docs, diagnostics)
(require 'eglot)
(let ((solargraph (let ((dir (string-trim (shell-command-to-string "mise where ruby 2>/dev/null"))))
                    (when (not (string-empty-p dir))
                      (let ((bin (expand-file-name "bin/solargraph" dir)))
                        (when (file-exists-p bin) bin))))))
  (when solargraph
    (add-to-list 'eglot-server-programs
                 `((enh-ruby-mode ruby-mode ruby-ts-mode) . (,solargraph "stdio")))
    (add-hook 'enh-ruby-mode-hook #'eglot-ensure)
    (add-hook 'ruby-mode-hook #'eglot-ensure)
    (add-hook 'ruby-ts-mode-hook #'eglot-ensure)))

