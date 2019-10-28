;; Tell emacs where the theme is
(setq custom-theme-directory "~/.emacs.d/themes")

;; Trust custom themes
(setq custom-safe-themes t)

;; Create theme toggle function
(setq my/themes '(customizable-light customizable-dark))
(setq my/themes-index 0)

(defun my/cycle-theme ()
  (interactive)
  (setq my/themes-index (% (1+ my/themes-index) (length my/themes)))
  (my/load-indexed-theme))

(defun my/load-indexed-theme ()
  (my/try-load-theme (nth my/themes-index my/themes)))

(defun my/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

;; Set theme toggle shortcut key
(global-set-key (kbd "s-t") 'my/cycle-theme)

;; Load theme toggle function & load theme (loads 0th position theme in my/themes list)
(my/load-indexed-theme)
