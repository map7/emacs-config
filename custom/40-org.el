;; Org mode shortcuts
(global-set-key (kbd "C-c C-x C-v") 'do-org-show-all-inline-images)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "s-h") 'puborg)
(global-set-key (kbd "s-i") 'org-clock-in)
(global-set-key (kbd "s-o") 'org-clock-out)

;; Org-mode options
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-directory "~/org")
(setq org-agenda-files '("~/org/" "~/org/business" "~/org/projects"))

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
