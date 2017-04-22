;; Move by holding down super and using the arrow keys
(use-package windmove
  :init
  (windmove-default-keybindings 'super)
  ;; wrap around at edges
  (setq windmove-wrap-around 't)
  :defer 5)
