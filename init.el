(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/custom")

(load "00-common-setup.el")
(load "01-ruby.el")	     ; Ruby programming language
(load "02-org.el")	     ; Org mode
(load "04-yasnippet.el")     ; Yasnippets
(load "06-rinari.el")	     ; Ruby on rails mode
(load "18-auto-complete.el") ; Auto complete
(load "39-smartparens.el")   ; Inserts closing parethesis, tags, end’s
(load "40-projectile.el")    ; Manage projects
(load "41-rainbow.el")	     ; Highlight colours in scss files
(load "42-robe.el")	     ; Ruby documentation
(load "43-highlight-indentation.el")	; Highlight tabs
(load "44-flyspell.el")			; Spelling

