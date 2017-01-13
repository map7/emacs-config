;; jinja2 - used in ansible templates
(use-package jinja2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.j2\\'" . jinja2-mode))  
  :defer 5)

