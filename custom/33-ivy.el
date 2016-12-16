(use-package ivy)
(use-package counsel)
(use-package swiper)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
