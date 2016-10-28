;; Sync with my mobile phone.
(global-set-key (kbd "s-u") 'org-mobile-push)
(setq org-mobile-directory "~/org_mobile")         ;; Set to ~/MobileOrg (This is linked to my Dropbox).
(setq org-mobile-inbox-for-pull "~/org/inbox.org");; new notes will be stored here

;; Automatically push changes for mobile phone
(defvar org-mobile-push-timer nil
  "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")

(defun org-mobile-push-with-delay (secs)
  (when org-mobile-push-timer
	(cancel-timer org-mobile-push-timer))
  (setq org-mobile-push-timer
		(run-with-idle-timer
		 (* 1 secs) nil 'org-mobile-push)))

;; mobile org options
;; http://kenmankoff.com/2012/08/17/emacs-org-mode-and-mobileorg-auto-sync
;;

;; TODO - put this into the background somehow.
;; (add-hook 'after-save-hook
;;  (lambda ()
;;    (when (eq major-mode 'org-mode)
;;      (dolist (file (org-mobile-files-alist))
;;        (if (string= (expand-file-name (car file)) (buffer-file-name))
;;            (org-mobile-push-with-delay 10)))
;;    )))

;; This runs directly after you start emacs, it takes too long.
;; (run-at-time "00:05" 86400 '(lambda () (org-mobile-push-with-delay 1))) ;; refreshes agenda file each day
