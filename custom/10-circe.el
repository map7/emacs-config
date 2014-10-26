;; IRC reconnect
(eval-after-load 'rcirc
  '(defun-rcirc-command reconnect (arg)
	 "Reconnect the server process."
	 (interactive "i")
	 (unless process
	   (error "There's no process for this target"))
	 (let* ((server (car (process-contact process)))
		(port (process-contact process :service))
		(nick (rcirc-nick process))
		channels query-buffers)
	   (dolist (buf (buffer-list))
	 (with-current-buffer buf
	   (when (eq process (rcirc-buffer-process))
		 (remove-hook 'change-major-mode-hook
			  'rcirc-change-major-mode-hook)
		 (if (rcirc-channel-p rcirc-target)
		 (setq channels (cons rcirc-target channels))
		   (setq query-buffers (cons buf query-buffers))))))
	   (delete-process process)
	   (rcirc-connect server port nick
			  rcirc-default-user-name
			  rcirc-default-full-name
			  channels))))

;; Shortcut to connect to IRC
(defun irc ()
  "Connect to IRC"
  (interactive)
  (circe "Freenode"))

;; Enable chanop commands
(eval-after-load 'circe '(require 'circe-chanop))

;; Circe (IRC) configuration
;; Put your configuration in a ~/.private.el file with permissions 0600
(if (file-exists-p "~/.private.el")
	(load-file "~/.private.el"))

(if (file-exists-p "~/.private.el")
  (setq circe-network-options
		`(("Freenode"
		   :nick ,freenode-user
		   :channels ("#ltsp" "#angularjs" "#roro" "#luv" "#mlug-au")
		   :nickserv-password ,freenode-password
		   )))
)

;; Filter out some of the crap join,part & quit messages for lurkers
(setq circe-reduce-lurker-spam t)

;; Channel Name in the Prompt				
(add-hook 'circe-chat-mode-hook 'my-circe-prompt)
(defun my-circe-prompt ()
  (lui-set-prompt
   (concat (propertize (concat (buffer-name) ">")
                       'face 'circe-prompt-face)
           " ")))

;; Setup a shortcut '/j' like xchat has.
(defun circe-command-J (&optional channel)
  (circe-command-JOIN channel))

(setq lui-flyspell-p t
        lui-flyspell-alist '(("#hamburg" "german8")
                             (".*" "american")))
