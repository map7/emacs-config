;; Modeline --- Creates custom modeline
;;; Commentary:
;;; Code:

(setq-default mode-line-format
      (list "%e"

       'modeline-front-space
       
       ;; == Buffer coding system ==
       'mode-line-mule-info

       ;; == Buffer modified? ==
       'mode-line-modified

       "  "
       ;; == Buffer name ==
       ;; gray & bold as set by font mode-line-buffer-id
       '(:eval (propertize " %b " 'face `(:weight bold)
                           'help-echo (buffer-file-name)))

       " "

       ;; == Major & Minor Modes =
       'mode-line-modes

       ;; == Hide all minor modes ;; Thanks to Mark Karpov for this code snippet ==
       (defvar hidden-minor-modes ; example, write your own list of hidden
         '(abbrev-mode
           auto-fill-mode
           auto-complete-mode
           auto-revert-mode
           auto-revert-tail-mode
           company-mode
           eldoc-mode
           glasses-mode
           guide-key-mode
           hi-lock-mode
           hide-ifdef-mode
           highlight-changes-mode
           highlight-indentation-mode
           highlight-parentheses-mode
           hl-line-mode
           isearch-mode
           ivy-mode
           flyspell-mode
           font-lock-mode
           outline-mode
           paredit-mode
           projectile-mode
           projectile-rails-mode
           real-auto-save-mode
           rinari-minor-mode
           robe-mode
           rspec-mode
           ruby-end-mode
           ruby-refactor-mode
           undo-tree-mode
           visual-line-mode
           yas-minor-mode))

       (defun purge-minor-modes ()
         (interactive)
         (dolist (x hidden-minor-modes nil)
           (let ((trg (cdr (assoc x minor-mode-alist))))
             (when trg
               (setcar trg "")))))

       (add-hook 'after-change-major-mode-hook 'purge-minor-modes)

       " "
       
       ;; == Line numbers ==
       ;; grey & normal as set by font mode-line
       ;; '%03' to set to 3 chars at least; prevents flickering
       " L:"
       
       ;; Faster option could be to use total-lines.el
       ; the below will look like e.g. "263/947,10  26%"
       `((12 "%l" "/" (:eval (format "%d,%d" total-lines (1+ (current-column))))))

       ;; == Git branch status ==
       '(vc-mode vc-mode)

	     "  "

       ;; == ERC, ORG Timer, etc ===
	     'mode-line-misc-info

       " "
       ;; == Date (day-month) & Time (24hr)==
       ;; '(:eval (propertize (format-time-string "%d-%b  %H:%M")))
       ))

;; Update the time in all buffers every 60 seconds.
(run-at-time "60 sec" 60 #'force-mode-line-update "Update clock.")

;;; 101-modeline ends here
