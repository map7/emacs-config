;; Automatically save the file
;; 
(require 'real-auto-save)
(add-hook 'org-mode-hook 'turn-on-real-auto-save)
(setq real-auto-save-interval 5)        ; in seconds
