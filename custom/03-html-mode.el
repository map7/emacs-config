(setq auto-mode-alist 
      (cons '("\\.jst" . html-mode) auto-mode-alist))

(setq auto-mode-alist
      (cons '("\\.json" . js2-mode) auto-mode-alist))

;; Set the correct indent of 2 spaces for everything
(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

(setq web-mode-enable-current-column-highlight t)
