(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  :bind (("C-s" . swiper))  
  :defer 5)

(use-package counsel
  :defer 5)

(use-package swiper
  :defer 5)

