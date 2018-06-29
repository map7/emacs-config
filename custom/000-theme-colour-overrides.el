(setq
 alect-overriding-faces
 '((alect-prompt           ((t :foreground blue :weight bold)))
   (font-lock-string-face  ((t :foreground orange)))
   (font-lock-doc-face     ((t :inherit font-lock-string-face)))
   (font-lock-comment-face ((t :foreground "chocolate1")))
   (mode-line-buffer-id    ((t :foreground "yellow" :weight bold)))
   (mode-line              ((((background light))
                             :background "#22252c" :height 0.9 :foreground "#666666"
                             :box (:line-width 6 :color "#22252c"))
                            (((background dark))
                             :background "#1c2129" :height 0.9 :foreground "#ffffff"
                             :box (:line-width 6 :color "#1c2129"))))))
