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

(global-set-key [s-right] 'win-resize-right)
(global-set-key [s-up] 'win-resize-up)
(global-set-key [s-down] 'win-resize-down)
(global-set-key [s-left] 'win-resize-left)

