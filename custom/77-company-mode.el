(use-package company-statistics)

;; Setup company stats to sort most commonly used ones at the top.
(require 'company-statistics)
(company-statistics-mode)

;; company ansible
(add-to-list 'company-backend 'company-ansible)

;; Load for ruby
(add-hook 'enh-ruby-mode-hook (lambda () (company-mode)))

;; Use in all buffers
(add-hook 'after-init-hook 'global-company-mode)

