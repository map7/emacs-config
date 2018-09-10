(use-package tide
  :init
  ;; (add-hook 'before-save-hook 'tide-format-before-save)  ;; formats the buffer before saving
  ;; (add-hook 'js2-mode-hook #'setup-tide-mode)  ;; JS Setup
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  :defer 5
  :config
  ;; TIDE setup
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    ;; company is an optional dependency. You have to
    ;; install it separately via package-install
    (company-mode +1))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; Set tide-tsserver
  (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

  ;; Add node to the path
  (setenv "PATH" (concat (getenv "PATH") ":~/n/bin"))
  (setq exec-path (append exec-path '("~/n/bin")))

  ;; format options
  (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
  ;; see https://github.com/Microsoft/TypeScript/blob/cc58e2d7eb144f0b2ff89e6a6685fb4deaa24fde/src/server/protocol.d.ts#L421-473 for the full list available options
  )

(use-package web-mode
  :init
  ;; TSX setup
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  
  ;; JSX Setup
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "jsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  :defer 5)
