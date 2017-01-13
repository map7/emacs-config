;; Setup company stats to sort most commonly used ones at the top.

(use-package company-statistics
  :init
  (company-statistics-mode)
  (add-to-list 'company-backend 'company-ansible) ;; company ansible
  (add-hook 'enh-ruby-mode-hook (lambda () (company-mode))) ;; Load for ruby
  (add-hook 'after-init-hook 'global-company-mode) ;; Use in all buffers
  :defer 5
  )

