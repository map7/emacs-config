;; Setup company stats to sort most commonly used ones at the top.
(require 'company-statistics)
(company-statistics-mode)

;; company ansible
(add-to-list 'company-backend 'company-ansible)
