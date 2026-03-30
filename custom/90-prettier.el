;; Add project-local node_modules/.bin to exec-path
;; so local eslint, prettier, tsserver etc. are found automatically
(use-package add-node-modules-path
  :ensure t
  :hook ((typescript-mode . add-node-modules-path)
         (web-mode . add-node-modules-path)
         (js2-mode . add-node-modules-path)))

;; Format JS/TS/JSX/TSX files with Prettier on save
(use-package prettier-js
  :ensure t
  :hook ((typescript-mode . prettier-js-mode)
         (js2-mode . prettier-js-mode)
         (web-mode . (lambda ()
                       (when (and buffer-file-name
                                  (member (file-name-extension buffer-file-name)
                                          '("tsx" "jsx" "js" "ts")))
                         (prettier-js-mode))))))
