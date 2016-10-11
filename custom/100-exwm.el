;; Add paths (not required if EXWM is installed from GNU ELPA)
;; (add-to-list 'load-path "/home/map7/.emacs.d/elpa/xelb-0.6/")
;;(add-to-list 'load-path "/home/map7/.emacs.d/elpa/exwm-0.4/")
;; (add-to-list 'load-path "~/.emacs.d/external/xelb/")
;; (add-to-list 'load-path "~/.emacs.d/external/exwm/")
(add-to-list 'load-path "~/.emacs.d/elpa/cl-generic-0.2/")

;; Start server - helps with opening files
(server-start)

;; RandR (multi-screen support)
(require 'exwm-randr)
(if (file-exists-p "~/.emacs.randr.el")
    (load "~/.emacs.randr.el")
  )

;; Load EXWM
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

;; Allow sending special keys by hitting C-q
;; This can be used for using standard C-c & C-v sequences on programs like Inkscape
(push ?\C-q exwm-input-prefix-keys)
(define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; + 'slock' is a simple X display locker provided by suckless tools. 'i3lock'
;;   is a more feature-rich alternative.
(exwm-input-set-key (kbd "s-l")
                    (lambda () (interactive) (start-process "" nil "slock")))

;; Redshift off
(exwm-input-set-key (kbd "s-x")
                    (lambda () (interactive) (start-process "" nil "redshift" "-x" )))

;; Redshift on
(exwm-input-set-key (kbd "s-z")
                    (lambda () (interactive) (start-process "" nil "redshift" "-O" "3500")))

;; Turn on capslock
(exwm-input-set-key (kbd "s-c")
                    (lambda () (interactive) (start-process "" nil "setxkbmap" "-layout" "us" "-option" "ctrl:nocaps")))

;; Suspend nicely
(exwm-input-set-key (kbd "s-<f12>")
                    (lambda () (interactive) (start-process "" nil "gksudo" "pm-suspend")))

;; Enable workspace
(setq exwm-workspace-number 10)

;; System tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)
