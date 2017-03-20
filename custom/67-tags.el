(setq path-to-ctags "/usr/bin/ctags")

(defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )
