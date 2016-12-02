(use-package linum-off)

;; Use the standard line number
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")

;; Turn off for some modes
(require 'linum-off)

;; Better line number but haven't work out how to turn this off in certain modes.
;; Would have to edit the linum-off I suppose.
;; ;; Line Number
;; (global-nlinum-mode)
;; ;; Preset width nlinum
;; (add-hook 'nlinum-mode-hook
;;           (lambda ()
;;             (unless (boundp 'nlinum--width)
;;               (setq nlinum--width
;;                     (length (number-to-string
;;                              (count-lines (point-min) (point-max))))))))
