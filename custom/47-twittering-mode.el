;; Twitter mode
(require 'twittering-mode)
(setq twittering-icon-mode t)  
(setq twittering-timer-interval 40) 
(setq twittering-url-show-status nil) 
(add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))
(setq twittering-use-master-password t) ;; Don't prompt for authorisation. 
