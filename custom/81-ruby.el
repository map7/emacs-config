;; Resolve a mise-managed binary, preferring the currently-active version.
;; Resolution happens on demand so a stale Emacs daemon doesn't keep pointing
;; at a ruby version that mise has since removed.
(defun my/mise-bin (name)
  "Return absolute path to NAME from the currently-active mise ruby, or nil."
  (let* ((dir (string-trim
               (shell-command-to-string "mise where ruby 2>/dev/null")))
         (bin (and (not (string-empty-p dir))
                   (expand-file-name (concat "bin/" name) dir))))
    (when (and bin (file-executable-p bin)) bin)))

(defun my/ruby-refresh-paths ()
  "Refresh exec-path / PATH / `enh-ruby-program' from current mise ruby.
Run interactively after switching mise ruby versions."
  (interactive)
  (let* ((ruby (my/mise-bin "ruby"))
         (bindir (and ruby (file-name-directory ruby))))
    (when bindir
      ;; Drop any stale mise ruby bin dirs, prepend the live one.
      (setq exec-path
            (cons bindir
                  (cl-remove-if
                   (lambda (p)
                     (string-match-p "/mise/installs/ruby/" (or p "")))
                   exec-path)))
      (setenv "PATH"
              (concat bindir ":"
                      (mapconcat #'identity
                                 (cl-remove-if
                                  (lambda (p)
                                    (string-match-p "/mise/installs/ruby/" p))
                                  (split-string (or (getenv "PATH") "") ":" t))
                                 ":")))
      (setq enh-ruby-program ruby))))

(require 'cl-lib)
(my/ruby-refresh-paths)
;; Re-resolve on each enh-ruby-mode activation so a long-lived daemon
;; survives `mise use ruby@<new>` without restarting.
(add-hook 'enh-ruby-mode-hook #'my/ruby-refresh-paths)

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
  (ruby-mode . (lambda () (when buffer-file-name (rubocopfmt-mode))))
  (enh-ruby-mode . (lambda () (when buffer-file-name (rubocopfmt-mode))))
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
  (let ((rubocop-bin (my/mise-bin "rubocop")))
    (when rubocop-bin
      (setq rubocop-check-command (concat rubocop-bin " --format emacs"))
      (setq rubocop-autocorrect-command (concat rubocop-bin " -a --format emacs"))
      (setq rubocop-format-command (concat rubocop-bin " -x --format emacs")))))

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
(require 'cl-lib)
(require 'eglot)
(let ((solargraph (my/mise-bin "solargraph")))
  (when solargraph
    ;; Remove the built-in entry that uses bare "solargraph" (not on PATH)
    (setq eglot-server-programs
          (cl-remove-if (lambda (entry)
                          (and (listp (car entry))
                               (member 'ruby-mode (car entry))))
                        eglot-server-programs))
    ;; Use a function so the path is re-resolved each time eglot starts,
    ;; surviving mise version changes in a long-lived daemon.
    (add-to-list 'eglot-server-programs
                 `((enh-ruby-mode ruby-mode ruby-ts-mode)
                   . ,(lambda (&optional _interactive)
                        (list (or (my/mise-bin "solargraph") "solargraph")
                              "stdio"))))
    (add-hook 'enh-ruby-mode-hook #'eglot-ensure)
    (add-hook 'ruby-mode-hook #'eglot-ensure)
    (add-hook 'ruby-ts-mode-hook #'eglot-ensure)))

