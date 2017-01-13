(use-package dired-details
  :init
  (dired-details-install)  
  :defer 5
  :config
  (setq-default dired-details-hidden-string "--- "))
