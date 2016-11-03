;;Initalise powerline mode line theme. Used with moe-theme
(require 'powerline)




;; Remove the 'git' component
;; http://www.lunaryorn.com/2014/07/26/make-your-emacs-mode-line-more-useful.html
  '(" " (:propertize
         ;; Strip the backend name from the VC status information
         (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
                  (substring vc-mode (+ (length backend) 2))))
  "Mode line format for VC Mode.")
(put 'lunaryorn-vc-mode-line 'risky-local-variable t)

;; Setup my mode line
(setq-default mode-line-format
  (list "%e" ; print error message about full memory.
        '(:eval (append
                 (list
                  (powerline-lcl             'left nil  )
                  (powerline-rmw             'left nil  )
                  (powerline-buffer-id       'left nil   powerline-color1                 )
                  (powerline-major-mode      'left       powerline-color1                 )
                  (powerline-minor-modes     'left       powerline-color1                 )
                  (powerline-narrow          'left       powerline-color1 powerline-color2)
                  (lunaryorn-vc-mode-line    'center     powerline-color2                 )

            (powerline-pull-right (list 
                  (powerline-row             'right     powerline-color1 powerline-color2)
                  (powerline-make-text       ":"        powerline-color1)
                  (powerline-column          'right     powerline-color1)
                  (powerline-percent         'right nil powerline-color1)
                  (powerline-display-time    'right nil )
                  (powerline-display-battery 'right nil)
                  (powerline-make-text       " "    nil)))
            )))))

