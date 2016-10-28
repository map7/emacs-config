;; Automatically save the file
;; 
(require 'real-auto-save)
(add-hook 'org-mode-hook 'real-auto-save-mode)
(setq real-auto-save-interval 5)        ; in seconds
