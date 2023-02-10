(use-package magit
  :defer 2
  :config
  ;; C-c C-a to amend without any prompt
  (defun magit-just-amend ()
    (interactive)
    (save-window-excursion
      (magit-with-refresh
       (shell-command "git --no-pager commit --amend --reuse-message=HEAD"))))

  (eval-after-load "magit"
    '(define-key magit-status-mode-map (kbd "C-c C-a") 'magit-just-amend))
  )

;; (use-package magithub
;;   :after magit
;;   :config
;;   (magithub-feature-autoinject t)
;;   (setq magithub-clone-default-directory "~/code"))
