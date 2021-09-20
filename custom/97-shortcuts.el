;; General shortcut keys

;; ;; Remap hyper key as super
;; (setq x-hyper-keysym 'super)
;
; Examples
; http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
;
; C-<f12> = Use control function keys
; s-h     = Use windows key (super), this example is super & h
;

; Keybinding (Keyboard shortcuts)
;;(global-set-key [f1] 'rotate-windows)
;;(global-set-key [f2] 'gist-region-or-buffer)
(global-set-key [f2] 'org-clock-report)
(global-set-key [f3] 'twit)
(global-set-key [f4] 'magit-log-all)
(global-set-key [f5] 'magit-status)
(global-set-key [f6] 'multi-term)
(global-set-key [f7] 'split-window-vertically)
(global-set-key [f8] 'other-window)
;; f9 is taken by git-status somewhere.
(global-set-key [f10] 'undo-tree-visualize)
(global-set-key [f12] 'switch-full-screen)

;; key bindings for dictionary
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)

;; Expand region shortcut
(global-set-key (kbd "C-=") 'er/expand-region)

;; Using 's' for work computer and 'H' for notebook as there is a
;; difference in mapping the super key.
(global-set-key (kbd "C-S-e") 'eval-buffer)

(global-set-key (kbd "s-RET") 'google-maps)

(global-set-key (kbd "C-c I") 'irc)

;; Speed up common functions
(global-set-key (kbd "s-`") 'switch-window)
(global-set-key (kbd "M-<tab>") 'other-window)
;; (global-set-key (kbd "s-1") 'delete-other-windows)
;; (global-set-key (kbd "s-2") 'split-window-vertically)
;; (global-set-key (kbd "s-3") 'split-window-horizontally)

;; Unset minimize so I stop hitting it
(global-unset-key (kbd "C-x C-z"))

;; Allow using mouse thumb button to browse URLs
(global-set-key [mouse-10] 'browse-url-at-mouse)

;; rotate windows (Defined in common-setup)
(load "rotate-windows.el")
(global-set-key (kbd "C-<tab>") 'rotate-windows)

;; Paste a link into an org file.
(global-set-key (kbd "C-x p i") 'org-cliplink)

;; Duplicate whole line
(global-set-key (kbd "\C-c\C-k") 'copy-line)

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Stay at current position.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (arg (1+ arg) 2)
  (if (arg (not (= 1 arg))) (message "%d lines copied" arg)))



;; Expanding & Hiding org mode sections
(global-set-key (kbd "s-,") 'hide-sublevels)
(global-set-key (kbd "s-.") 'show-all)


;; Toggle
;;(global-set-key (kbd "s-t") 'exwm-input-toggle-keyboard)

;; find and replace
(global-set-key (kbd "s-r") 'find-name-dired)

;; tab
(global-set-key (kbd "s-<tab>") 'indent-rigidly)
