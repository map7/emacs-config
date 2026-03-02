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
(use-package paradox :defer 5)
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
(defun remove-electric-indent-mode ()
  (electric-indent-local-mode -1))
(add-hook '4gl-mode-hook 'remove-electric-indent-mode)

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

;;--------------------------------------------------------------------------------
;;-Org-mode related (40-49)
;;--------------------------------------------------------------------------------
(load "40-org.el")
(load "42-org-expiry.el")
(load "43-revealjs.el")
(load "44-org-publish.el")

;;--------------------------------------------------------------------------------
;;-Programming tools (50-69)
;;--------------------------------------------------------------------------------
(load "50-multiple-cursors.el")
(load "51-undo-tree.el")
(load "52-rainbow.el")
(load "53-magit.el")
(load "54-yasnippet.el")
(load "55-rinari.el")
(load "56-rsense.el")
(load "59-highlight-parentheses.el")
(load "60-yafolding.el")
(load "61-ruby-refactor.el")
(load "62-robe.el")
(load "63-tide.el")
(load "64-rbenv.el")
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
