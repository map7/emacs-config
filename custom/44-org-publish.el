;; org publish options

(setq org-publish-project-alist
	  '(
		;; ... add all the components here (see below)...

		;; All org files (notes)
		("org-notes"
		 :base-directory "~/org/business"
		 :base-extension "org"
		 :publishing-directory "/var/www/manual/"
		 :style "<link rel=\"stylesheet\" href=\"css/stylesheet.css\" type=\"text/css\" />"
		 :recursive f
		 :publishing-function org-html-publish-to-html
		 :headline-levels 4             ; Just the default for this project.
		 :auto-preamble t
		 :html-head "<link rel=\"stylesheet\" href=\"css/stylesheet.css\" type=\"text/css\" />"
		 )

		;; Attachments
		("org-static"
		 :base-directory "~/org/"
		 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|htaccess"
		 :publishing-directory "/var/www/manual/"
		 :recursive t
		 :publishing-function org-publish-attachment
		 )

		;; Publish component
		("org"
     :components ("org-notes" "org-static"))

	  ))

 '(org-stuck-projects (quote ("hard" ("REDUNDANT" "DONE" "NEXT" "NEXTACTION") nil "")))

; Create a little function to run publish mode in a shortcut
(defun puborg ()
  (interactive)
  (setq org-export-with-broken-links 't)
  (org-publish-project "org")
)

