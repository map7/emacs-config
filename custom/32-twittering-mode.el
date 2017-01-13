;; Twitter mode
(use-package twittering-mode
  :init
  (add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))
  :config
  (setq twittering-icon-mode t)  
  (setq twittering-timer-interval 40) 
  (setq twittering-url-show-status nil) 
  (setq twittering-use-master-password t) ;; Don't prompt for authorisation.
  :defer 5)
