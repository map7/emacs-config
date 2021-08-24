(use-package js2-mode :ensure t :defer 5)
(use-package jsx-mode :ensure t :defer 5)
(use-package indium
  :ensure t
  :defer 5
  :init
  ;; Add indium interaction in all JS buffers  
  (add-hook 'js-mode-hook #'indium-interaction-mode)
  
  )
