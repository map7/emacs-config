(use-package grizzl :defer)
(use-package projectile-rails
  :defer 2
  :init
  (add-hook 'text-mode-hook 'projectile-mode)
  (add-hook 'prog-mode-hook 'projectile-mode)
  ;; Setup projectile-rails
  ;; This is stuffing around with tramp mode.
  (add-hook 'projectile-mode-hook 'projectile-rails-on)
  
  :config
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'grizzl)

  ;; Press Super-p for fuzzy find in project
  (global-set-key (kbd "s-f") 'projectile-find-file)

  ;; Press Super-b for fuzzy switch buffer
  (global-set-key (kbd "s-b") 'projectile-switch-to-buffer))

;; FIX hange issue with tramp. Tested this 16/02/2017 and it's fixed.
;; https://github.com/bbatsov/prelude/issues/594
(projectile-global-mode 1)
