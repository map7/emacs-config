;; Move by holding down super and using the arrow keys
(use-package windmove
  ;; :defer 4
  :ensure t
  :config
  (windmove-default-keybindings 'super)
  ;; wrap around at edges
  (setq windmove-wrap-around t))
