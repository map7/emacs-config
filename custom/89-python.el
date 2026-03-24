;; Add mise python and ruff to exec-path
(dolist (tool '("python" "ruff"))
  (let ((dir (string-trim
              (shell-command-to-string (format "mise where %s 2>/dev/null" tool)))))
    (when (and (not (string-empty-p dir))
               (file-directory-p (expand-file-name "bin" dir)))
      (setq dir (expand-file-name "bin" dir))
      (add-to-list 'exec-path dir)
      (setenv "PATH" (concat dir ":" (getenv "PATH"))))))

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . flycheck-mode)
         (python-ts-mode . flycheck-mode))
  :config
  (setq python-indent-offset 4))

;; Ruff linter and formatter for Python
(use-package flycheck
  :config
  (flycheck-define-checker python-ruff
    "A Python linter using ruff."
    :command ("ruff" "check" "--output-format=concise" source)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": " (id (one-or-more alnum)) " " (message) line-end))
    :modes (python-mode python-ts-mode))
  (add-to-list 'flycheck-checkers 'python-ruff))

;; Format with ruff on save
(defun my/ruff-format-on-save ()
  "Run ruff format on the current buffer on save."
  (when (executable-find "ruff")
    (add-hook 'before-save-hook
              (lambda ()
                (when (derived-mode-p 'python-mode 'python-ts-mode)
                  (let ((point (point)))
                    (shell-command-on-region (point-min) (point-max) "ruff format -" nil t)
                    (goto-char point))))
              nil t)))

(add-hook 'python-mode-hook #'my/ruff-format-on-save)
(add-hook 'python-ts-mode-hook #'my/ruff-format-on-save)

(provide '89-python)
;;; 89-python.el ends here