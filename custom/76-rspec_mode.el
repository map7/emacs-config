(use-package rspec-mode
  :defer 5
  :config
  (setq rspec-use-rvm nil)
  (setq rspec-use-bundler-when-possible t)
  (setq rspec-use-rake-flag nil)
  (setq rspec-spec-command "rspec")
  (setq compilation-scroll-output t))

