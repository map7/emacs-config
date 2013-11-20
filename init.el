(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/custom")

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
(load "17-rsense.el")		 ; Command Lookup
(load "18-auto-complete.el") ; Auto complete
(load "19-smart-mode-line.el")	; Configure the mode line at the bottom
(load "21-coffeescript.el")	 ; Coffeescript mode
(load "22-smex.el")			 ; smex (quick narrow down commands)
(load "23-speedbar.el")		 ; Speedbar customisations
(load "28-magit.el")		 ; Git
(load "29-save_hooks.el")	 ; Processes to perform on save.
(load "30-rspec_mode.el")	 ; Rspec testing mode for ruby projects
(load "31-feature_mode.el")	 ; Cucumber mode for BDD
(load "32-ace_jump.el")		 ; Jump around quickly in a file
(load "36-xml.el")			 ; edit xml files
(load "39-smartparens.el")   ; Inserts closing parethesis, tags, end’s
(load "40-projectile.el")    ; Manage projects
(load "41-rainbow.el")		 ; Highlight colours in scss files
(load "42-robe.el")			 ; Ruby documentation
(load "43-highlight-indentation.el")	; Highlight tabs
(load "44-flyspell.el")					; Spelling
(load "45-multiple-cursors.el")	; Edit multiple lines at the same time.
(load "46-web-mode.el")			; Mixed mode in web frontend
(load "47-twittering-mode.el")	; Twitter client
(load "48-undo-tree.el")		; Undo tree
(load "49-rbenv.el")			; Ruby version manager
