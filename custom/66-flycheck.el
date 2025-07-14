(use-package flycheck
  :init
  (global-flycheck-mode)
  :ensure t
  :config
  (setq flycheck-ruby-rubocop-executable "rubocop")
  (setq flycheck-rubocoprc "~/.rubocop.yml")
  (setq flycheck-checker-error-threshold 1000)
  (setq-default mode-line-format
              (append mode-line-format
                      '((:eval (flycheck-mode-line-status-text)))))
  :defer)

;;;; Takes too long to do the check.
;; (defun flycheck-org-lint-start (checker callback)
;;   (funcall
;;    callback 'finished
;;    (save-excursion
;;      (mapcar
;;       (lambda (err)
;;         (goto-char (car err))
;;         (flycheck-error-new-at
;;          (org-current-line) (1+ (current-column))
;;          'warning (cadr err) :checker checker))
;;       (org-lint '(link-to-local-file))
;;       ))))

;; ;; Using org-lint check the health of our org file on save
;; (flycheck-define-generic-checker 'org-lint
;;   "Syntax checker for org-lint."
;;   :start 'flycheck-org-lint-start
;;   :modes '(org-mode))

;; (add-to-list 'flycheck-checkers 'org-lint)
