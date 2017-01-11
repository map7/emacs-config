;; Resizing splits
;; Resizing splits
(defun win-resize-up ()
  (interactive)
  (enlarge-window 7))

(defun win-resize-right ()
  (interactive)
  (enlarge-window-horizontally 7))

(defun win-resize-down ()
  (interactive)
  (shrink-window 7))

(defun win-resize-left ()
  (interactive)
  (shrink-window-horizontally 7))

(global-set-key [C-s-right] 'win-resize-right)
(global-set-key [C-s-up] 'win-resize-up)
(global-set-key [C-s-down] 'win-resize-down)
(global-set-key [C-s-left] 'win-resize-left)

