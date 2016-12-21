(defvar mode-line-cleaner-alist
  `((abbrev-mode . "")
    (auto-complete-mode . " α")
    (auto-revert-mode . " aR")
    (company-mode . " C")
    (enh-ruby-mode . " eR")
    (eldoc-mode . "")
    (emacs-lisp-mode . " EL")
    (guide-key-mode . "")
    (hi-lock-mode . "")
    (highlight-parentheses-mode . " ()")
    (hl-line-mode . "")
    (isearch-mode . " iS")
    (js-mode . " js")
    (flycheck-mode . "")
    (lisp-interaction-mode . " λ")
    (paredit-mode . " π")
    (projectile-mode . "")
    (python-mode . " py")
    (projectile-rails-mode . " pR")
    (real-auto-save-mode . " aS")
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

