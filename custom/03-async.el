;; Compile packages in the background.
(async-bytecomp-package-mode 1)

;; Allow copying in the background.
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
