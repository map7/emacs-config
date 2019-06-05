;; Move by holding down super and using the arrow keys
(use-package windmove
  :init
  (windmove-default-keybindings 'super)
  ;; wrap around at edges
  (setq windmove-wrap-around 't)
  :bind (("s-<right>" . 'windmove-right)
         ("s-<left>" . 'windmove-left)
         ("s-<up>" . 'windmove-up)
         ("s-<down>" . 'windmove-down))
  :defer 5)
