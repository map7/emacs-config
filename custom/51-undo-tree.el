(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  ;; Prevent undo tree files from polluting your git repo
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :defer 5)

