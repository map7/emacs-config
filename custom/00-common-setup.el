;; Replace bell (beep) with visible bell
(setq visible-bell t)

;; Enable the built in pair mode
(electric-pair-mode 1)

;;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; Turn off splash screen
(setq inhibit-splash-screen t)

;; auto-indent
(define-key global-map (kbd "C-j") 'newline-and-indent)

;; Tab settings
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

; stop emacs from contaminating each directory with semantic.cache
(setq semanticdb-default-save-directory "/tmp")

;; (display-battery-mode)

(setq column-number-mode t)

(setq backup-inhibited t) ;; disable backup
(setq make-backup-files nil)

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

;; Don't ask to save abbrevs
(setq save-abbrevs 'silently)

;; Use highlight colors
(global-font-lock-mode t)

;; Hide system ruby version from modeline
(setq rbenv-show-active-ruby-in-modeline nil)

;; ;; Clean up whitepace before saving a file
;; ;; Exclude this from org-mode
;; (add-hook 'before-save-hook 'whitespace-cleanup)

;; ;; Save desktop
;; (desktop-save-mode 1)

;; Dired setup
(setq dired-listing-switches "-alh")

;; Enter conf-mode for all rc files
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))


