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
         '(auto-complete-mode
           auto-revert-mode
           company-mode
           eldoc-mode
           guide-key-mode
           hi-lock-mode
           highlight-parentheses-mode
           hl-line-mode
           isearch-mode
           ivy-mode
           flycheck-mode
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
      
       '(:eval (propertize "%03l" 'face `(:height 1.0)))

       "/"

       ;; Print total number of lines in the buffer
       ;; (Can be slow for buffers with large number of lines eg. org files)
       '(:eval (format "%s"(line-number-at-pos (point-max))))

       ;; Faster option could be to use total-lines.el
       ; the below will look like e.g. "263/947,10  26%"
       ;; '(:eval ((12 "%l" "/" (:eval (format "%d,%d" total-lines (1+ (current-column)))))
       ;;          (-3 "%p"))))

       ;; == Column numbers ==
       "  C:"

       '(:eval (propertize "%03c" 'face `(:height 1.0)))
       
       "  "
       
       ;; == Git branch status ==
       '(vc-mode vc-mode)

	     "  "

       ;; == ERC, ORG Timer, etc ===
	     'mode-line-misc-info

       " "
       ;; == Date (day-month) & Time (24hr)==
       '(:eval (propertize (format-time-string "%d-%b  %H:%M")))
       ))
;;; 101-modeline ends here
