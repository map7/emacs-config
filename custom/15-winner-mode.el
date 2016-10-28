(when (fboundp 'winner-mode)
	  (winner-mode 1))

(global-set-key (kbd "s-[") #'winner-undo)
(global-set-key (kbd "s-]") #'winner-redo)
