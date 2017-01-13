(use-package multi-term
  :init
  ;; Fix UTF8 characters in terminals
  (add-hook 'term-exec-hook
            (function
             (lambda ()
               (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))
  :bind (("C-x <up>" . multi-term-next)
         ("C-x <down>" . multi-term-prev))
  :defer 5
  :config
  (setq multi-term-program "/bin/zsh")
  (defun last-term-buffer (l)
    "Return most recently used term buffer."
    (when l
      (if (eq 'term-mode (with-current-buffer (car l) major-mode))
          (car l) (last-term-buffer (cdr l)))))

  (defun get-term ()
    "Switch to the term buffer last used, or create a new one if
    none exists, or if the current buffer is already a term."
    (interactive)
    (let ((b (last-term-buffer (buffer-list))))
      (if (or (not b) (eq 'term-mode major-mode))
          (multi-term)
        (switch-to-buffer b))))
  )
