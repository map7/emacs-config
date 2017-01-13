(use-package coffee-mode
  :init
  (add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))
  :defer 5
  :config
  (defun coffee-custom ()
    "coffee-mode-hook"
    (set (make-local-variable 'tab-width) 2)
    (set (make-local-variable 'coffee-tab-width) 2))
  )
