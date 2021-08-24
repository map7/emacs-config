(defun map-text-properties (props)
  (let ((plist (caddr props)))
    (while plist
      (put-text-property (1+ (nth 0 props))
                         (1+ (nth 1 props))
                         (car plist)
                         (let ((value (cadr plist)))
                           (cond ((and (consp value)
                                       (stringp (car value)))
                                  (with-temp-buffer
                                    (insert (car value))
                                    (map-text-properties (cdr value))
                                    (buffer-string)))
                                 ((and (consp value) (memq 'marker value))
                                  (let ((marker (set-marker
                                                 (make-marker)
                                                 (cl-loop for i in value
                                                          thereis (and (numberp i) i))
                                                 (get-buffer (mapconcat 'symbol-name (last value) "")))))
                                    (set-marker-insertion-type marker t)
                                    marker))
                                 (t value))))
      (setq plist (cddr plist)))
    (when props
      (map-text-properties (nthcdr 3 props)))))

(defun async-org-agenda-list()
  (interactive)

  (async-start
   ;; What to do in the child process
   (lambda ()
     (require 'org-agenda)
     (setq org-agenda-files '("~/org/" "~/org/business/michael" "~/org/projects"))
     (org-agenda-list)
     (buffer-string))

   ;; What to do when it finishes
   (lambda (result)
     (require 'org-agenda)
     (switch-to-buffer-other-window "*Org Agenda ASYNC*")
     ;; In this example, we have only one file in org-agenda-files, but
     ;; we can assume user will want to use the same value of
     ;; org-agenda-files both in parent and child so we can loop in
     ;; org-agenda-files to open all org buffer (org is doing this when
     ;; calling org-agenda).
     (find-file-noselect "~/tmp/test.org")
     (insert (car result))
     (map-text-properties (cdr result))
     (org-agenda-mode))))

(global-set-key (kbd "s-a") 'async-org-agenda-list)
