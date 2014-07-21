(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

;; Press Super-p for fuzzy find in project
(global-set-key (kbd "s-f") 'projectile-find-file)

;; Press Super-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

;; Setup projectile-rails
;; This is stuffing around with tramp mode.
(add-hook 'projectile-mode-hook 'projectile-rails-on)
