(use-package ivy
  :init
  (ido-mode 0)
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t))

(use-package counsel
  :defer 5
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("s-f" . counsel-git)
         ("s-g" . my/counsel-grep)
         ("s-&" . counsel-shell-command)
         ("C-s-l" . counsel-locate)
         )
  :config

  (defun my/counsel-grep ()
    "Run `counsel-git-grep' if in a git repo, otherwise `counsel-grep'."
    (interactive)
    (if (locate-dominating-file default-directory ".git")
        (counsel-git-grep)
      (counsel-grep)))

  ;; Display a history when running commands
  (defun counsel-shell-command ()
    "Forward to `shell-command'."
    (interactive)
    (ivy-read "➣ "
              shell-command-history
              :action (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command))
              :caller 'counsel-shell-command))
  )

(use-package swiper
  :defer 5
  :bind (("C-s" . swiper)))


(use-package all-the-icons-ivy
  :init
  (all-the-icons-ivy-setup)
  )
