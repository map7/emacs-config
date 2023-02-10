;; 2021-My code to count todo items WIP
;;
;; https://github.com/jwiegley/emacs-async
(defun get-date()
  (shell-command-to-string "echo -n $(date +%Y-%m-%d)"))

(defun count-todo-items()
  "Print a message with the number of todo tasks"
  (interactive)
  (async-start

   ;; start
   (lambda ()
     (setq org-agenda-files '("~/org/" "~/org/business/michael" "~/org/projects"))
     (org-todo-list)                     ; List all tasks
     (goto-char (point-min))             ; Goto top
     (goto-line 3)                       ; Ignore headings
     (count-matches "TODO")              ; Return total todos
     )

   ;; finish
   (lambda (todos)
     (setq xbuff (generate-new-buffer "*todo-results*"))

     ;; Join date and todo total tegether
     (setq msg (string-join `("|" ,(get-date) "|" ,(number-to-string todos) "|\n") " "))

     (princ msg xbuff)                  ; Print to the buffer

     (switch-to-buffer xbuff)
     (append-to-file (point-min) (point-max) "~/todos-results.org")
     (kill-buffer xbuff)
     (message "Number of TODOs: %d" todos)) ; Display message
     )
   )

;; Schedule using midnight mode
(require 'midnight)
(midnight-delay-set 'midnight-delay "11:59pm")
(setq midnight-hook nil)                ; Remove clear-buffer-list
(add-hook 'midnight-hook 'count-todo-items)
