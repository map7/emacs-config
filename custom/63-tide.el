(use-package exec-path-from-shell
  :ensure t
  :init
  (setq exec-path-from-shell-shell-name "zsh")
  (setq exec-path-from-shell-arguments '("-l")) ;; login shell
  (exec-path-from-shell-initialize))

;; Tree-sitter TypeScript modes (Emacs 29+ commonly)
(use-package typescript-ts-mode
  :mode (("\\.ts\\'"  . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))

;; If you don't have tree-sitter modes enabled, keep typescript-mode too:
(use-package typescript-mode
  :mode (("\\.ts\\'"  . typescript-mode)
         ("\\.tsx\\'" . typescript-mode)))

(use-package eglot
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode        . eglot-ensure)
         (typescript-mode    . eglot-ensure))
  :config
  ;; Prefer project-local language server if present
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode tsx-ts-mode typescript-mode)
                 . ("typescript-language-server" "--stdio"))))

(use-package prettier-js
  :hook ((typescript-ts-mode . prettier-js-mode)
         (tsx-ts-mode        . prettier-js-mode)
         (typescript-mode    . prettier-js-mode)))

