;; Add mise rust to exec-path
(let ((dir (string-trim
            (shell-command-to-string "mise where rust 2>/dev/null"))))
  (when (and (not (string-empty-p dir))
             (file-directory-p (expand-file-name "bin" dir)))
    (setq dir (expand-file-name "bin" dir))
    (add-to-list 'exec-path dir)
    (setenv "PATH" (concat dir ":" (getenv "PATH")))))

;; Use rust-ts-mode (tree-sitter) for .rs files, remap rust-mode to it
(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t))

(setq major-mode-remap-alist
      (append '((rust-mode . rust-ts-mode)) major-mode-remap-alist))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))

(add-hook 'rust-ts-mode-hook #'flycheck-mode)
(add-hook 'rust-ts-mode-hook #'eglot-ensure)

;; Clippy as flycheck checker
(with-eval-after-load 'flycheck
  (flycheck-define-checker rust-clippy
    "A Rust linter using clippy."
    :command ("cargo" "clippy" "--message-format=short" "--quiet")
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ": error" (optional "[" (id (one-or-more (not "]"))) "]") ": " (message) line-end)
     (warning line-start (file-name) ":" line ":" column ": warning" (optional "[" (id (one-or-more (not "]"))) "]") ": " (message) line-end))
    :modes (rust-mode rust-ts-mode))
  (add-to-list 'flycheck-checkers 'rust-clippy)
  (add-to-list 'flycheck-disabled-checkers 'rust-cargo))

(provide '64-rust)
;;; 64-rust.el ends here