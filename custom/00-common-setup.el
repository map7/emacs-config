;; Enable the built in pair mode
(electric-pair-mode 1)

;; auto-indent
(define-key global-map (kbd "C-j") 'newline-and-indent)

;; Tab settings
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

; General settings
(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-options-version "2.32")
 '(inhibit-startup-screen t)
 '(max-lisp-eval-depth 3000)
 '(max-specpdl-size 3000)
 '(menu-bar-mode 1)
 '(org-archive-location "~/org/archive/%s_archive::")
 '(rails-ws:default-server-type "mongrel")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service "smtp")
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

; stop emacs from contaminating each directory with semantic.cache
(setq semanticdb-default-save-directory "/tmp")

;; (display-battery-mode)
(setq column-number-mode t)
(display-time)
(setq backup-inhibited t) ;; disable backup

;fullscreen mode (Redundant in Emacs 24.4)
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

;; Don't ask to save abbrevs
(setq save-abbrevs 'silently)

;; Use highlight colors
(global-font-lock-mode t)
