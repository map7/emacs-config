(use-package haml-mode)
;; haml
(require 'haml-mode nil 't)
 (add-hook 'haml-mode-hook
  '(lambda () (setq tab-width 2)))

; html2haml function to convert current buffer to haml
(defun haml-ify ()
  "run html2haml on current buffer"
  (interactive)
  (setf filename buffer-file-name)
  (setf newfilename (concat filename ".haml"))
  (save-buffer)
  (shell-command (concat
	"html2haml " filename " > " newfilename))
  (kill-buffer (current-buffer))
  (delete-file filename)
  (find-file newfilename))
