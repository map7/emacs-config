(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  ;; Prevent undo tree files from polluting your git repo
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  ;; Fix file-name-directory nil error on save in some buffers
  (setq undo-tree-auto-save-history nil)
  :defer 5)

