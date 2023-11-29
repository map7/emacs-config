;; Tab settings

;; ;; 2023-TODO: use these for 4gl mode
;; (define-key global-map (kbd "C-j") 'electric-newline-and-maybe-indent)
;; (define-key global-map (kbd "C-m") 'electric-newline-and-maybe-indent)

;; 2023-TODO: use these for everything else
(define-key global-map (kbd "C-j") 'newline-and-indent)
(define-key global-map (kbd "C-m") 'newline-and-indent)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
