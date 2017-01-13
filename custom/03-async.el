(use-package async
  :init
  (async-bytecomp-package-mode 1)  ;; Compile packages in the background.
  :defer 5
  :config
  ;; Allow copying in the background.
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

