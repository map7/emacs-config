(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (typescript-mode . eldoc-mode)
         (typescript-mode . company-mode)
         (typescript-mode . flycheck-mode))
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq company-tooltip-align-annotations t)
  (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

  ;; Add node to the path
  (setenv "PATH" (concat (getenv "PATH") ":~/n/bin"))
  (setq exec-path (append exec-path '("~/n/bin"))))
