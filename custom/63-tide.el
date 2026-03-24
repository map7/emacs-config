(use-package exec-path-from-shell
  :ensure t
  :init
  (setq exec-path-from-shell-shell-name "zsh")
  (setq exec-path-from-shell-arguments '("-l")) ;; login shell
  (exec-path-from-shell-initialize))

;; Add mise node to exec-path dynamically
(let ((mise-node-bin (string-trim
                      (shell-command-to-string "mise where node 2>/dev/null"))))
  (when (and (not (string-empty-p mise-node-bin))
             (file-directory-p (expand-file-name "bin" mise-node-bin)))
    (setq mise-node-bin (expand-file-name "bin" mise-node-bin))
    (add-to-list 'exec-path mise-node-bin)
    (setenv "PATH" (concat mise-node-bin ":" (getenv "PATH")))))

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

;; Enable flycheck with eslint for TypeScript
(use-package flycheck
  :hook ((typescript-ts-mode . flycheck-mode)
         (tsx-ts-mode        . flycheck-mode)
         (typescript-mode    . flycheck-mode))
  :config
  ;; Use project-local eslint from node_modules
  (defun my/use-local-eslint ()
    "Use project-local eslint if available."
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory) "node_modules"))
           (eslint (and root (expand-file-name "node_modules/.bin/eslint" root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))

  (add-hook 'flycheck-mode-hook #'my/use-local-eslint)

  ;; Disable jshint and jscs in favour of eslint
  (setq-default flycheck-disabled-checkers
                (append (default-value 'flycheck-disabled-checkers)
                        '(javascript-jshint javascript-jscs))))

(provide '63-tide)
;;; 63-tide.el ends here
