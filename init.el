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
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
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

;; Read in custom settings for the user
(load (expand-file-name ".emacs.custom.el" user-emacs-directory))

;;;; Refer to issue 216 on exwm for a discussion on this.
;; (require 'desktop)
;; (setq desktop-save 1
;;       desktop-load-locked-desktop t
;;       desktop-dirname user-emacs-directory
;;       desktop-files-not-to-save "\\(^/[^/:]*:\\|(ftp)$\\)\\|\\(\\.gpg$\\)")
;; (desktop-save-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bookmark-default-file "~/Sync/emacs-bookmarks")
 '(dired-open-extensions
   '(("jpg" . "shotwell")
     ("jpeg" . "shotwell")
     ("png" . "shotwell")
     ("odt" . "libreoffice")
     ("ods" . "libreoffice")
     ("svg" . "inkscape")
     ("stl" . "prusaslicer")
     ("kdbx" . "keepassxc")
     ("xls" . "libreoffice")
     ("doc" . "libreoffice")
     ("pub" . "libreoffice")
     ("odg" . "libreoffice")
     ("netmap" . "java -jar ~/bin/jNetMap.jar $1")
     ("glabels" . "glabels-3")
     ("abw" . "libreoffice")
     ("JPG" . "shotwell")))
 '(dired-open-functions '(dired-open-by-extension dired-open-subdir ignore))
 '(erc-modules
   '(autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands notify readonly ring stamp track))
 '(flycheck-coffee-coffeelint-executable "/opt/node-v5.5.0-linux-x64/bin/coffeelint")
 '(flycheck-coffeelintrc "~/coffeelint.json")
 '(flycheck-javascript-eslint-executable "/opt/node-v5.5.0-linux-x64/bin/eslint")
 '(flycheck-ruby-rubocop-executable "/usr/local/rbenv/shims/rubocop")
 '(org-stuck-projects '(":hard/+TODO" ("DONE" "REDUNDANT") nil ""))
 '(package-selected-packages
   '(c3po mpv yeetube xterm-color blackjack dall-e-shell chatgpt-shell php-mode dirvish expenses gnuplot multi-vterm vterm crdt async picpocket dumb-jump clojure-mode indium keepass-mode org-noter org-babel-eval-in-repl steam slime-volleyball i3wm total-lines disk-usage system-packages real-auto-save super-save org mu4e-maildirs-extension goto-gem wgrep rg chess dired-rainbow dired-narrow dired-ranger dired-open dired-hacks-utils edit-indirect pinentry ivy-pass sx backlight mw-thesaurus company-statistics company counsel-org-clock daemons bongo pass symon pocket-reader pulseaudio-control yafolding nov rudel dockerfile-mode treemacs dired-du nlinum-hl pdf-tools spotify counsel-spotify all-the-icons-ivy command-log-mode paperless pacmacs slack crontab-mode tide xkcd use-package-chords use-package flycheck yasnippet yaml-mode web-mode undo-tree twittering-mode tramp-term togetherly switch-window sudo-edit spaceline scss-mode ruby-refactor ruby-end ruby-electric rspec-mode rsense robe rinari rbenv rainbow-mode projectile-rails paradox pallet ox-reveal org2blog org-clock-csv org-cliplink org-attach-screenshot nlinum multiple-cursors multi-term moe-theme markdown-mode magit linum-off jsx-mode js2-mode highlight-parentheses highlight-indentation haml-mode grizzl expand-region enh-ruby-mode diredful dired-details csv-mode coffee-mode circe bpr ansible))
 '(paperless-capture-directory "~/paperless/upload")
 '(paperless-root-directory "~/paperless/documents")
 '(paradox-automatically-star t)
 '(paradox-github-token t)
 '(safe-local-variable-values
   '((dired-omit-files . "\\.html\\'")
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")))
 '(undo-tree-visualizer-default-face nil)
 '(xcb:debug t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#000000" :foreground "#ffffff"))))
 '(flyspell-incorrect ((t (:underline (:color "Red1" :style wave) :weight normal :foreground nil :background nil))))
 '(font-lock-builtin-face ((t (:foreground "red2"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "chocolate1" :slant italic))))
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "DodgerBlue1"))))
 '(font-lock-doc-face ((t (:foreground "orange1"))))
 '(font-lock-function-name-face ((t (:foreground "yellow2" :weight normal))))
 '(font-lock-keyword-face ((t (:foreground "chartreuse" :weight normal))))
 '(font-lock-preprocessor-face ((t (:foreground "LightSkyBlue1"))))
 '(font-lock-string-face ((t (:foreground "orange1"))))
 '(font-lock-type-face ((t (:foreground "cyan" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "chartreuse"))))
 '(ido-first-match ((t (:foreground "dark orange" :weight semibold))))
 '(ido-subdir ((t (:foreground "deep sky blue"))))
 '(linum ((t (:background "black" :foreground "#b2b2b2"))))
 '(magit-bisect-bad ((t (:foreground "IndianRed4" :background nil))))
 '(magit-bisect-good ((t (:foreground "DarkOliveGreen" :background nil))))
 '(magit-bisect-skip ((t (:foreground "DarkGoldenrod" :background nil))))
 '(magit-blame-date ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-hash ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-heading ((t (:background "grey25" :foreground "white"))))
 '(magit-blame-name ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-summary ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-branch-current ((t (:inherit magit-branch-local :box 1 :weight normal :underline nil :foreground nil :background nil))))
 '(magit-branch-local ((t (:foreground "LightSkyBlue1" :weight normal :underline nil :background nil))))
 '(magit-branch-remote ((t (:foreground "DarkSeaGreen2" :weight normal :underline nil :background nil))))
 '(magit-cherry-equivalent ((t (:foreground "magenta"))))
 '(magit-cherry-unmatched ((t (:foreground "cyan"))))
 '(magit-diff-added ((t (:background "#335533" :foreground "#ddffdd" :weight normal))))
 '(magit-diff-added-highlight ((t (:background "#336633" :foreground "#cceecc" :weight normal))))
 '(magit-diff-base ((t (:background "#555522" :foreground "#ffffcc"))))
 '(magit-diff-base-highlight ((t (:background "#666622" :foreground "#eeeebb" :weight normal :inherit nil))))
 '(magit-diff-conflict-heading ((t (:inherit magit-diff-hunk-heading :foreground nil :background nil))))
 '(magit-diff-context ((t (:foreground "grey70"))))
 '(magit-diff-context-highlight ((t (:background "grey20" :foreground "grey70" :inherit nil))))
 '(magit-diff-file-heading ((t (:weight bold :foreground nil))))
 '(magit-diff-file-heading-highlight ((t (:weight bold :background nil))))
 '(magit-diff-file-heading-selection ((t (:inherit magit-diff-file-heading-highlight :foreground "LightSalmon3" :weight normal :background nil))))
 '(magit-diff-hunk-heading ((t (:background "grey25" :foreground "grey70"))))
 '(magit-diff-hunk-heading-highlight ((t (:background "grey35" :foreground "grey70"))))
 '(magit-diff-hunk-heading-selection ((t (:inherit magit-diff-hunk-heading-highlight :foreground "LightSalmon3" :background nil))))
 '(magit-diff-hunk-region ((t (:inherit bold))))
 '(magit-diff-lines-boundary ((t (:inherit magit-diff-lines-heading :background nil :foreground nil))))
 '(magit-diff-lines-heading ((t (:inherit magit-diff-hunk-heading-highlight :background "salmon4" :foreground "grey80"))))
 '(magit-diff-our ((t (:inherit magit-diff-removed :foreground nil))))
 '(magit-diff-our-highlight ((t (:inherit magit-diff-removed-highlighted :foreground nil :background nil))))
 '(magit-diff-removed ((t (:background "#553333" :foreground "#ffdddd" :weight normal))))
 '(magit-diff-removed-highlight ((t (:background "#663333" :foreground "#eecccc" :weight normal :inherit nil))))
 '(magit-diff-their ((t (:inherit magit-diff-added :foreground nil))))
 '(magit-diff-their-highlight ((t (:inherit magit-diff-added-highlight :foreground nil :background nil))))
 '(magit-diff-whitespace-warning ((t (:inherit trailing-whitespace :foreground nil :background nil))))
 '(magit-diffstat-added ((t (:foreground "#448844" :weight normal :background nil))))
 '(magit-diffstat-removed ((t (:foreground "#aa4444" :weight normal :background nil))))
 '(magit-dimmed ((t (:foreground "grey50"))))
 '(magit-filename ((t (:weight medium :foreground nil))))
 '(magit-hash ((t (:foreground "grey40"))))
 '(magit-head ((t (:inherit magit-branch-local :foreground nil :background nil))))
 '(magit-header-line ((t (:inherit magit-section-heading :foreground nil))))
 '(magit-log-author ((t (:foreground "tomato"))))
 '(magit-log-date ((t (:foreground "grey80"))))
 '(magit-log-graph ((t (:foreground "grey80"))))
 '(magit-process-ng ((t (:inherit magit-section-heading :foreground "red" :underline nil :background nil))))
 '(magit-process-ok ((t (:inherit magit-section-heading :foreground "green" :underline nil :background nil))))
 '(magit-reflog-amend ((t (:foreground "magenta" :background nil))))
 '(magit-reflog-checkout ((t (:foreground "blue" :background nil))))
 '(magit-reflog-cherry-pick ((t (:foreground "green" :background nil))))
 '(magit-reflog-commit ((t (:foreground "green" :background nil))))
 '(magit-reflog-merge ((t (:foreground "green" :background nil))))
 '(magit-reflog-other ((t (:foreground "cyan" :background nil))))
 '(magit-reflog-rebase ((t (:foreground "magenta" :background nil))))
 '(magit-reflog-remote ((t (:foreground "cyan" :background nil))))
 '(magit-reflog-reset ((t (:foreground "red" :background nil))))
 '(magit-section-heading ((t (:foreground "LightGoldenrod2" :weight bold :underline nil))))
 '(magit-section-heading-selection ((t (:foreground "LightSalmon3" :background nil))))
 '(magit-section-highlight ((t (:background "grey20"))))
 '(magit-sequence-done ((t (:inherit magit-hash :foreground nil))))
 '(magit-sequence-drop ((t (:foreground "IndianRed"))))
 '(magit-sequence-head ((t (:foreground "LightSkyBlue1"))))
 '(magit-sequence-onto ((t (:inherit magit-sequence-done :foreground nil))))
 '(magit-sequence-part ((t (:foreground "LightGoldenrod2"))))
 '(magit-sequence-pick ((t (:inherit default :foreground nil))))
 '(magit-sequence-stop ((t (:foreground "DarkSeaGreen2"))))
 '(magit-signature-bad ((t (:foreground "red"))))
 '(magit-signature-good ((t (:foreground "green"))))
 '(magit-signature-untrusted ((t (:foreground "cyan"))))
 '(magit-tag ((t (:foreground "LightGoldenrod2" :background nil))))
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-buffer-id ((t (:foreground "black" :box nil :weight bold))))
 '(mode-line-inactive ((t (:background "gray30" :foreground "#f9f9f9" :box nil))))
 '(mouse ((t (:background "grey"))))
 '(region ((t (:background "dim gray"))))
 '(term-color-blue ((t (:background "blue2" :foreground "gold")))))
