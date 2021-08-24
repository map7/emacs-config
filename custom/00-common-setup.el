(load "tab-settings")
(load "backup-settings")

;;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;;; Useful Defaults
(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(setq ring-bell-function 'ignore)         ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster
(show-paren-mode 1)                       ; Show closing parens by default
(delete-selection-mode 1)                 ; Selected text will be overwritten when you start typing
(global-auto-revert-mode t)               ; Auto-update buffer if file has changed on disk

(add-hook 'before-save-hook
	  'delete-trailing-whitespace)          ; Delete trailing whitespace on save


(setq save-abbrevs 'silently)             ;; save abbrevs when files are saved
(global-font-lock-mode t)                 ;; Use highlight colors


;; Dired setup
(setq dired-listing-switches "-alh")

;; Enter conf-mode for all rc files
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))


