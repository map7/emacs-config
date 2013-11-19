; Keybinding (Keyboard shortcuts)
(global-set-key [f1] 'twit)
(global-set-key [f2] 'gist-region-or-buffer)
(global-set-key [f3] 'switch-window)
(global-set-key [f4] 'magit-log)
(global-set-key [f5] 'magit-status)
(global-set-key [f6] 'multi-term)
(global-set-key [f7] 'split-window-vertically)
(global-set-key [f8] 'next-multiframe-window)
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
(global-set-key (kbd "s-e") 'eval-buffer)

(global-set-key (kbd "s-RET") 'google-maps)

(global-set-key (kbd "C-c I") 'irc)

;; Speed up common functions
(global-set-key (kbd "s-2") 'split-window-vertically)
(global-set-key (kbd "s-3") 'split-window-horizontally)


; General settings
(setq-default tab-width 4)

(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-options-version "2.32")
 '(inhibit-startup-screen t)
 '(max-lisp-eval-depth 3000)
 '(max-specpdl-size 3000)
 '(menu-bar-mode 1)

 '(rails-ws:default-server-type "mongrel")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service "smtp")
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


;; Remap hyper key as super
(setq x-hyper-keysym 'super)


;; (display-battery-mode)
(setq column-number-mode t)
(display-time)
(setq backup-inhibited t) ;; disable backup

;; Allow using mouse thumb button to browse URLs
(global-set-key [mouse-10] 'browse-url-at-mouse)

; stop emacs from contaminating each directory with semantic.cache
(setq semanticdb-default-save-directory "/tmp")

;; set scroll to step by 1 instead of half a page.
(setq scroll-step            1
	  scroll-conservatively  10000)

;fullscreen mode
(defun switch-full-screen ()
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

;; Setup external directory variable
(setq elisp-external-dir
	  (expand-file-name "external" user-emacs-directory))

;; Add external projects to load path
(add-to-list 'load-path elisp-external-dir)

(dolist (project (directory-files elisp-external-dir t "\\w+"))
  (when (file-directory-p project)
	(add-to-list 'load-path project)))


; Auto revert unless there is unsaved data
(global-auto-revert-mode t)
