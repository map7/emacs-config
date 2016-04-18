;; Add paths (not required if EXWM is installed from GNU ELPA)
(add-to-list 'load-path "~/.emacs.d/elpa/xelb-0.6/")
(add-to-list 'load-path "~/.emacs.d/elpa/exwm-0.4/")
(add-to-list 'load-path "~/.emacs.d/elpa/cl-generic-0.2/")

;; Load EXWM
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
