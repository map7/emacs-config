(use-package smex
  :init
  (smeix-nitialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands))  
  :defer 5)
