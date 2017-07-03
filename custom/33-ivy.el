(use-package ivy
  :init
  (ido-mode 0)
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  :defer 5)

(use-package counsel
  :defer 5
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("s-f" . counsel-git)
         ("s-g" . counsel-git-grep)
         ("s-&" . counsel-shell-command)
         ("C-s-l" . counsel-locate)
         )
  :config

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
