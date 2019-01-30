;; Automatically save (replacement for real-auto-save as we believe it maybe freezing our emacs 29/01/2019)
;; 31/01/2019 - Not using due to this bug: https://github.com/bbatsov/super-save/issues/23
(use-package super-save
  :ensure t
  :config
  (setq super-save-auto-save-when-idle t)
  (setq auto-save-default nil)
  (super-save-mode +1)
  (add-to-list 'super-save-hook-triggers 'find-file-hook))
