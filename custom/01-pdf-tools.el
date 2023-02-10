;; pdf-tools for viewing PDFs

(use-package pdf-tools
  :init
  (pdf-tools-install)
  ;; Setup a hook when we kill a pdf take a bookmark
  (add-hook 'kill-buffer-hook 'kill-buffer-hook-setup)
  (pdf-view-midnight-colors '("white smoke" . "black"))
  :config
  ;; Set a bookmark on kill
  (defun kill-buffer-hook-setup ()
    ;; Test that we have a filename and file extensions and it's a pdf and the user
    ;; wants to take a bookmark
    (if (and buffer-file-name
             (file-name-extension buffer-file-name)
             (string= (downcase (file-name-extension buffer-file-name)) "pdf")
             (y-or-n-p "Set bookmark with current file name?"))
        ;; Set a bookmark with the name being the buffers full path name
        (bookmark-set (file-name-nondirectory buffer-file-name) nil))))
