;;; package --- Summary
;;; init.el - Emacs configuration backbone file.

;;; Commentary:
;;; All Emacs configuration starts from this file.

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))
(load "102-performance.el")

;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)   ;; To prevent initialising twice
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(load "external-plugins")
(add-to-list 'load-path (expand-file-name "external" user-emacs-directory)) ; Plugins not in the repo
(unless package--initialized (package-initialize))



;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Setup straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Package configuration (NEW way as of 02/12/2016)
(use-package all-the-icons :ensure t :defer 5)
(use-package ansible :ensure t :defer 5)
(use-package clojure-mode :ensure t :defer 5)
(use-package crontab-mode :ensure t :defer 5)
(use-package circe :ensure t :defer 5)
(use-package company :ensure t :defer 5)
(use-package csv-mode :ensure t :defer 5)
(use-package crdt :ensure t :defer 5)   ; Collaborating error free!
(use-package dired-open-with :ensure t :defer 5)
(use-package dumb-jump :ensure t :defer 5)
(use-package expand-region :ensure t :defer 5)
(use-package findr :ensure t :defer 5)
(use-package ledger-mode :ensure t :defer 5)
(use-package markdown-mode :ensure t :defer 5)
(use-package org-noter :ensure t :defer 5)
(use-package paradox :ensure t :defer 5)
(use-package picpocket :ensure t :defer 5 :bind ("M-p" . picpocket))
(use-package sudo-edit :ensure t :defer 5)
(use-package switch-window :ensure t :defer 5)
(use-package vterm :ensure t :defer 5)  ; Best terminal for emacs
(use-package tramp-term :ensure t :defer 5)
(use-package twittering-mode :ensure t :defer 5)
(use-package restclient :ensure t :defer 5) ; Used to test restful APIs
(use-package xkcd :ensure t :defer 5)
(use-package dockerfile-mode :ensure t :defer 5)
(use-package disk-usage :ensure t :defer 5)
(use-package rg :ensure t :defer 5)                        ; ripgrep - compatible with wgrep
(use-package wgrep :ensure t :defer 5)                     ; wgrep - edit grep buffers
(use-package total-lines
  :ensure t
  :config (global-total-lines-mode))

;; Passwords
(use-package keepass-mode :ensure t :defer 5)
(use-package pinentry
  :ensure t
  :init
  (pinentry-start)
  :config
  (setq epa-pinentry-mode 'loopback))

(use-package pass :ensure t :defer 5)

;; other langs
(use-package php-mode :ensure t :defer 5)

;; Ruby related
(use-package enh-ruby-mode :ensure t :defer 5)
(use-package goto-gem :ensure t :defer 5)         ; Goto the directory for a ruby gem package
(use-package ruby-refactor :ensure t :defer 5)    ; Refactor shortcuts

;; Org related
(use-package org-cliplink :ensure t :defer 5)
(use-package org-clock-csv :ensure t :defer 5)
(use-package org-clock-today :ensure t :defer 5)

;; 4gl mode from external
(add-to-list 'load-path (expand-file-name "external/4gl-mode-master" user-emacs-directory))
(require '4gl-mode)
(defun remove-electric-indent-mode ()
  (electric-indent-local-mode -1))
(add-hook '4gl-mode-hook 'remove-electric-indent-mode)

;; All custom files have a number at the front so they don't clash with the library files.
;;--------------------------------------------------------------------------------
;;-Base emacs related (0-39)
;;--------------------------------------------------------------------------------
(load "00-common-setup.el")
(load "01-pdf-tools.el")             ; PDF tools
(load "02-bpr.el")                   ; Background Process Runner
(load "03-async.el")                 ; Asynchronous abilities
(load "04-packages.el")              ; Package related tasks
(load "05-scroll-settings.el")       ; Settings for scrolling
(load "06-togetherly.el")            ; Work together with someone in the same file.
(load "07-dired.el")                 ; Dired related plugins
(load "08-nlinum.el")                ; Line number mode (faster than standard package)
(load "09-real-auto-save.el")        ; Autosave files
(load "10-multi-term.el")            ; Handle multiple terminals in emacs nicely.
(load "11-eshell.el")                ; eshell customisations
(load "12-projectile.el")            ; Manage projects
;; (load "14-ido-mode.el")              ; IDO mode for moving around dirs & buffers
(load "15-winner-mode.el")           ; Undo/redo window layouts
(load "17-emacs-server.el")          ; Config relating to emacs server
(load "18-flyspell.el")              ; Spelling
;;(load "19-spotify.el")              ; Control spotify from emacs
;;(load "20-volume.el")               ; Control volume from emacs
;;(load "21-circe.el")                ; IRC settings
(load "22-epa-file.el")             ; Encryption
;;(load "23-markdown.el")             ; for md files.
;;(load "24-smex.el")                 ; smex (quick narrow down commands)
;;(load "25-speedbar.el")             ; Speedbar customisations
;;(load "26-guide-key.el")            ; Show keyboard shortcuts at certian points
;;(load "27-moz-controller.el")       ; Control firefox within emacs
;;(load "28-save_hooks.el")           ; Processes to perform on save.
;;(load "29-ace_jump.el")             ; Jump around quickly in a file
;;(load "30-discover.el")             ; Discover more of emacs using context menus
;;(load "31-sunshine.el")             ; Weather
;;(load "32-twittering-mode.el")      ; Twitter client
(load "33-ivy.el")                      ; ivy-mode
(load "34-windmove.el")                 ; Move around buffers fast
(load "35-paperless.el")                ; Paperless for managing pdfs
(load "36-nov.el")
(load "37-expenses.el")                 ; Budgeting plugin

;;--------------------------------------------------------------------------------
;;-Org-mode related (40-49)
;;--------------------------------------------------------------------------------
(load "40-org.el")                   ; Org mode
;; (load "41-org2blog.el")              ; Org2blog mode ; 2023 broken
(load "42-org-expiry.el")            ; Org expiry <-- add created property on todo items
(load "43-revealjs.el")              ; Reveal.js settings
(load "44-org-publish.el")           ; Org publish setup
;(load "48-org-ac.el")               ; org mode autocomplete
;(load "49-org-mobile.el")           ; Org sync with MobileOrg for Android devices

;;--------------------------------------------------------------------------------
;;-Programming tools (50-69)
;;--------------------------------------------------------------------------------
(load "50-multiple-cursors.el")      ; Edit multiple lines at the same time.
(load "51-undo-tree.el")             ; Undo tree
(load "52-rainbow.el")               ; Highlight colours in scss files
(load "53-magit.el")                 ; Git
(load "54-yasnippet.el")             ; Yasnippets BUG: https://github.com/capitaomorte/yasnippet/issues/631
(load "55-rinari.el")                ; Ruby on rails mode
(load "56-rsense.el")                ; Command Lookup
;;(load "57-auto-complete.el")       ; Auto complete
;; (load "58-highlight-indentation.el") ; Highlight tabs ;; Slows down interface too much!
(load "59-highlight-parentheses.el") ; Highlights start and end of parentheses.
(load "60-yafolding.el")             ; yafolding
(load "61-ruby-refactor.el")
(load "62-robe.el")                  ; Ruby documentation
(load "63-tide.el")                  ; Typescript Interactive Dev Environment
(load "64-rbenv.el")                 ; Ruby version manager
;;(load "65-slime.el")               ; Slime Superior Lisp Interaction Mode for Emacs
(load "66-flycheck.el")              ; Syntax checking (better than built in flymake)
(load "67-tags.el")                  ; Create tags
(load "68-seeing-is-believing.el")   ; Show ruby expressions in a comment
(load "69-javascript.el")            ; Javascript related
(load "70-ai.el")                    ; AI tools c3po(ChatGPT) & Copilot(Github)

;;--------------------------------------------------------------------------------
;;-Programming modes (75-94)
;;--------------------------------------------------------------------------------
(load "75-scss-mode.el")             ; SCSS mode
(load "76-rspec_mode.el")            ; Rspec testing mode for ruby projects
(load "77-company-mode.el")          ; Autocomplete
(load "78-haml.el")                  ; haml mode
(load "79-css.el")                   ; css mode
(load "80-coffeescript.el")          ; Coffeescript mode
(load "81-ruby.el")                  ; Ruby programming language
(load "82-xml.el")                   ; edit xml files
(load "83-web-mode.el")              ; Mixed mode in web frontend
(load "84-html-mode.el")             ; html mode & json.
(load "85-yaml_mode.el")             ; yaml mode.
;(load "86-jinja2.el")               ; Ansible templates
(load "87-javascript.el")              ; Javascript js2-mode
(load "88-arduino_mode.el")

;;--------------------------------------------------------------------------------
;;-EXWM, appearance and shortcut keys
;;--------------------------------------------------------------------------------
(load "94-i3.el")                     ; i3
(load "95-resize-buffer.el")          ; Resize buffer
(load "97-shortcuts.el")              ; Keyboard shortcuts

;; (if (file-exists-p "~/.xinitrc")
;;     (load "98-exwm.el")                    ; Emacs X Windows Manager
;; )

(if (file-exists-p (expand-file-name ".emacs.autostart.el" user-emacs-directory))
    (load (expand-file-name ".emacs.autostart.el" user-emacs-directory))
)

;; (if (file-exists-p "~/.emacs.mu4e.el")
;;     (load "~/.emacs.mu4e.el")  ; Email settings
;; )

(if (file-exists-p (expand-file-name ".emacs.paradox.el" user-emacs-directory))
    (load (expand-file-name ".emacs.paradox.el" user-emacs-directory))
  )
(load "100-theme.el")                 ; Load theme and setup font
(load "101-modeline.el")

;;; init.el ends here
(put 'downcase-region 'disabled nil)

;; Load apps
(if (file-exists-p (expand-file-name ".emacs.workspace.el" user-emacs-directory))
    (load (expand-file-name ".emacs.workspace.el" user-emacs-directory))
  )

;; Setup default window size
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 150)) 

;; Read in custom settings for the user
(load (expand-file-name ".emacs.custom.el" user-emacs-directory))

;;;; Refer to issue 216 on exwm for a discussion on this.
;; (require 'desktop)
;; (setq desktop-save 1
;;       desktop-load-locked-desktop t
;;       desktop-dirname user-emacs-directory
;;       desktop-files-not-to-save "\\(^/[^/:]*:\\|(ftp)$\\)\\|\\(\\.gpg$\\)")
