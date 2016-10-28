(require 'flyspell)
(setq flyspell-issue-message-flg nil)
(setq ispell-dictionary "british")

(add-hook 'enh-ruby-mode-hook
          (lambda () (flyspell-prog-mode)))

(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))

(add-hook 'coffee-mode-hook
	  (lambda () (flyspell-prog-mode)))

(add-hook 'org-mode-hook
	  (lambda () (flyspell-prog-mode)))


(add-hook 'haml-mode-hook
	  (lambda () ('flymake-haml-load)))


;; flyspell mode breaks auto-complete mode without this.
;;(ac-flyspell-workaround)
