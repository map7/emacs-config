;; c3po was the first interaction I got with ChatGPT in Emacs
(use-package c3po
  :straight (:host github :repo "d1egoaz/c3po.el"))

(if (file-exists-p "~/.emacs.c3po.el")
    (load "~/.emacs.c3po.el")  ; Email settings
)

;; gptel is a LLM chat client for Emacs which handles heaps of models & backends.
(straight-use-package 'gptel)

(if (file-exists-p "~/.emacs.gptel.el")
    (load "~/.emacs.gptel.el") 
)

;; Llamafile
(setq
 gptel-model   'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "localhost:8080"
                 :models '(test)))
