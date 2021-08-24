;; Setup external directory variable
(setq elisp-external-dir
    (expand-file-name "external" user-emacs-directory))

;; Add external projects to load path
(add-to-list 'load-path elisp-external-dir)

(dolist (project (directory-files elisp-external-dir t "\\w+"))
  (when (file-directory-p project)
  (add-to-list 'load-path project)))
