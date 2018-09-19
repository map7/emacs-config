;; 
;; Rename this to ~/.emacs.randr.el to use.
;; 
(defun local-monitors ()
    "Setup 3 monitors for my work thin client"
  (setq exwm-randr-workspace-output-plist '(0 "HDMI2" 1 "HDMI3" 2 "HDMI2" 3 "DP1" 4 "HDMI3" 5 "DP1" 6 "HDMI3" 7 "DP1"))
  (add-hook 'exwm-randr-screen-change-hook
	          (lambda ()
	            (start-process-shell-command
	             "xrandr" nil "xrandr --output DP1 --right-of HDMI2 --output HDMI2 --auto --output HDMI3 --left-of HDMI2 --output HDMI3 --auto")))
  )

(defun remote-monitors ()
    "Setup monitors for dual screen X2go remote session"
  (setq exwm-randr-workspace-output-plist '(0 "NX1" 1 "NX2" 2 "NX1" 3 "NX2"))
  (add-hook 'exwm-randr-screen-change-hook
	          (lambda ()
	            (start-process-shell-command
	             "xrandr" nil "xrandr --output NX1 --right-of NX2 --output NX2 --auto NX1 --output --auto")))
  )
;; Randr Function
(defun change-monitors (string)
  "Change the monitor setup"
  (interactive "*sAre you working remote? ")
  (if (equal string "y")
      (list (message "REMOTE screen selected")
       (remote-monitors))
    
    (list (message "LOCAL selected")
     (local-monitors)))
  (exwm-randr-enable)
  )

(call-interactively 'change-monitors)

