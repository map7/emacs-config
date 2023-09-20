;; Tab settings
(define-key global-map (kbd "C-j") 'electric-newline-and-maybe-indent)
(define-key global-map (kbd "C-m") 'electric-newline-and-maybe-indent)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
