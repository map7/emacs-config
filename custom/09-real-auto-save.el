;; Automatically save the file
;; 
(use-package real-auto-save
  :init
  (add-hook 'org-mode-hook 'real-auto-save-mode)
  :config
  (setq real-auto-save-interval 5))

