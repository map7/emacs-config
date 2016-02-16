;; Line Number
(global-nlinum-mode)
;; Preset width nlinum
(add-hook 'nlinum-mode-hook
          (lambda ()
            (unless (boundp 'nlinum--width)
              (setq nlinum--width
                    (length (number-to-string
                             (count-lines (point-min) (point-max))))))))
