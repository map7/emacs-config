(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("tsconfig.*\\.json\\'" . json-mode)
         ("\\.babelrc\\'" . json-mode)))

(use-package dotenv-mode
  :ensure t
  :mode "\\.env\\'")

(use-package emmet-mode
  :ensure t
  :hook ((web-mode . emmet-mode)
         (html-mode . emmet-mode)
         (css-mode . emmet-mode))
  :config
  (setq emmet-self-closing-tag-style " /"))  ;; use <br /> style

(use-package npm-mode
  :ensure t
  :hook ((typescript-mode . npm-mode)
         (js2-mode . npm-mode)
         (web-mode . npm-mode)))
