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
(load "24-midi.el")

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
 '(flycheck-coffee-coffeelint-executable "/opt/node-v5.5.0-linux-x64/bin/coffeelint")
 '(flycheck-coffeelintrc "~/coffeelint.json")
 '(flycheck-javascript-eslint-executable "/opt/node-v5.5.0-linux-x64/bin/eslint")
 '(flycheck-ruby-rubocop-executable
   "/home/map7/.local/share/mise/installs/ruby/3.4.5/bin/rubocop")
 '(org-agenda-files
   '("/home/map7/org/20130222.org"
     "/home/map7/org/Getting Started with Orgzly.org"
     "/home/map7/org/aad.org" "/home/map7/org/advice.org"
     "/home/map7/org/ai.org" "/home/map7/org/alchester.org"
     "/home/map7/org/amanda-bishop-framework-notebook.org"
     "/home/map7/org/amanda.org" "/home/map7/org/anchovies.org"
     "/home/map7/org/assistance_and_access_bill_2018.org"
     "/home/map7/org/asus_transformer_tf300t_tablet.org"
     "/home/map7/org/ava.org" "/home/map7/org/baby.org"
     "/home/map7/org/bars.org" "/home/map7/org/bb-8.org"
     "/home/map7/org/bender.org" "/home/map7/org/bike.org"
     "/home/map7/org/blog.org" "/home/map7/org/bluray.org"
     "/home/map7/org/books.org" "/home/map7/org/brands.org"
     "/home/map7/org/breezeviti.org" "/home/map7/org/brother.org"
     "/home/map7/org/cafes.org" "/home/map7/org/camping.org"
     "/home/map7/org/car.org" "/home/map7/org/cars.org"
     "/home/map7/org/cat_mccain.org" "/home/map7/org/chip.org"
     "/home/map7/org/chiptunes.org"
     "/home/map7/org/chocolate_bars.org"
     "/home/map7/org/cholesterol.org" "/home/map7/org/cider.org"
     "/home/map7/org/coffee.org" "/home/map7/org/cool_things.org"
     "/home/map7/org/covid-19.org" "/home/map7/org/cubox.org"
     "/home/map7/org/d&d.org" "/home/map7/org/dad.org"
     "/home/map7/org/dale.org" "/home/map7/org/danch.org"
     "/home/map7/org/data_retention.org" "/home/map7/org/deck.org"
     "/home/map7/org/digdug.org" "/home/map7/org/dinner.org"
     "/home/map7/org/donuts.org" "/home/map7/org/dvd.org"
     "/home/map7/org/ebay.org" "/home/map7/org/ebooks.org"
     "/home/map7/org/ecoprint.org" "/home/map7/org/electronics.org"
     "/home/map7/org/enocean.org"
     "/home/map7/org/ethical_companies.org"
     "/home/map7/org/flipper_zero.org" "/home/map7/org/flying.org"
     "/home/map7/org/free_wifi.org" "/home/map7/org/friends.org"
     "/home/map7/org/funny.org" "/home/map7/org/games.org"
     "/home/map7/org/gary.org" "/home/map7/org/gas.org"
     "/home/map7/org/geraldine.org" "/home/map7/org/gifs.org"
     "/home/map7/org/goev.org"
     "/home/map7/org/goev_auto_charge_article.org"
     "/home/map7/org/gpg_keys.org" "/home/map7/org/hal9000.org"
     "/home/map7/org/health.org" "/home/map7/org/heather_powell.org"
     "/home/map7/org/hole.org" "/home/map7/org/holiday.org"
     "/home/map7/org/home_25_ironbark.org"
     "/home/map7/org/home_5_ironbark.org"
     "/home/map7/org/home_daphne.org"
     "/home/map7/org/home_firewall.org" "/home/map7/org/home_food.org"
     "/home/map7/org/home_lex.org" "/home/map7/org/home_nas.org"
     "/home/map7/org/home_power.org" "/home/map7/org/home_wifi.org"
     "/home/map7/org/homelab.org" "/home/map7/org/ideas.org"
     "/home/map7/org/inbox.org" "/home/map7/org/initial_d.org"
     "/home/map7/org/insurance.org" "/home/map7/org/jack.org"
     "/home/map7/org/japan.org" "/home/map7/org/jawbone_jambox.org"
     "/home/map7/org/joe.org" "/home/map7/org/joe_debates.org"
     "/home/map7/org/kids.org" "/home/map7/org/kindle.org"
     "/home/map7/org/learning.org" "/home/map7/org/lego.org"
     "/home/map7/org/lend.org" "/home/map7/org/lenovo_n20_deckard.org"
     "/home/map7/org/leostick.org" "/home/map7/org/linkt_citylink.org"
     "/home/map7/org/linux.conf.au.org" "/home/map7/org/luca.org"
     "/home/map7/org/lunch.org" "/home/map7/org/makey_makey.org"
     "/home/map7/org/me.org" "/home/map7/org/medibank.org"
     "/home/map7/org/melbjs.org" "/home/map7/org/minimalism.org"
     "/home/map7/org/mlug contact.org" "/home/map7/org/mlug.org"
     "/home/map7/org/mlug_screen.org" "/home/map7/org/money.org"
     "/home/map7/org/motors.org" "/home/map7/org/movie_streaming.org"
     "/home/map7/org/movies.org" "/home/map7/org/music.org"
     "/home/map7/org/myki.org" "/home/map7/org/nan.org"
     "/home/map7/org/news.org" "/home/map7/org/ninjablocks.org"
     "/home/map7/org/notes.org" "/home/map7/org/nsa.org"
     "/home/map7/org/ollama.org" "/home/map7/org/orders.org"
     "/home/map7/org/pCorePlayer.org" "/home/map7/org/padrino.org"
     "/home/map7/org/parents.org" "/home/map7/org/party.org"
     "/home/map7/org/people.org" "/home/map7/org/personal_email.org"
     "/home/map7/org/piano.org" "/home/map7/org/pico.org"
     "/home/map7/org/pihole.org"
     "/home/map7/org/pikvm_mark_instructions.org"
     "/home/map7/org/planes.org" "/home/map7/org/pocket_chip.org"
     "/home/map7/org/pope_family.org" "/home/map7/org/powell.org"
     "/home/map7/org/prams.org" "/home/map7/org/presentation.org"
     "/home/map7/org/presents.org" "/home/map7/org/publishable.co.org"
     "/home/map7/org/publishing_solutions.org"
     "/home/map7/org/questions_for_joe.org"
     "/home/map7/org/raspberry_pi.org"
     "/home/map7/org/real_estate.org" "/home/map7/org/restaurant.org"
     "/home/map7/org/retailers.org" "/home/map7/org/robot_vacuum.org"
     "/home/map7/org/robots.org" "/home/map7/org/roof_racks.org"
     "/home/map7/org/roro.org" "/home/map7/org/rss_readers.org"
     "/home/map7/org/scary_tech.org" "/home/map7/org/series.org"
     "/home/map7/org/shoes.org" "/home/map7/org/shopping.org"
     "/home/map7/org/sister.org" "/home/map7/org/soundbars.org"
     "/home/map7/org/spare.org" "/home/map7/org/squash.org"
     "/home/map7/org/staffreview.org" "/home/map7/org/starcraft.org"
     "/home/map7/org/startrek.org" "/home/map7/org/steam.org"
     "/home/map7/org/steam_controller.org"
     "/home/map7/org/sylvana.org" "/home/map7/org/tax.org"
     "/home/map7/org/temp.org" "/home/map7/org/tents.org"
     "/home/map7/org/test.org" "/home/map7/org/test_reveal.org"
     "/home/map7/org/thoughts.org" "/home/map7/org/torc.org"
     "/home/map7/org/torrents.org" "/home/map7/org/train.org"
     "/home/map7/org/tv.org" "/home/map7/org/tv_shows.org"
     "/home/map7/org/tv_units.org" "/home/map7/org/up_squared.org"
     "/home/map7/org/vesti.org" "/home/map7/org/vinocellar.org"
     "/home/map7/org/wandboard.org" "/home/map7/org/wearable.org"
     "/home/map7/org/whisky.org" "/home/map7/org/willow.org"
     "/home/map7/org/wines.org" "/home/map7/org/xbmc_ir_keycodes.org"
     "/home/map7/org/xmas.org" "/home/map7/org/xt.org"
     "/home/map7/org/business/michael/3d_printing.org"
     "/home/map7/org/business/michael/android.org"
     "/home/map7/org/business/michael/angelo.org"
     "/home/map7/org/business/michael/angular.org"
     "/home/map7/org/business/michael/ansible.org"
     "/home/map7/org/business/michael/asset_management.org"
     "/home/map7/org/business/michael/ato.org"
     "/home/map7/org/business/michael/backup.org"
     "/home/map7/org/business/michael/backup_gem.org"
     "/home/map7/org/business/michael/because_we_care.org"
     "/home/map7/org/business/michael/cameras.org"
     "/home/map7/org/business/michael/chris.org"
     "/home/map7/org/business/michael/cleantime.org"
     "/home/map7/org/business/michael/click3pl.org"
     "/home/map7/org/business/michael/dcre.org"
     "/home/map7/org/business/michael/digitech.org"
     "/home/map7/org/business/michael/digitech_website.org"
     "/home/map7/org/business/michael/dms.org"
     "/home/map7/org/business/michael/dunlop_&_piston.org"
     "/home/map7/org/business/michael/ebay.org"
     "/home/map7/org/business/michael/emacs.org"
     "/home/map7/org/business/michael/email.org"
     "/home/map7/org/business/michael/fabulous_catering.org"
     "/home/map7/org/business/michael/fastline.org"
     "/home/map7/org/business/michael/firefox.org"
     "/home/map7/org/business/michael/firewall.org"
     "/home/map7/org/business/michael/frank_caleandro.org"
     "/home/map7/org/business/michael/front.org"
     "/home/map7/org/business/michael/git.org"
     "/home/map7/org/business/michael/globalfashionservice.org"
     "/home/map7/org/business/michael/google_drive.org"
     "/home/map7/org/business/michael/govreports.org"
     "/home/map7/org/business/michael/insync.org"
     "/home/map7/org/business/michael/internet.org"
     "/home/map7/org/business/michael/joe_carlton.org"
     "/home/map7/org/business/michael/joe_farm.org"
     "/home/map7/org/business/michael/joe_notebook_airiam.org"
     "/home/map7/org/business/michael/joe_notebook_lenovo.org"
     "/home/map7/org/business/michael/john_farm.org"
     "/home/map7/org/business/michael/karbon.org"
     "/home/map7/org/business/michael/kenny_lay.org"
     "/home/map7/org/business/michael/kodi.org"
     "/home/map7/org/business/michael/kvm.org"
     "/home/map7/org/business/michael/libreoffice.org"
     "/home/map7/org/business/michael/lodgeit.org"
     "/home/map7/org/business/michael/logicaldoc.org"
     "/home/map7/org/business/michael/ltsp.org"
     "/home/map7/org/business/michael/marks_iga.org"
     "/home/map7/org/business/michael/meshcentral.org"
     "/home/map7/org/business/michael/mobile_apps.org"
     "/home/map7/org/business/michael/mobile_phones.org"
     "/home/map7/org/business/michael/mygovid.org"
     "/home/map7/org/business/michael/myob.org"
     "/home/map7/org/business/michael/nativescript.org"
     "/home/map7/org/business/michael/netflix.org"
     "/home/map7/org/business/michael/network.org"
     "/home/map7/org/business/michael/nucleus.org"
     "/home/map7/org/business/michael/online.com.org"
     "/home/map7/org/business/michael/pais.org"
     "/home/map7/org/business/michael/pais2.2.org"
     "/home/map7/org/business/michael/pais2.3.org"
     "/home/map7/org/business/michael/pais_legacy_invoice.org"
     "/home/map7/org/business/michael/pais_legacy_reporting.org"
     "/home/map7/org/business/michael/pais_legacy_xero.org"
     "/home/map7/org/business/michael/pais_website.org"
     "/home/map7/org/business/michael/paistram.org"
     "/home/map7/org/business/michael/pass.org"
     "/home/map7/org/business/michael/pdfcat.org"
     "/home/map7/org/business/michael/phone.org"
     "/home/map7/org/business/michael/power.org"
     "/home/map7/org/business/michael/practice_protect.org"
     "/home/map7/org/business/michael/printers.org"
     "/home/map7/org/business/michael/privitelli.org"
     "/home/map7/org/business/michael/prusa.org"
     "/home/map7/org/business/michael/publishing_solutions_website.org"
     "/home/map7/org/business/michael/qb_pais_legacy.org"
     "/home/map7/org/business/michael/quickbooks.org"
     "/home/map7/org/business/michael/rails.org"
     "/home/map7/org/business/michael/railscamp.org"
     "/home/map7/org/business/michael/railscamp24.org"
     "/home/map7/org/business/michael/reception_tv.org"
     "/home/map7/org/business/michael/remote_access.org"
     "/home/map7/org/business/michael/remote_working.org"
     "/home/map7/org/business/michael/report_craft.org"
     "/home/map7/org/business/michael/report_craft_marketing.org"
     "/home/map7/org/business/michael/report_craft_rails.org"
     "/home/map7/org/business/michael/roy_lenovo_p14s.org"
     "/home/map7/org/business/michael/scanner.org"
     "/home/map7/org/business/michael/sceona.org"
     "/home/map7/org/business/michael/security.org"
     "/home/map7/org/business/michael/selene.org"
     "/home/map7/org/business/michael/serial_server.org"
     "/home/map7/org/business/michael/spotify.org"
     "/home/map7/org/business/michael/syncthing.org"
     "/home/map7/org/business/michael/tableplus.org"
     "/home/map7/org/business/michael/tarantini_fortuna.org"
     "/home/map7/org/business/michael/ted_kirsh.org"
     "/home/map7/org/business/michael/thinlinc.org"
     "/home/map7/org/business/michael/thunderbird.org"
     "/home/map7/org/business/michael/tramontana.org"
     "/home/map7/org/business/michael/tramontana_backup.org"
     "/home/map7/org/business/michael/tramontana_dash.org"
     "/home/map7/org/business/michael/tramontana_website.org"
     "/home/map7/org/business/michael/uber.org"
     "/home/map7/org/business/michael/ups.org"
     "/home/map7/org/business/michael/venuebat.org"
     "/home/map7/org/business/michael/video_conferencing.org"
     "/home/map7/org/business/michael/webinar.org"
     "/home/map7/org/business/michael/windows.org"
     "/home/map7/org/business/michael/x2go.org"
     "/home/map7/org/business/michael/xero_pais_legacy.org"
     "/home/map7/org/projects/air_conditioner_automation.org"
     "/home/map7/org/projects/air_quality_meter_BME680.org"
     "/home/map7/org/projects/arcade_machine.org"
     "/home/map7/org/projects/auto_cat_feeder.org"
     "/home/map7/org/projects/baby_monitor.org"
     "/home/map7/org/projects/bike_computer.org"
     "/home/map7/org/projects/blind_controller.org"
     "/home/map7/org/projects/bloodbowl_scoreboard.org"
     "/home/map7/org/projects/boombox_amp_music_streamer.org"
     "/home/map7/org/projects/car_computer.org"
     "/home/map7/org/projects/dungeon_crawler.org"
     "/home/map7/org/projects/ebook_reader.org"
     "/home/map7/org/projects/emacs_foot_pedal.org"
     "/home/map7/org/projects/fan_remote_replacement.org"
     "/home/map7/org/projects/game_gear.org"
     "/home/map7/org/projects/garage_door_opener.org"
     "/home/map7/org/projects/garden_monitor.org"
     "/home/map7/org/projects/hack_belkin_wemo.org"
     "/home/map7/org/projects/home_automation.org"
     "/home/map7/org/projects/ip_camera.org"
     "/home/map7/org/projects/ir_blaster.org"
     "/home/map7/org/projects/maqueen_robot.org"
     "/home/map7/org/projects/mentoring.org"
     "/home/map7/org/projects/metal_warrior.org"
     "/home/map7/org/projects/mlug_video_recorder.org"
     "/home/map7/org/projects/mruby_electronics.org"
     "/home/map7/org/projects/mycroft_assistant.org"
     "/home/map7/org/projects/nas.org"
     "/home/map7/org/projects/neopixel_desk_lights.org"
     "/home/map7/org/projects/nerd_night.org"
     "/home/map7/org/projects/ocpp.org"
     "/home/map7/org/projects/pentesting.org"
     "/home/map7/org/projects/pi_tv_hat.org"
     "/home/map7/org/projects/piano_colour_strip.org"
     "/home/map7/org/projects/pikvm.org"
     "/home/map7/org/projects/port_barrell_level.org"
     "/home/map7/org/projects/power_usage_logging.org"
     "/home/map7/org/projects/radio.org"
     "/home/map7/org/projects/robot_arm.org"
     "/home/map7/org/projects/sick68_kb.org"
     "/home/map7/org/projects/smart_ring.org"
     "/home/map7/org/projects/smart_switch.org"
     "/home/map7/org/projects/temperature_alarm.org"
     "/home/map7/org/projects/template.org"
     "/home/map7/org/projects/tv_hat.org"
     "/home/map7/org/projects/voice_assistant.org"
     "/home/map7/org/projects/weather_station.org"
     "/home/map7/org/projects/wifi_ap.org"))
 '(org-stuck-projects '(":hard/+TODO" ("DONE" "REDUNDANT") nil ""))
 '(package-selected-packages
   '(slime-volleyball i3wm total-lines disk-usage system-packages
                      real-auto-save super-save org
                      mu4e-maildirs-extension goto-gem wgrep rg chess
                      dired-rainbow dired-narrow dired-ranger
                      dired-open dired-hacks-utils edit-indirect
                      pinentry ivy-pass sx backlight mw-thesaurus
                      company-statistics company counsel-org-clock
                      daemons bongo pass symon pocket-reader
                      pulseaudio-control yafolding nov rudel
                      dockerfile-mode treemacs dired-du nlinum-hl
                      pdf-tools spotify counsel-spotify
                      all-the-icons-ivy command-log-mode paperless
                      pacmacs slack crontab-mode tide xkcd
                      use-package-chords use-package flycheck
                      yasnippet yaml-mode web-mode undo-tree
                      twittering-mode tramp-term togetherly
                      switch-window sudo-edit spaceline scss-mode
                      ruby-refactor ruby-end ruby-electric rspec-mode
                      rsense robe rinari rbenv rainbow-mode
                      projectile-rails paradox pallet ox-reveal
                      org2blog org-clock-csv org-cliplink
                      org-attach-screenshot nlinum multiple-cursors
                      multi-term moe-theme markdown-mode magit
                      linum-off jsx-mode js2-mode
                      highlight-parentheses highlight-indentation
                      haml-mode grizzl expand-region enh-ruby-mode
                      diredful dired-details csv-mode coffee-mode
                      circe bpr ansible))
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el")))
 '(paperless-capture-directory "~/paperless/upload")
 '(paperless-root-directory "~/paperless/documents")
 '(paradox-automatically-star t)
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
