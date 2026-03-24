(setq auto-mode-alist
      (cons '("\\.jst" . html-mode) auto-mode-alist))

;; .json handled by json-mode (see 91-web-tools.el)

(setq web-mode-enable-current-column-highlight t)