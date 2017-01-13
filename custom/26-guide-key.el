(use-package guide-key
  :init
  (guide-key-mode 1) ; Enable guide-key-mode
  :defer 5
  :config
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 8"))
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom))
