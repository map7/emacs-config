;;; init.el --- Emacs configuration backbone

;;; Commentary:
;;; All Emacs configuration starts from this file.

;;; Code:

;;;; Performance
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))
(load "102-performance.el")

;;;; Package management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(load "external-plugins")
(add-to-list 'load-path (expand-file-name "external" user-emacs-directory))
(package-initialize)

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

;;;; Package declarations
(use-package transient)
(use-package all-the-icons :defer 5)
(use-package ansible :defer 5)
(use-package clojure-mode :defer 5)
(use-package crontab-mode :defer 5)
(use-package circe :defer 5)
(use-package company :defer 5)
(use-package csv-mode :defer 5)
(use-package crdt :defer 5)
(use-package dired-open-with :defer 5)
(use-package dumb-jump :defer 5)
(use-package expand-region :defer 5)
(use-package findr :defer 5)
(use-package ledger-mode :defer 5)
(use-package markdown-mode :defer 5)
(use-package org-noter :defer 5)
(use-package paradox :defer 5
  :config
  (unless (assoc-string "source" paradox--package-count)
    (push '("source" . 0) paradox--package-count)))
(use-package picpocket :defer 5 :bind ("M-p" . picpocket))
(use-package sudo-edit :defer 5)
(use-package switch-window :defer 5)
(use-package vterm :defer 5)
(use-package tramp-term :defer 5)
(use-package twittering-mode :defer 5)
(use-package restclient :defer 5)
(use-package xkcd :defer 5)
(use-package dockerfile-mode :defer 5)
(use-package disk-usage :defer 5)
(use-package rg :defer 5)
(use-package wgrep :defer 5)
(use-package total-lines
  :config (global-total-lines-mode))

;; Passwords
(use-package keepass-mode :defer 5)
(use-package pinentry
  :init
  (pinentry-start)
  :config
  (setq epa-pinentry-mode 'loopback))
(use-package pass :defer 5)

;; AI
(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el"
       :rev :newest
       :branch "main"))

;; Other langs
(use-package php-mode :defer 5)

;; Ruby related
(use-package enh-ruby-mode :defer 5)
(use-package goto-gem :defer 5)
(use-package ruby-refactor :defer 5)

;; Org related
(use-package org-cliplink :defer 5)
(use-package org-clock-csv :defer 5)
(use-package org-clock-today :defer 5)

;;;; 4gl mode
(add-to-list 'load-path (expand-file-name "external/4gl-mode-master" user-emacs-directory))
(require '4gl-mode)

;;;; Custom config files

;;--------------------------------------------------------------------------------
;;-Base emacs related (0-39)
;;--------------------------------------------------------------------------------
(load "00-common-setup.el")
(load "01-pdf-tools.el")
(load "02-bpr.el")
(load "03-async.el")
(load "04-packages.el")
(load "05-scroll-settings.el")
(load "06-togetherly.el")
(load "07-dired.el")
(load "08-nlinum.el")
(load "09-real-auto-save.el")
(load "10-multi-term.el")
(load "11-eshell.el")
(load "12-projectile.el")
(load "15-winner-mode.el")
(load "17-emacs-server.el")
(load "18-flyspell.el")
(load "22-epa-file.el")
(load "33-ivy.el")
(load "34-windmove.el")
(load "35-paperless.el")
(load "36-nov.el")
(load "38-elfeed.el")

;;--------------------------------------------------------------------------------
;;-Org-mode related (40-49)
;;--------------------------------------------------------------------------------
(load "40-org.el")
(load "42-org-expiry.el")
(load "43-revealjs.el")
(load "44-org-publish.el")
(load "45-org-easydraw.el")
(load "46-whisper.el")

;;--------------------------------------------------------------------------------
;;-Programming tools (50-69)
;;--------------------------------------------------------------------------------
(load "50-multiple-cursors.el")
(load "51-undo-tree.el")
(load "52-rainbow.el")
(load "53-magit.el")
(load "54-yasnippet.el")
(load "55-rinari.el")
(load "59-highlight-parentheses.el")
(load "60-yafolding.el")
(load "61-ruby-refactor.el")
(load "62-robe.el")
(load "63-tide.el")
(load "65-iedit.el")
(load "66-flycheck.el")
(load "67-tags.el")
(load "68-seeing-is-believing.el")
(load "69-javascript.el")
(load "70-ai.el")

;;--------------------------------------------------------------------------------
;;-Programming modes (75-94)
;;--------------------------------------------------------------------------------
(load "75-scss-mode.el")
(load "76-rspec_mode.el")
(load "77-company-mode.el")
(load "78-haml.el")
(load "79-css.el")
(load "80-coffeescript.el")
(load "81-ruby.el")
(load "82-xml.el")
(load "83-web-mode.el")
(load "84-html-mode.el")
(load "85-yaml_mode.el")
(load "87-javascript.el")
(load "88-arduino_mode.el")
(load "89-python.el")
(load "89-rust.el")

;;--------------------------------------------------------------------------------
;;-EXWM, appearance and shortcut keys
;;--------------------------------------------------------------------------------
(load "94-i3.el")
(load "95-resize-buffer.el")
(load "97-shortcuts.el")

;;;; Appearance
(load "100-theme.el")
(load "101-modeline.el")

;; Frame size
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 150))

;;;; Optional/conditional loads
(when-let ((f (expand-file-name ".emacs.autostart.el" user-emacs-directory)))
  (when (file-exists-p f) (load f)))

(when-let ((f (expand-file-name ".emacs.paradox.el" user-emacs-directory)))
  (when (file-exists-p f) (load f)))

(when-let ((f (expand-file-name ".emacs.workspace.el" user-emacs-directory)))
  (when (file-exists-p f) (load f)))

(load (expand-file-name ".emacs.custom.el" user-emacs-directory))

;;;; Misc
(put 'downcase-region 'disabled nil)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bookmark-default-file "~/Sync/emacs-bookmarks")
 '(dired-open-extensions
   '(("jpg" . "shotwell") ("jpeg" . "shotwell") ("gif" . "shotwell")
     ("bmp" . "shotwell") ("png" . "shotwell") ("wp" . "libreoffice")
     ("ott" . "libreoffice") ("odt" . "libreoffice")
     ("odf" . "libreoffice") ("ods" . "libreoffice")
     ("ots" . "libreoffice") ("xcf" . "gimp") ("svg" . "inkscape")
     ("kdbx" . "keepassxc") ("xls" . "libreoffice")
     ("doc" . "libreoffice") ("dot" . "libreoffice")
     ("pub" . "libreoffice") ("odg" . "libreoffice")
     ("ppt" . "libreoffice") ("mp4" . "mplayer")
     ("netmap" . "java -jar ~/bin/jNetMap.jar $1")
     ("glabels" . "glabels-3") ("abw" . "libreoffice")
     ("JPG" . "shotwell")))
 '(dired-open-functions '(dired-open-by-extension dired-open-subdir ignore))
 '(erc-modules
   '(autojoin button completion fill irccontrols list log match menu
              move-to-prompt netsplit networks noncommands notify
              readonly ring stamp track))
 '(org-stuck-projects '(":hard/+TODO" ("DONE" "REDUNDANT") nil ""))
 '(package-selected-packages
   '(indium restclient twittering-mode switch-window ledger-mode counsel
            ivy winner-mode-enable winner-mode total-lines disk-usage
            system-packages real-auto-save super-save org
            mu4e-maildirs-extension goto-gem wgrep rg chess
            dired-rainbow dired-narrow dired-ranger dired-open
            dired-hacks-utils edit-indirect pinentry ivy-pass sx
            backlight mw-thesaurus company-statistics company
            counsel-org-clock daemons bongo pass symon pocket-reader
            pulseaudio-control yafolding nov rudel dockerfile-mode
            treemacs dired-du nlinum-hl pdf-tools counsel-spotify
            all-the-icons-ivy command-log-mode paperless pacmacs slack
            crontab-mode tide xkcd use-package-chords use-package
            flycheck yasnippet yaml-mode web-mode tramp-term
            togetherly sudo-edit spaceline scss-mode ruby-refactor
            ruby-end ruby-electric rspec-mode rsense robe rinari rbenv
            rainbow-mode projectile-rails paradox pallet ox-reveal
            org2blog org-clock-csv org-cliplink org-attach-screenshot
            nlinum multiple-cursors multi-term moe-theme markdown-mode
            magit linum-off jsx-mode js2-mode highlight-parentheses
            highlight-indentation haml-mode grizzl expand-region
            enh-ruby-mode diredful dired-details csv-mode coffee-mode
            circe bpr ansible))
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
