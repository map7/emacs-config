(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/custom")

(load "00common-setup.el")
(load "01ruby.el")	     ; Ruby programming language
(load "02org.el")	     ; Org mode
(load "18auto-complete.el")  ; Auto complete
(load "39smartparens.el")    ; Inserts closing parethesis, tags, end’s
(load "40projectile.el")     ; Manage projects
