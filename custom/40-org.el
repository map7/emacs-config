(use-package org-attach-screenshot :ensure t :defer 5)

;; Org mode shortcuts
(global-set-key (kbd "C-c C-x C-v") 'do-org-show-all-inline-images)
(global-set-key (kbd "C-c C-x C-r") 'org-clock-report)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "s-h") 'puborg)
(global-set-key (kbd "s-i") 'org-clock-in)
(global-set-key (kbd "s-o") 'org-clock-out)

;; Org-mode options
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-directory "~/org")
(setq org-agenda-files '("~/org/" "~/org/business/michael" "~/org/projects"))
;; Format the time in clock tables.
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))

(setq org-list-allow-alphabetical t)

;; Display inline images
(defun do-org-show-all-inline-images ()
  (interactive)
  (org-display-inline-images t t))

;; Assign mode to .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))


;; Set more workflow states than TODO
(setq org-todo-keywords
	  '((sequence "TODO(t)" "|" "DONE(d)" "REDUNDANT(r)" )
		(sequence "DELEGATED(<)" "|" "DONE(d)")
		(sequence "GONNA(g)" "|" "DONE(d)" )))

(setq org-support-shift-select t)


;; Put email links in org mode :) - currently broken :(
;; (setq ffap-url-regexp (replace-regexp-in-string "mailto:" "thunderlink: \ \ \ \ | mailto:" ffap-url-regexp));; for ThunderLink

;;  (defun browse-url-thunderlink (url & optional new-window)
;;    (interactive (browse-url-interactive-arg "URL:"))
;;    (if (string-match "^ thunderlink ://" url)
;;        (progn
;;          (start-process (concat "thunderbird" url) nil "thunderbird" "-thunderlink" url)
;;          t)
;;      nil)
;;    )
;; (unless (listp browse-url-browser-function) (setq browse-url-browser-function (list (cons "." browse-url-browser-function))))
;; (add-to-list 'browse-url-browser-function' ("^ thunderlink:". browse-url-thunderlink))

;; (add-hook 'org-load-hook
;;             '(lambda ()
;;                (add-to-list 'org-link-types "thunderlink")
;;                (org-make-link-regexps)
;;                (add-hook 'org-open-link-functions' browse-url-thunderlink)
;;                ))

;; Set archive location
(setq org-archive-location "~/org/archive/%s_archive::")

;; Custom searches
(setq org-agenda-custom-commands
      '(("Q" . "Custom queries") ;; gives label to "Q"
        ("Qa" "Archive search" search ""
         ((org-agenda-files (file-expand-wildcards "~/org/archive/*.org_archive"))))
        ;; ("Qw" "Website search" search ""
        ;;  ((org-agenda-files (file-expand-wildcards "~/website/*.org"))))
        ("Qb" "Projects and Archive" search ""
         ((org-agenda-text-search-extra-files (file-expand-wildcards "~/org/archive/*.org_archive"))))
        ;; searches both projects and org/archive directories
        ("QA" "Archive tags search" org-tags-view ""
         ((org-agenda-files (file-expand-wildcards "~/org/archive/*.org_archive"))))
        ;; ...other commands here
        ))

;; Display images inline automatically
(setq org-startup-with-inline-images t)

(defun org-clock-sum-agenda-today ()
  "Visit each file in `org-agenda-files' and return the total time of today's clocked tasks in minutes."
  (interactive)
  (let ((files (org-agenda-files))
        (total 0))
    (org-agenda-prepare-buffers files)
    (dolist (file files)
      (with-current-buffer (find-buffer-visiting file)
        (setq total (+ total (org-clock-sum-today)))))
    (message "Hours clocked for the day: %s" (/ total 60))))

;; Sorts the tables by time, largest to smallest
;;
;; example of clocktable line;
;; #+BEGIN: clocktable :maxlevel 1 :block today :scope agenda-with-archives :link t :stepskip0 t :fileskip0 t :formula % :formatter my-org-clocktable-sorter
(defun my-org-clocktable-sorter (ipos tables params)
  (setq tables (cl-sort tables (lambda (table1 table2) (> (nth 1 table1) (nth 1 table2)))))
  (funcall (or org-clock-clocktable-formatter 'org-clocktable-write-default) ipos tables params))

;; WIKI
;; (add-to-list 'load-path "/home/map7/.emacs.d/external/org-ehtml/src")
;; (require 'org-ehtml)
;; (setq org-ehtml-docroot (expand-file-name "~/org/business"))
;; (setq org-ehtml-everything-editable t)
;; (ws-start org-ehtml-handler 8888 nil :host "0.0.0.0")
(use-package web-server :ensure t)
(use-package org-ehtml
  :ensure t
  :config
  (setq org-ehtml-docroot (expand-file-name "~/org/business"))
  (setq org-ehtml-everything-editable t)
  (ws-start org-ehtml-handler 8888 nil :host "0.0.0.0"))


;;  Currently broken on second commit.
;; ;; Autocommit changes made through org-ehtml
;; (require 'vc)
;; (defun commit-ehtml-edit (request)
;;   (let ((file (buffer-file-name (current-buffer))))
;;     (vc-checkin (list file)
;;                 (vc-backend file) "edit through org-ehtml")))

;; (add-hook 'org-ehtml-after-save-hook 'commit-ehtml-edit)

(load "count-todo")
(load "async-agenda")
