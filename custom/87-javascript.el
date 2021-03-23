;; Javascript files.
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq js-indent-level 2)                ; Set tabs for js files


;; --------------------------------------------------------------------------------
;; The following creates error;
;; Warning (js2-mode): For JSX support, use js-mode with js2-minor-mode
;; --------------------------------------------------------------------------------
;; ;; JSX mode
;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
;; (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
