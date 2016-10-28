(defvar mode-line-cleaner-alist
  `((abbrev-mode . "")
    (auto-complete-mode . " α")
    (auto-revert-mode . " R")
    (eldoc-mode . "")
    (emacs-lisp-mode . " EL")
    (guide-key-mode . "")
    (hi-lock-mode . "")
    (highlight-parentheses-mode . " ()")
    (hl-line-mode . "")
    (isearch-mode . " iS")
    (js-mode . " js")
    (flyspell-mode . " F")
    (lisp-interaction-mode . " λ")
    (paredit-mode . " π")
    (projectile-mode . "")
    (python-mode . " py")
    (projectile-rails-mode . " P")
    (real-auto-save-mode . " S")
    (rinari-minor-mode . " &")
    (robe-mode . " r")
    (rspec-mode . " Rs")
    (ruby-end-mode . "")
    (ruby-mode . " rb")
    (ruby-refactor-mode . "")
    (undo-tree-mode . "")
    (visual-line-mode . " V")
    (yas-minor-mode . " Υ"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original."
)


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;;; alias the new `flymake-report-status-slim' to
;;; `flymake-report-status'
(defalias 'flymake-report-status 'flymake-report-status-slim)
(defun flymake-report-status-slim (e-w &optional status)
  "Show \"slim\" flymake status in mode line."
  (when e-w
    (setq flymake-mode-line-e-w e-w))
  (when status
    (setq flymake-mode-line-status status))
  (let* ((mode-line " Φ"))
    (when (> (length flymake-mode-line-e-w) 0)
      (setq mode-line (concat mode-line ":" flymake-mode-line-e-w)))
    (setq mode-line (concat mode-line flymake-mode-line-status))
    (setq flymake-mode-line mode-line)
    (force-mode-line-update)))
