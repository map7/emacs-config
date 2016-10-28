;; coffee-mode
(require 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (set (make-local-variable 'coffee-tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; ;; flymake-coffee
;; ;; Removed 26/09/2016 as it stopped search and replace accross multiple coffeescript files from working.
;; (require 'flymake-coffee)
;; (add-hook 'coffee-mode-hook 'flymake-coffee-load)
;; (setq flymake-coffee-coffeelint-configuration-file (expand-file-name "~/.emacs.d/coffeelint.json"))
