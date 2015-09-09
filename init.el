;; ;; An attempt to get smart-mode-line working
;; ;; This allows the sml theme to be loaded without questions
;; (custom-set-variables
;;  '(custom-safe-themes (quote ("756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default))))

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/external") ; Plugins not in the repo

;; All custom files have a number at the front so they don't clash with the library files.
(load "00-common-setup.el")
(load "01-org.el")		 ; Org mode
(load "02-ruby.el")		 ; Ruby programming language
(load "03-html-mode.el") ; html mode & json.
(load "04-yasnippet.el")     ; Yasnippets
(load "05-yaml_mode.el")	 ; yaml mode.
(load "06-rinari.el")		 ; Ruby on rails mode
(load "07-dired-details.el") ; Hide/show details in directory mode
(load "08-ido-mode.el")		 ; IDO mode for moving around dirs & buffers
(load "09-winner-mode.el")	 ; Undo/redo window layouts
(load "10-circe.el")		 ; IRC settings
(load "11-multi-term.el")	 ; Handle multiple terminals in emacs nicely.
(load "12-haml.el")			 ; haml mode
(load "13-css.el")			 ; css mode
(load "14-jinja2.el")		 ; Ansible templates
(load "15-markdown.el")		 ; for md files.
(load "16-sudo-edit.el")	 ; editing files as root
(load "17-rsense.el")		 ; Command Lookup
(load "18-auto-complete.el") ; Auto complete
;; 21/07/2014 disabled due to issues with loading the theme
;; (load "19-smart-mode-line.el")	; Configure the mode line at the bottom
(load "20-epa-file.el")			   ; Encryption
(load "21-coffeescript.el")	 ; Coffeescript mode
(load "22-smex.el")			 ; smex (quick narrow down commands)
(load "23-speedbar.el")		 ; Speedbar customisations
(load "24-guide-key.el")	 ; Show keyboard shortcuts at certian points
(load "25-scss-mode.el")	 ; SCSS mode
(load "26-moz-controller.el")			; Control firefox within emacs
(load "27-real-auto-save.el")     ; Autosave files
(load "28-magit.el")		 ; Git
;; (load "29-save_hooks.el")	 ; Processes to perform on save.
(load "30-rspec_mode.el")       ; Rspec testing mode for ruby projects
(load "31-feature_mode.el")	 ; Cucumber mode for BDD
(load "32-ace_jump.el")      ; Jump around quickly in a file
(load "33-emacs-server.el")	 ; Config relating to emacs server
(load "34-org-expiry.el")    ; Org expiry <-- add created property on todo items
(load "35-discover.el")   ; Discover more of emacs using context menus
(load "36-xml.el")			 ; edit xml files
(load "37-eshell.el")    ; eshell customisations
(load "38-sunshine.el")  ; Weather
;;(load "39-smartparens.el")   ; Inserts closing parethesis, tags, end’s
(load "40-projectile.el")    ; Manage projects
(load "41-rainbow.el")		 ; Highlight colours in scss files
(load "42-robe.el")			 ; Ruby documentation
(load "43-highlight-indentation.el")	; Highlight tabs
(load "44-flyspell.el")					; Spelling
(load "45-multiple-cursors.el")	; Edit multiple lines at the same time.
(load "46-web-mode.el")			; Mixed mode in web frontend
;; (load "47-twittering-mode.el")          ; Twitter client
(load "48-undo-tree.el")		; Undo tree
(load "49-rbenv.el")			; Ruby version manager
(load "50-org2blog.el")		 ; Org2blog mode
(load "51-packages.el")		 ; Package related tasks
(load "52-scroll-settings.el")          ; Settings for scrolling
(load "53-revealjs.el")                 ; Reveal.js settings
(load "54-slime.el")                    ; Slime Superior Lisp Interaction Mode for Emacs
(load "55-org-mobile.el")               ; Org sync with MobileOrg for Android devices

(load "98-mode-line.el")                ; Format my mode line
(load "99-shortcuts.el")                ; Keyboard shortcuts

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-options-version "2.32")
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(jsx-indent-level 2)
 '(max-lisp-eval-depth 3000)
 '(max-specpdl-size 3000)
 '(menu-bar-mode 1)
 '(org-archive-location "~/org/archive/%s_archive::")
 '(rails-ws:default-server-type "mongrel")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service "smtp")
 '(speedbar-show-unknown-files t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(setq user-mail-address "michael@dtcorp.com.au")

