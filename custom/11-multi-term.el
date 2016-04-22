(setq multi-term-program "/bin/zsh")

(global-set-key (kbd "C-x <up>") 'multi-term-next)
(global-set-key (kbd "C-x <down>") 'multi-term-prev)

;; Fix UTF8 characters in terminals
(add-hook 'multi-term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))
