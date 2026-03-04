(use-package edraw
  :straight (el-easydraw :type git :host github :repo "misohena/el-easydraw")
  :defer t)

;; Enable edraw inline editing in org-mode
(with-eval-after-load 'org
  (require 'edraw-org)
  (edraw-org-setup-default))
