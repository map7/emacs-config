(use-package exwm)

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
                    (lambda () (interactive)
                      (start-process "" nil "slock")
                      (start-process "" nil "sudo" "pm-suspend")))

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
                    (lambda () (interactive) (start-process "" nil "sudo" "pm-suspend")))


;; Use windmove within GUI apps
(exwm-input-set-key (kbd "s-<right>") 'windmove-right)
(push (elt (kbd "s-<right>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "s-<left>") 'windmove-left)
(push (elt (kbd "s-<left>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "s-<up>") 'windmove-up)
(push (elt (kbd "s-<up>") 0) exwm-input-prefix-keys)
(exwm-input-set-key (kbd "s-<down>") 'windmove-down)
(push (elt (kbd "s-<down>") 0) exwm-input-prefix-keys)

;; Resize buffers within GUI apps
(global-set-key [C-s-right] 'win-resize-right)
(push (elt (kbd "C-s-<right>") 0) exwm-input-prefix-keys)
(global-set-key [C-s-up] 'win-resize-up)
(push (elt (kbd "C-s-<up>") 0) exwm-input-prefix-keys)
(global-set-key [C-s-down] 'win-resize-down)
(push (elt (kbd "C-s-<down>") 0) exwm-input-prefix-keys)
(global-set-key [C-s-left] 'win-resize-left)
(push (elt (kbd "C-s-<left>") 0) exwm-input-prefix-keys)



;; Enable workspace
(setq exwm-workspace-number 10)

;; System tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; Composition manager
(require 'exwm-cm)
;; Make all Emacs frames opaque.
(setq window-system-default-frame-alist '((x . ((alpha . 100)))))
;; Assign everything else a 80% opacity.
(setq exwm-cm-opacity 80)
;;(exwm-cm-enable)                        ; This is pretty slow so I've left it off for now. You can put it on at any time with exwm-cm-start
