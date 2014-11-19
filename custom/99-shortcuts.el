;; General shortcut keys

;; Remap hyper key as super
(setq x-hyper-keysym 'super)
;
; Examples
; http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
;
; C-<f12> = Use control function keys
; s-h     = Use windows key (super), this example is super & h
;

; Keybinding (Keyboard shortcuts)
(global-set-key [f1] 'twit)
(global-set-key [f2] 'gist-region-or-buffer)
(global-set-key [f3] 'switch-window)
(global-set-key [f4] 'magit-log)
(global-set-key [f5] 'magit-status)
(global-set-key [f6] 'multi-term)
(global-set-key [f7] 'split-window-vertically)
(global-set-key [f8] 'ace-window)
;; f9 is taken by git-status somewhere.
(global-set-key [f10] 'undo-tree-visualize)
(global-set-key [f12] 'switch-full-screen)

;; key bindings for dictionary
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)

;; Expand region shortcut
(global-set-key (kbd "C-=") 'er/expand-region)

;; Using 's' for work computer and 'H' for notebook as there is a
;; difference in mapping the super key.
(global-set-key (kbd "C-S-e") 'eval-buffer)

(global-set-key (kbd "s-RET") 'google-maps)

(global-set-key (kbd "C-c I") 'irc)

;; Speed up common functions
(global-set-key (kbd "s-2") 'split-window-vertically)
(global-set-key (kbd "s-3") 'split-window-horizontally)

;; Unset minimize so I stop hitting it
(global-unset-key (kbd "C-x C-z"))

;; Allow using mouse thumb button to browse URLs
(global-set-key [mouse-10] 'browse-url-at-mouse)

;; rotate windows (Defined in common-setup)
(load "rotate-windows.el")
(global-set-key (kbd "C-<tab>") 'rotate-windows)

;; Paste a link into an org file.
(global-set-key (kbd "C-x p i") 'org-cliplink)
