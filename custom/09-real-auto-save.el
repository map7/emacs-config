;; Automatically save the file
;; 
(use-package real-auto-save
  :init
  (add-hook 'org-mode-hook 'real-auto-save-mode)
  :defer 5
  :config
  (setq real-auto-save-interval 5))

