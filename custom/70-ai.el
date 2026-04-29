;; March, 2026 - Claude Code Integration

;; install required inheritenv dependency:
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

;; for eat terminal backend:
(use-package eat :ensure t)

;; for vterm terminal backend:
(use-package vterm :ensure t)

;; install claude-code.el
(use-package monet
  :vc (:url "https://github.com/stevemolitor/monet"
       :rev :newest))

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el"
       :rev :newest)
  :after monet
  :config
  (add-hook 'claude-code-process-environment-functions
            #'monet-start-server-function)
  (setq claude-code-display-window-fn #'claude-code-display-buffer-right)
  (setq claude-code-program-switches '("--channels" "plugin:telegram@claude-plugins-official"))
  (monet-mode 1)
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map)
  )

(defun my/claude-code-eat-keep-at-bottom (windows)
  "Keep Claude buffer scrolled to the bottom during output.
WINDOWS is a list of windows or the symbol `buffer'."
  (dolist (window windows)
    (if (eq window 'buffer)
        (goto-char (eat-term-display-cursor eat-terminal))
      (let ((cursor-pos (eat-term-display-cursor eat-terminal)))
        (set-window-point window cursor-pos)
        (with-selected-window window
          (goto-char cursor-pos)
          (recenter -4))))))

(advice-add 'claude-code--eat-synchronize-scroll :override #'my/claude-code-eat-keep-at-bottom)

(defun claude-code-display-buffer-right (buffer)
  "Display the Claude Code BUFFER to the right of the current window.
If a window already exists to the right, reuse it instead of splitting."
  (let ((right-window (window-in-direction 'right)))
    (if right-window
        (window--display-buffer buffer right-window 'reuse nil)
      (display-buffer buffer '((display-buffer-in-direction)
                               (direction . right)
                               (window-width . 0.5))))))


;; (use-package claude-code :ensure t
;;   :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
;;   :config
;;   ;; optional IDE integration with Monet
;;   (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
;;   (monet-mode 1)

;;   (claude-code-mode)
;;   :bind-keymap ("C-c c" . claude-code-command-map)

;;   ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
;;   :bind
;;   (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))

;; --------------------------------------------------------------------------------
;; c3po was the first interaction I got with ChatGPT in Emacs
(use-package c3po
  :straight (:host github :repo "d1egoaz/c3po.el"))

(when (file-exists-p "~/.emacs.c3po.el")
    (load "~/.emacs.c3po.el"))  ; Email settings


;; gptel is a LLM chat client for Emacs which handles heaps of models & backends.
(straight-use-package 'gptel)

;; (use-package gptel-watch
;;   :after gptel
;;   :config
;;   (gptel-watch-global-mode 1))  ;; Optional: enable globally

(when (file-exists-p "~/.emacs.gptel.el")
  (load "~/.emacs.gptel.el"))

;; ;; --------------------------------------------------------------------------------
;; ;; gptel
;; ;; Is a LLM chat client for Emacs which handles heaps of models & backends.

;; (use-package gptel
;;   :ensure t
;;   :config
;;   (setq gptel-api-key
;;         (let ((auth-info (car (auth-source-search
;;                                :host "api.openai.com"
;;                                :user "openai"
;;                                :require '(:user :secret)))))
;;           (message "Auth info: %S" auth-info)  ;; Debug print
;;           (when auth-info
;;             (let ((secret (plist-get auth-info :secret)))
;;               (if (functionp secret)
;;                   (funcall secret)
;;                 secret)))))
;;   :bind ("C-c g" . 'gptel)
;;   )

;; ;; Llamafile
;; (setq
;;  gptel-model   'test
;;  gptel-backend (gptel-make-openai "llama-cpp"
;;                  :stream t
;;                  :protocol "http"
;;                  :host "localhost:8080"
;;                  :models '(test)))


;; ;; --------------------------------------------------------------------------------
;; ;; Ellama
;; (use-package ellama
;;   :ensure t
;;   :bind ("C-c e" . ellama)
;;   ;; send last message in chat buffer with C-c C-c
;;   :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
;;   :init (setopt ellama-auto-scroll t)
;;   :config
;;   ;; show ellama context in header line in all buffers
;;   (ellama-context-header-line-global-mode +1)
;;   ;; show ellama session id in header line in all buffers
;;   (ellama-session-header-line-global-mode +1))

;; ;; --------------------------------------------------------------------------------
;; ;; aider [18/07/2025]
;; ;; --------------------------------------------------------------------------------
;; (use-package aider
;;   :after transient
;;   :config
;;   ;; ;; For latest claude sonnet model
;;   ;; (setq aider-args '("--model" "sonnet" "--no-auto-accept-architect")) ;; add --no-auto-commits if you don't want it
;;   ;; (setenv "ANTHROPIC_API_KEY" anthropic-api-key)
;;   ;; Or chatgpt model
;;   (setq aider-args '("--model" "o4-mini"))
;;   (if (file-exists-p "~/.emacs.aider.el")
;;       ;; (setenv "OPENAI_API_KEY" <your-openai-api-key>)
;;       (load "~/.emacs.aider.el") 
;;   )
  
;;   ;; (setenv "OPENAI_API_KEY" <your-openai-api-key>)
;;   ;; Or use your personal config file
;;   ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
;;   ;; ;;
;;   ;; Optional: Set a key binding for the transient menu
;;   ;;(global-set-key (kbd "C-c a") 'aider-transient-menu) ;; for wider screen
;;   (global-set-key (kbd "s-a") 'aider-transient-menu) ;; for wider screen
;;   ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
;;   (aider-magit-setup-transients) ;; add aider magit function to magit menu
;;   ;; auto revert buffer
;;   (global-auto-revert-mode 1)
;;   (auto-revert-mode 1))
