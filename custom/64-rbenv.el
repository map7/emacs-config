(use-package rbenv
  :init
  (setq rbenv-installation-dir "/usr/local/rbenv") ; Global install
  :defer 5
  :config
  (global-rbenv-mode))

