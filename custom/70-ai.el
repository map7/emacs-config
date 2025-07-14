;; --------------------------------------------------------------------------------
;; c3po was the first interaction I got with ChatGPT in Emacs
(use-package c3po
  :straight (:host github :repo "d1egoaz/c3po.el"))

(when (file-exists-p "~/.emacs.c3po.el")
    (load "~/.emacs.c3po.el"))  ; Email settings


;; gptel is a LLM chat client for Emacs which handles heaps of models & backends.
(straight-use-package 'gptel)

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


;; --------------------------------------------------------------------------------
;; Ellama
(use-package ellama
  :ensure t
  :bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init (setopt ellama-auto-scroll t)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode +1))

